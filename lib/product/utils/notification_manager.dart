import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {

  static Future<PermissionStatus> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      // Request permission
      await Permission.notification.request();
    }
    return status;
  }

  static Future<PermissionStatus> checkGalleryPermission() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.status;
      if (status.isDenied) {
        // Request permission
        await Permission.photos.request();
      }
      return status;
    } else {
      final deviceInfo = DeviceInfoPlugin();
      final androidDeviceInfo = await deviceInfo.androidInfo;
      if (androidDeviceInfo.version.sdkInt >= 33) {
        final photoStatus = await Permission.photos.status;
        if(photoStatus.isGranted) {
            return photoStatus;
        } else {
          await Permission.photos.request();

          return photoStatus;
        }
      } else {
        final status = await Permission.storage.status;
        if (status.isDenied) {
          // Request permission
          await Permission.storage.request();
        }
        return status;
      }
    }
  }

  static Future<PermissionStatus> checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      // Request permission
      await Permission.camera.request();
    }
    return status;
  }
}
