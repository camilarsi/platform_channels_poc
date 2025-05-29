class DeviceInfo {
  final String osVersion;
  final String deviceModel;
  final String manufacturer;
  final String brand;
  final String androidId;
  final String batteryLevel;
  final bool powerSavingMode;
  final String language;
  final String timeZone;

  DeviceInfo({
    required this.osVersion,
    required this.deviceModel,
    required this.manufacturer,
    required this.brand,
    required this.androidId,
    required this.batteryLevel,
    required this.powerSavingMode,
    required this.language,
    required this.timeZone,
  });

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      osVersion: map['osVersion'] ?? '',
      deviceModel: map['deviceModel'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      brand: map['brand'] ?? '',
      androidId: map['androidId'] ?? '',
      batteryLevel: map['batteryLevel'] ?? '',
      powerSavingMode:
          (map['powerSavingMode']?.toString().toLowerCase() == 'true'),
      language: map['language'] ?? '',
      timeZone: map['timeZone'] ?? '',
    );
  }
}
