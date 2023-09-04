import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/view/bottom_navigation/bottom_navigation.dart';
import 'package:health_tourism/view/login/login_view.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/components/dialog/permission_dialog.dart';
import '../../cubit/auth/AuthState.dart';
import '../../cubit/auth/auth_cubit.dart';
import '../../product/utils/notification_manager.dart';

class RootView extends StatefulWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  State<RootView> createState() => _RootViewState();
}


class _RootViewState extends State<RootView> {
  @override
  void initState() {
    // TODO: implement initState
    requestPermissions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return HTBottomNav();
          }
          return const LoginView();
        });
  }


  // burayı diğer classa nasıl taşıyacağız ?
  Future<bool> requestPermissions() async {
    final notification = await PermissionsHandler.checkNotificationPermission();
    final camera = await PermissionsHandler.checkCameraPermission();
    final photos = await PermissionsHandler.checkGalleryPermission();

    if(notification.isPermanentlyDenied) {
      showRationaleForPermanentlyDeniedNotification();
    }

    if(camera.isPermanentlyDenied) {
      showRationaleForPermanentlyDeniedCamera();
    }

    if(photos.isPermanentlyDenied) {
      showRationaleForPermanentlyDeniedStorage();
    }

    return true;
  }

  showRationaleForPermanentlyDeniedNotification() {
    // create a function to show a dialog with an explanation and button to open the app settings page
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const PermissionDialog(
              title: "Notification Permission",
              content: "Give permission to get notified from this app");
        });
  }

  showRationaleForPermanentlyDeniedStorage() {
    // create a function to show a dialog with an explanation and button to open the app settings page
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const PermissionDialog(
              title: "Gallery Permission",
              content: "Give permission to use gallery in this app");
        });
  }

  showRationaleForPermanentlyDeniedCamera() {
    // create a function to show a dialog with an explanation and button to open the app settings page
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const PermissionDialog(
              title: "Camera Permission",
              content: "Give permission to use camera in this app");
        });
  }
}
