import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/dialog/permission_dialog.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/repoImpl/message_repo_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../product/navigation/route_paths.dart';
import '../../../product/utils/notification_manager.dart';

class ChatImagePickerDialog extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String senderName;

  const ChatImagePickerDialog(
      {super.key,
      required this.receiverId,
      required this.senderName,
      required this.receiverName});

  @override
  State<ChatImagePickerDialog> createState() => _ChatImagePickerDialogState();
}

class _ChatImagePickerDialogState extends State<ChatImagePickerDialog> {
  late File imageFile;
  final repo = MessageRepositoryImpl();

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
              if (status.isGranted) {
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
              if (status.isGranted) {
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

      if (mounted) {
        context.pop();
        context.pushNamed(RoutePath.sendImage, queryParameters: {
          "receiverId": widget.receiverId,
          "imageFile": xfile.path,
          "senderName": widget.senderName,
          "receiverName": widget.receiverName
        });
      }
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
      if (mounted) {
        context.pop();
        context.pushNamed(RoutePath.sendImage, queryParameters: {
          "receiverId": widget.receiverId,
          "imageFile": xfile.path,
          "senderName": widget.senderName,
          "receiverName": widget.receiverName
        });
      }
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
