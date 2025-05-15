import UIKit
import Flutter

import Foundation

@main
@objc class AppDelegate: FlutterAppDelegate {

  private let channelName = "com.example.platform_channels_poc"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

      switch call.method {
      case "getFullDeviceInfo":
          result(self.getFullDeviceInfo())
      default:
          result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getFullDeviceInfo() -> [String: Any] {
      var info: [String: Any] = [:]


      info["osVersion"] = UIDevice.current.systemName + " " + UIDevice.current.systemVersion


      info["deviceModel"] = UIDevice.current.model
      info["manufacturer"] = "Apple"
      info["brand"] = "Apple"

      if let id = UIDevice.current.identifierForVendor?.uuidString {
          info["deviceId"] = id
      } else {
          info["deviceId"] = "unknown"
      }


      UIDevice.current.isBatteryMonitoringEnabled = true
      let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
      info["batteryLevel"] = batteryLevel >= 0 ? "\(batteryLevel)%" : "unknown"


      info["powerSavingMode"] = ProcessInfo.processInfo.isLowPowerModeEnabled ? "true" : "false"

      info["language"] = Locale.current.languageCode ?? "unknown"


      info["timeZone"] = TimeZone.current.identifier

      return info
  }
}
