import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:translate/translate.dart';
import 'package:translate/translate_method_channel.dart';
import 'package:translate/translate_platform_interface.dart';

class MockTranslatePlatform
    with MockPlatformInterfaceMixin
    implements TranslatePlatform {
  String? translatedText;

  @override
  Future<void> translateText(String text) async {
    translatedText = text;
  }
}

void main() {
  final initialPlatform = TranslatePlatform.instance;

  test('$MethodChannelTranslate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTranslate>());
  });

  test('translateText delegates to platform', () async {
    final fakePlatform = MockTranslatePlatform();
    TranslatePlatform.instance = fakePlatform;

    await Translate.translateText('dat');

    expect(fakePlatform.translatedText, 'dat');
  });
}
