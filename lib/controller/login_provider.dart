import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_management_system/model/user_model.dart';
import 'package:learning_management_system/utils/firebase_helper.dart';
import 'package:learning_management_system/utils/hive_helper.dart';
import 'package:learning_management_system/utils/route_manager.dart';
import 'package:learning_management_system/utils/snackbar_widget.dart';
import 'package:learning_management_system/utils/user_preferences.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool visiblePassword = false;
  bool visiblePassword1 = false;
  initialDataLoading(context) {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) async {
        bool isLoggedIn = UserPreferences.getIsLoggedIn() ?? false;
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }

  visibilityChange() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  visibilityChange1() {
    visiblePassword1 = !visiblePassword1;
    notifyListeners();
  }

  signUp(BuildContext context) async {
    try {
      HiveHelper.userBox.add(UserModel(
          fullName: fullNameController.text,
          email: emailController.text,
          password: passwordController.text));
      await FirebaseHelper.firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      SnackbarWidget.successSnackbar(
          context: context, text: "User created Successfully");
      clearData();
      Navigator.pop(context);
    } catch (e) {
      SnackbarWidget.errorSnackbar(context: context, text: "$e");
    }
  }

  login(BuildContext context) {
    try {
      final user = HiveHelper.userBox.values.firstWhere(
        (user) =>
            user.email == emailController.text &&
            user.password == passwordController.text,
        orElse: () => null,
      );
      if (user != null) {
        SnackbarWidget.successSnackbar(
            context: context, text: "Logged In Successfully");
        clearData();
        UserPreferences.setIsLoggedIn(true);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        SnackbarWidget.warningSnackbar(
            context: context,
            text:
                "There is no User with this email, Please check Email or Password");
      }
    } catch (e) {
      SnackbarWidget.errorSnackbar(context: context, text: "$e");
    }
  }

  resetPassword(BuildContext context) async {
    try {
      await FirebaseHelper.firebaseAuth
          .sendPasswordResetEmail(email: emailController.text);
      SnackbarWidget.successSnackbar(
          context: context, text: 'Password reset email sent.');
      clearData();
      Navigator.pop(context);
    } catch (e) {
      log('${e}');
      SnackbarWidget.errorSnackbar(
          context: context, text: 'Error: ${e.toString()}');
    }
  }

  clearData() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    visiblePassword = false;
    visiblePassword1 = false;
    notifyListeners();
  }
}
