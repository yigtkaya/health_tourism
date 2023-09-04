import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/dialog/permission_dialog.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/repoImpl/message_repo_impl.dart';
import 'package:health_tourism/product/repoImpl/user_%20repo_impl.dart';
import 'package:health_tourism/product/utils/notification_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../product/navigation/route_paths.dart';

class ImagePickerDialog extends StatefulWidget {
  final String uid;
  const ImagePickerDialog({super.key, required this.uid});

  @override
  State<ImagePickerDialog> createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  late File imageFile;
  final repo = UserRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Choose Image Source"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Camera"),
            onTap: () async {
              final status = await PermissionsHandler.checkCameraPermission();
              if(status.isGranted) {
                _getFromCamera();
              } else {
                showRationaleForPermanentlyDeniedCamera();
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Gallery"),
            onTap: () async {
              final status = await PermissionsHandler.checkGalleryPermission();
              if(status.isGranted) {
                _getFromGallery();
              } else {
                showRationaleForPermanentlyDeniedStorage();
              }
            },
          ),
        ],
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (xfile != null) {
      setState(() {
        imageFile = File(xfile.path);
      });

      String imageUrl = await repo.uploadImageToFirebase(
          imageFile, widget.uid);

      repo.updateProfilePhoto(widget.uid, imageUrl);

      goBack();

    } else {
      goBack();
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (xfile != null) {
      setState(() {
        imageFile = File(xfile.path);
      });

      String imageUrl = await repo.uploadImageToFirebase(
          imageFile, widget.uid);

      repo.updateProfilePhoto(widget.uid, imageUrl);

      goBack();
    } else {
      goBack();
    }
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

