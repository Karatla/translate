import Flutter
import SwiftUI
import UIKit

#if canImport(Translation)
import Translation
#endif

public class TranslatePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "translate",
      binaryMessenger: registrar.messenger()
    )
    let instance = TranslatePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "translateText":
      guard
        let arguments = call.arguments as? [String: Any],
        let text = arguments["text"] as? String,
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      else {
        result(FlutterError(code: "invalid_text", message: "Missing text.", details: nil))
        return
      }

      presentTranslation(text: text, result: result)

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func presentTranslation(text: String, result: @escaping FlutterResult) {
    guard let presenter = topViewController() else {
      result(FlutterError(code: "no_presenter", message: "No presenter available.", details: nil))
      return
    }

    #if canImport(Translation)
    if #available(iOS 17.4, *) {
      let view = TranslationOverlayView(text: text)
      let controller = UIHostingController(rootView: view)
      controller.modalPresentationStyle = .overFullScreen
      controller.view.backgroundColor = .clear

      presenter.present(controller, animated: false) {
        result(nil)
      }
      return
    }
    #endif

    result(
      FlutterError(
        code: "translation_unavailable",
        message: "Apple Translation UI is not available on this iOS version.",
        details: nil
      )
    )
  }

  private func topViewController() -> UIViewController? {
    let scene = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .first { $0.activationState == .foregroundActive }

    let root = scene?.windows.first { $0.isKeyWindow }?.rootViewController
      ?? UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController

    return topViewController(from: root)
  }

  private func topViewController(from controller: UIViewController?) -> UIViewController? {
    if let navigation = controller as? UINavigationController {
      return topViewController(from: navigation.visibleViewController)
    }

    if let tab = controller as? UITabBarController {
      return topViewController(from: tab.selectedViewController)
    }

    if let presented = controller?.presentedViewController {
      return topViewController(from: presented)
    }

    return controller
  }
}

#if canImport(Translation)
@available(iOS 17.4, *)
private struct TranslationOverlayView: View {
  let text: String

  @Environment(\.dismiss) private var dismiss
  @State private var isPresented = false

  var body: some View {
    Color.clear
      .ignoresSafeArea()
      .onAppear {
        isPresented = true
      }
      .translationPresentation(isPresented: $isPresented, text: text)
      .onChange(of: isPresented) { _, newValue in
        if !newValue {
          dismiss()
        }
      }
  }
}
#endif
