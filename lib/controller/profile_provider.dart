import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  File? profileImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }
}
