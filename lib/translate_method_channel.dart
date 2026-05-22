import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'translate_platform_interface.dart';

/// An implementation of [TranslatePlatform] that uses method channels.
class MethodChannelTranslate extends TranslatePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('translate');

  @override
  Future<void> translateText(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    await methodChannel.invokeMethod<void>('translateText', {'text': trimmed});
  }
}
