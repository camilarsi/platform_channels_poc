package com.example.platform_channels_definitivo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(){

    private val channel = "com.example.platform_channels_poc"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,channel).setMethodCallHandler { call, result ->
            when (call.method){
            "getOsInfo" -> {
                val version = "Android ${android.os.Build.VERSION.RELEASE}"
                result.success(version)
            }
                "getDeviceModelInfo" -> {
                    val modelInfo =  android.os.Build.MODEL.toString()

                    result.success(modelInfo)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
