import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
class PermisionService {
  static Future<void> requestPermissions() async {
    if (!kIsWeb) {
      final storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }

      final cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }

      if (await Permission.camera.isDenied) {
        return Future.error('Camera access denied');
      }
    }
  }
}
