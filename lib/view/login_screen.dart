import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/login_provider.dart';
import 'package:learning_management_system/main.dart';
import 'package:learning_management_system/utils/constants.dart';
import 'package:learning_management_system/utils/hive_helper.dart';
import 'package:learning_management_system/utils/route_manager.dart';
import 'package:learning_management_system/utils/snackbar_widget.dart';
import 'package:learning_management_system/view/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginProvider loginProvider;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColor.primaryColor,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          ConstantImages.loginScreenImage,
                          scale: 5,
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
                                    controller: provider.passwordController,
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
                                        onTap: () =>
                                            provider.visibilityChange(),
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
                                    visiblePassword:
                                        !provider.visiblePassword)),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              )),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CommonWidgets.commonButton(
                            label: 'Log In',
                            ontap: () {
                              if (_formKey.currentState!.validate()) {
                                loginProvider.login(context);
                              }
                            }),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do not have an account?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                        onTap: () {
                          loginProvider.clearData();
                          router.go('/signup');
                        },
                        child: const Text(
                          ' Sign up',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
