import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'translate_platform_interface.dart';

/// An implementation of [TranslatePlatform] that uses method channels.
class MethodChannelTranslate extends TranslatePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('translate');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
