package com.example.marvel_app

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()

package com.seu.pacote

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import com.google.firebase.analytics.FirebaseAnalytics

class MainActivity: FlutterActivity() {
    private val CHANNEL = "analytics_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "logEvent") {
                val name = call.argument<String>("name")
                val params = call.argument<Map<String, Any>>("params")
                val firebaseAnalytics = FirebaseAnalytics.getInstance(this)

                val bundle = android.os.Bundle()
                params?.forEach { (key, value) ->
                    when (value) {
                        is String -> bundle.putString(key, value)
                        is Int -> bundle.putInt(key, value)
                        is Double -> bundle.putDouble(key, value)
                        is Boolean -> bundle.putBoolean(key, value)
                    }
                }

                firebaseAnalytics.logEvent(name ?: "event", bundle)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}
