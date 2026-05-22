import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:translate/translate_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelTranslate();
  const channel = MethodChannel('translate');
  MethodCall? capturedCall;

  setUp(() {
    capturedCall = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async {
          capturedCall = methodCall;
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('translateText invokes method channel', () async {
    await platform.translateText(' dat ');

    expect(capturedCall?.method, 'translateText');
    expect(capturedCall?.arguments, {'text': 'dat'});
  });
}
