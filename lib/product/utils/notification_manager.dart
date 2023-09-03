import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {

  void askAllPermissions() {
    checkCameraPermission();
    checkNotificationPermission();
    checkGalleryPermission();
  }
  Future<void> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    if(status.isDenied) {
      // Request permission
      await Permission.notification.request();
    }
    else if (status.isPermanentlyDenied) {
      showRationaleForPermanentlyDeniedNotification();
    }
  }

  Future<void> checkGalleryPermission() async {
    final status = await Permission.storage.status;
    if(status.isDenied) {
      // Request permission
      await Permission.camera.request();
    }
    else if (status.isPermanentlyDenied) {
      showRationaleForPermanentlyDeniedStorage();
    }
  }

  Future<void> checkCameraPermission() async {
    final status = await Permission.camera.status;
    if(status.isDenied) {
      // Request permission
      await Permission.camera.request();
    }
    else if (status.isPermanentlyDenied) {
      showRationaleForPermanentlyDeniedStorage();
    }
  }
  void showRationaleForPermanentlyDeniedNotification() {
    // create a function to show a dialog with an explanation and button to open the app settings page
  }
  void showRationaleForPermanentlyDeniedStorage (){
    // create a function to show a dialog with an explanation and button to open the app settings page
  }
}
