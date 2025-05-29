import 'package:flutter/services.dart';

class PhotoGalleryDataSource {
  static const _channel = MethodChannel('com.example.platform_channels_poc');

  Future<String?> pickImage() async {
    try {
      final String? path = await _channel.invokeMethod('pickImage');
      return path;
    } on PlatformException catch (e) {
      throw 'Failed to pick image: ${e.message}';
    }
  }
}
