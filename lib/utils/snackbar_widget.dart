import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class SnackbarWidget {
  static successSnackbar(
          {required BuildContext context, required String text}) =>
      AnimatedSnackBar.material(
        text,
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);
  static errorSnackbar({required BuildContext context, required String text}) =>
      AnimatedSnackBar.material(
        text,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);

  static warningSnackbar(
          {required BuildContext context, required String text}) =>
      AnimatedSnackBar.material(
        text,
        type: AnimatedSnackBarType.warning,
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);
}
