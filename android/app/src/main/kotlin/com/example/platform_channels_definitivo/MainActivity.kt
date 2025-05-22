package com.example.platform_channels_definitivo

import android.app.Activity

import android.content.*
import android.database.Cursor
import android.net.Uri
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.os.PowerManager
import android.provider.MediaStore
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Locale
import java.util.TimeZone
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.platform_channels_poc"
    private val IMAGE_PICK_CODE = 1001
    private var pendingResult: MethodChannel.Result? = null
    private var BATTERY_CHANNEL = "com.example.batteryStream"
    private var batteryReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
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

                "pickImage" -> {
                    pendingResult = result
                    val intent =
                        Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
                    startActivityForResult(intent, IMAGE_PICK_CODE)
                }

                else -> result.notImplemented()
            }

            EventChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                BATTERY_CHANNEL
            ).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        batteryReceiver = object : BroadcastReceiver() {
                            override fun onReceive(context: Context?, intent: Intent?) {
                                val level =
                                    intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
                                events?.success(level)
                            }
                        }
                        val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                        registerReceiver(batteryReceiver, filter)
                    }

                    override fun onCancel(arguments: Any?) {
                        batteryReceiver?.let {
                            unregisterReceiver(it)
                            batteryReceiver = null
                        }
                    }

                }
            )
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == IMAGE_PICK_CODE) {
            if (resultCode == Activity.RESULT_OK && data != null && data.data != null) {
                val imageUri: Uri = data.data!!
                val realPath = getRealPathFromURI(imageUri)

                if (realPath != null) {
                    pendingResult?.success(realPath)
                } else {
                    pendingResult?.error(
                        "PATH_ERROR",
                        "Couldn't resolve image path",
                        null
                    )
                }
            } else {
                pendingResult?.error(
                    "PICK_IMAGE_ERROR",
                    "Image selection failed or cancelled",
                    null
                )
            }
            pendingResult = null
        }
    }

    private fun getRealPathFromURI(uri: Uri): String? {
        val projection = arrayOf(MediaStore.Images.Media.DATA)
        contentResolver.query(uri, projection, null, null, null)?.use { cursor ->
            val columnIndex = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
            if (cursor.moveToFirst()) {
                return cursor.getString(columnIndex)
            }
        }
        return null
    }
}
