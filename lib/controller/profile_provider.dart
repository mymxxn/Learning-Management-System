import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:learning_management_system/utils/firebase_helper.dart';
import 'package:learning_management_system/utils/hive_helper.dart';
import 'package:learning_management_system/utils/snackbar_widget.dart';
import 'package:learning_management_system/utils/user_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  TextEditingController fullName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? profileImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  fetchProfile() async {
    String email = UserPreferences.getUserEmail() ?? '';
    log('$email mail');
    try {
      final user = await HiveHelper.userBox.values.firstWhere(
        (user) => user.email == email,
        orElse: () => null,
      );
      log('$user $email');
      if (user != null) {
        emailController.text = email;
        fullName.text = user.fullName;
        if (user.profilePicture != null) {
          profileImage = File(user.profilePicture);
        }
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
    notifyListeners();
  }

  logout(BuildContext context) {
    UserPreferences.setIsLoggedIn(false);
    UserPreferences.setUserEmail('');
    Navigator.pushReplacementNamed(context, '/login');
    FirebaseHelper.firebaseAuth.signOut();
  }

  saveProfile(BuildContext context) async {
    String newEmail = emailController.text.trim();
    String newName = fullName.text.trim();
    String? profilePath = profileImage?.path;
    try {
      String oldEmail = UserPreferences.getUserEmail() ?? '';
      String password = UserPreferences.getUserPassword() ?? '';
      final user = HiveHelper.userBox.values.firstWhere(
        (user) => user.email == oldEmail,
        orElse: () => null,
      );
      if (user != null) {
        user.fullName = newName;
        user.email = newEmail;
        user.profilePicture = profilePath;
        await user.save();
        UserPreferences.setUserEmail(newEmail);
        // await FirebaseHelper.firebaseAuth.currentUser
        //     ?.verifyBeforeUpdateEmail(newEmail);
        log('${oldEmail} ${newEmail}');
        await FirebaseHelper.firebaseAuth
            .signInWithEmailAndPassword(email: oldEmail, password: password)
            .then((userCredential) {
          userCredential.user?.verifyBeforeUpdateEmail(newEmail);
        });
        SnackbarWidget.successSnackbar(
            context: context, text: 'Updated Successfully');
        clearData();
        fetchProfile();
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      log('${e.code}');
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use.';
          break;
        case 'requires-recent-login':
          errorMessage =
              'You need to log in again to update your email for security reasons.';
          break;
        case 'invalid-email':
          errorMessage = 'The provided email is not valid.';
          break;
        default:
          errorMessage = 'Error: ${e.message}';
      }
      SnackbarWidget.errorSnackbar(context: context, text: errorMessage);
    } catch (e) {
      log('$e');
    }
  }

  Future<void> reauthenticateUser(String password) async {
    final user = FirebaseHelper.firebaseAuth.currentUser;
    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email ?? '',
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
    }
  }

  clearData() {
    profileImage = null;
    fullName.clear();
    emailController.clear();
    fetchProfile();
    notifyListeners();
  }
}
