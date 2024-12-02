import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/login_provider.dart';
import 'package:learning_management_system/utils/constants.dart';
import 'package:learning_management_system/utils/hive_helper.dart';
import 'package:learning_management_system/utils/route_manager.dart';
import 'package:learning_management_system/utils/snackbar_widget.dart';
import 'package:learning_management_system/view/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late LoginProvider loginProvider;
  final signupFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: ConstantColor.primaryColor,
      body: Form(
        key: signupFormKey,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Image.asset(
                        ConstantImages.loginScreenImage,
                        scale: 5,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CommonWidgets.commonTextfield(
                        controller: loginProvider.fullNameController,
                        label: 'Full Name',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }

                          if (value.length < 2) {
                            return 'Please enter a valid Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonWidgets.commonTextfield(
                        controller: loginProvider.emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          String pattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                          if (!RegExp(pattern).hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<LoginProvider>(
                          builder: (context, provider, child) =>
                              CommonWidgets.commonTextfield(
                                  controller: loginProvider.passwordController,
                                  label: 'Password',
                                  icon: Icons.lock_outline,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    String pattern =
                                        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                                    if (!RegExp(pattern).hasMatch(value)) {
                                      SnackbarWidget.errorSnackbar(
                                          context: context,
                                          text:
                                              'Password must contain at least:\n'
                                              '- 8 characters\n'
                                              '- 1 uppercase letter\n'
                                              '- 1 lowercase letter\n'
                                              '- 1 number\n'
                                              '- 1 special character');
                                    }
                                    return null;
                                  },
                                  suffixIcon: InkWell(
                                      onTap: () => provider.visibilityChange(),
                                      child: provider.visiblePassword
                                          ? Icon(
                                              Icons.visibility_outlined,
                                              color: Colors.grey,
                                              size: 18,
                                            )
                                          : Icon(
                                              Icons.visibility_off_outlined,
                                              color: Colors.grey,
                                              size: 18,
                                            )),
                                  visiblePassword: !provider.visiblePassword)),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<LoginProvider>(
                          builder: (context, provider, child) =>
                              CommonWidgets.commonTextfield(
                                  controller:
                                      loginProvider.confirmPasswordController,
                                  label: 'Confirm Password',
                                  icon: Icons.lock_outline,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }

                                    return null;
                                  },
                                  suffixIcon: InkWell(
                                      onTap: () => provider.visibilityChange1(),
                                      child: provider.visiblePassword1
                                          ? Icon(
                                              Icons.visibility_outlined,
                                              color: Colors.grey,
                                              size: 18,
                                            )
                                          : Icon(
                                              Icons.visibility_off_outlined,
                                              color: Colors.grey,
                                              size: 18,
                                            )),
                                  visiblePassword: !provider.visiblePassword1)),
                      const SizedBox(
                        height: 25,
                      ),
                      CommonWidgets.commonButton(
                          label: 'Sign Up',
                          ontap: () {
                            bool matchingPassword = loginProvider
                                    .passwordController.text ==
                                loginProvider.confirmPasswordController.text;

                            if (signupFormKey.currentState!.validate()) {
                              if (matchingPassword) {
                                loginProvider.signUp(context);
                              } else {
                                SnackbarWidget.errorSnackbar(
                                    context: context,
                                    text: 'Passwords are not matching');
                              }
                            }
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                        onTap: () {
                          loginProvider.clearData();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          ' Sign In',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
