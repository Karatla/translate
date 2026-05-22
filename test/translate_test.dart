import 'package:flutter_test/flutter_test.dart';
import 'package:translate/translate.dart';
import 'package:translate/translate_platform_interface.dart';
import 'package:translate/translate_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTranslatePlatform
    with MockPlatformInterfaceMixin
    implements TranslatePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TranslatePlatform initialPlatform = TranslatePlatform.instance;

  test('$MethodChannelTranslate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTranslate>());
  });

  test('getPlatformVersion', () async {
    Translate translatePlugin = Translate();
    MockTranslatePlatform fakePlatform = MockTranslatePlatform();
    TranslatePlatform.instance = fakePlatform;

    expect(await translatePlugin.getPlatformVersion(), '42');
  });
}
