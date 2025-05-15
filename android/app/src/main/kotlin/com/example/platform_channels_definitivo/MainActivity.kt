package com.example.platform_channels_definitivo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.os.BatteryManager
import android.os.PowerManager
import android.os.Build
import android.provider.Settings
import java.util.Locale
import java.util.TimeZone


class MainActivity : FlutterActivity() {

    private val channel = "com.example.platform_channels_poc"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getFullDeviceInfo" -> {
                    val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                    val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager

                    val info = mapOf(
                        "osVersion" to "Android ${Build.VERSION.RELEASE}",
                        "deviceModel" to Build.MODEL,
                        "manufacturer" to Build.MANUFACTURER,
                        "brand" to Build.BRAND,
                        "androidId" to Settings.Secure.getString(
                            contentResolver,
                            Settings.Secure.ANDROID_ID
                        ),
                        "batteryLevel" to "${batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)}%",
                        "powerSavingMode" to powerManager.isPowerSaveMode.toString(),
                        "language" to Locale.getDefault().language,
                        "timeZone" to TimeZone.getDefault().id
                    )

                    result.success(info)
                }

                else -> result.notImplemented()
            }
        }
    }

}
