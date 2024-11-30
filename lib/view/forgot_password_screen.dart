import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/login_provider.dart';
import 'package:learning_management_system/utils/constants.dart';
import 'package:learning_management_system/utils/route_manager.dart';
import 'package:learning_management_system/utils/snackbar_widget.dart';
import 'package:learning_management_system/view/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late LoginProvider loginProvider;

  final forgotPasswordformKey = GlobalKey<FormState>();

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
        key: forgotPasswordformKey,
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
                        Text(
                          'Forgot Password',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          height: 15,
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
                        Text(
                          'Provide your email address to reset password.',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CommonWidgets.commonButton(
                            label: 'Reset Password',
                            ontap: () {
                              if (forgotPasswordformKey.currentState!
                                  .validate()) {
                                loginProvider.resetPassword(context);
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
                      'Want to go Back',
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
          ],
        ),
      ),
    );
  }
}
