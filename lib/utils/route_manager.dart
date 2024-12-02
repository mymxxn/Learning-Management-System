import 'package:learning_management_system/view/forgot_password_screen.dart';
import 'package:learning_management_system/view/home_screen.dart';
import 'package:learning_management_system/view/login_screen.dart';
import 'package:learning_management_system/view/signup_screen.dart';
import 'package:learning_management_system/view/splash_screen.dart';
import 'package:learning_management_system/view/user%20profile%20management/edit_profile_screen.dart';

final router = {
  '/splashscreen': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => SignupScreen(),
  '/forgotpassword': (context) => const ForgotPasswordScreen(),
  '/home': (context) => const HomeScreen(),
  '/editProfile': (context) => const EditProfileScreen()
};
