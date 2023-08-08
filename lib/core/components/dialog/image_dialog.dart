import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/repoImpl/message_repo_impl.dart';
import 'package:image_picker/image_picker.dart';
import '../../../product/navigation/route_paths.dart';

class ImagePickerDialog extends StatefulWidget {
  final String receiverId;

  const ImagePickerDialog({super.key, required this.receiverId});

  @override
  State<ImagePickerDialog> createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
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
            leading: Icon(Icons.camera),
            title: Text("Camera"),
            onTap: () {
              _getFromCamera();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("Gallery"),
            onTap: () {
              _getFromGallery();
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

      if(mounted) {
        context.pushNamed(RoutePath.sendImage, queryParameters: {
          "receiverId": widget.receiverId,
          "imageFile": xfile.path,
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
      if(mounted) {
        context.pushNamed(RoutePath.sendImage, queryParameters: {
          "receiverId": widget.receiverId,
          "imageFile": xfile.path,
        });
      }
    } else {
      goBack();
    }
  }
}

