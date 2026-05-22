import 'translate_platform_interface.dart';

class Translate {
  const Translate._();

  static Future<void> translateText(String text) {
    return TranslatePlatform.instance.translateText(text);
  }
}
