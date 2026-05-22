import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'translate_method_channel.dart';

abstract class TranslatePlatform extends PlatformInterface {
  /// Constructs a TranslatePlatform.
  TranslatePlatform() : super(token: _token);

  static final Object _token = Object();

  static TranslatePlatform _instance = MethodChannelTranslate();

  /// The default instance of [TranslatePlatform] to use.
  ///
  /// Defaults to [MethodChannelTranslate].
  static TranslatePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TranslatePlatform] when
  /// they register themselves.
  static set instance(TranslatePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> translateText(String text) {
    throw UnimplementedError('translateText() has not been implemented.');
  }
}
