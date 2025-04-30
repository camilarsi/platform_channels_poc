import 'package:flutter/services.dart';

class DeviceInfoDataSource {

  static const _channel = MethodChannel('com.example.platform_channels_poc');


  Future<String> getOsInfo() async{

    try{
      final result = await _channel.invokeMethod<String>('getOsInfo');
      return result ?? '';
    } on PlatformException catch(e){
      throw Exception('Failed to get OS info: ${e.message}');
    }

  }

  Future<String> getDeviceModelInfo()async {
    try{
      final result = await _channel.invokeMethod<String>('getDeviceModelInfo');
      return result ?? '';
    }on PlatformException catch(e){
      throw Exception('Failed to get device model info: ${e.message}');
    }
  }
}