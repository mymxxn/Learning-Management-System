import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_management_system/model/user_model.dart';
import 'package:learning_management_system/utils/hive_helper.dart';
import 'package:learning_management_system/utils/route_manager.dart';
import 'package:learning_management_system/utils/snackbar_widget.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool visiblePassword = false;
  bool visiblePassword1 = false;
  initialDataLoading() {
    Future.delayed(Duration(seconds: 2)).then(
      (value) async {
        bool existsUser = HiveHelper.userBox.isEmpty;
        if (existsUser) {
          router.go('/signup');
        } else {
          router.go('/login');
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

  signUp(BuildContext context) {
    try {
      HiveHelper.userBox.add(UserModel(
          fullName: fullNameController.text,
          email: emailController.text,
          password: passwordController.text));
      SnackbarWidget.successSnackbar(
          context: context, text: "User created Successfully");
      clearData();
      router.go('/login');
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
        router.go('/home');
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

  clearData() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    visiblePassword = false;
    visiblePassword1 = false;
    notifyListeners();
  }
}
