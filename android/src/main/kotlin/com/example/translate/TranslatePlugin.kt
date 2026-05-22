package com.example.translate

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TranslatePlugin */
class TranslatePlugin :
    FlutterPlugin,
    MethodCallHandler,
    ActivityAware {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "translate")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "translateText" -> translateText(call, result)
            else -> result.notImplemented()
        }
    }

    private fun translateText(call: MethodCall, result: Result) {
        val text = call.argument<String>("text")?.trim().orEmpty()

        if (text.isEmpty()) {
            result.error("invalid_text", "Missing text.", null)
            return
        }

        val currentActivity = activity
        if (currentActivity == null) {
            result.error("no_activity", "No activity is attached.", null)
            return
        }

        try {
            val intent = Intent(Intent.ACTION_SEND).apply {
                type = "text/plain"
                putExtra(Intent.EXTRA_TEXT, text)
            }
            currentActivity.startActivity(Intent.createChooser(intent, "Translate"))
            result.success(null)
        } catch (exception: Exception) {
            result.error(
                "translation_unavailable",
                "No app is available to translate or share this text.",
                exception.localizedMessage
            )
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
