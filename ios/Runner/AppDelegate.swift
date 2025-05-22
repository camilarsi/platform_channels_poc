import UIKit
import Flutter
import PhotosUI
import Foundation

@main
@objc class AppDelegate: FlutterAppDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var flutterResult: FlutterResult?
    private var imagePicker: UIImagePickerController?

    private let channelName = "com.example.platform_channels_poc"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

            switch call.method {
            case "getFullDeviceInfo":
                result(self.getFullDeviceInfo())
            case "pickImage":
                self.flutterResult = result
                self.showImagePicker(from: controller)
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
        info["deviceId"] = UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        info["batteryLevel"] = batteryLevel >= 0 ? "\(batteryLevel)%" : "unknown"
        info["powerSavingMode"] = ProcessInfo.processInfo.isLowPowerModeEnabled ? "true" : "false"
        info["language"] = Locale.current.languageCode ?? "unknown"
        info["timeZone"] = TimeZone.current.identifier
        return info
    }

    private func showImagePicker(from controller: UIViewController) {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .photoLibrary
        controller.present(imagePicker!, animated: true)
    }

    func imagePickerContropller(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        guard let imageUrl = info[.imageURL] as? URL else {
            flutterResult?(FlutterError(code: "PICK_IMAGE_ERROR",
                                        message: "Failed to retrieve the image",
                                        details: nil))
            flutterResult = nil
            return
        }

        let fileName = imageUrl.lastPathComponent
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectory.appendingPathComponent(fileName)

        do {
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            try FileManager.default.copyItem(at: imageUrl, to: destinationURL)
            flutterResult?(destinationURL.absoluteString)
        } catch {
            flutterResult?(FlutterError(code: "FILE_COPY_ERROR",
                                        message: "Failed to copy image to app directory",
                                        details: error.localizedDescription))
        }

        flutterResult = nil
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        flutterResult?(FlutterError(code: "PICK_IMAGE_CANCELLED",
                                    message: "Selection was cancelled",
                                    details: nil))
        flutterResult = nil
    }
}
