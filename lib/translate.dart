
import 'translate_platform_interface.dart';

class Translate {
  Future<String?> getPlatformVersion() {
    return TranslatePlatform.instance.getPlatformVersion();
  }
}
