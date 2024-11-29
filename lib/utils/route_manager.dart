import 'package:go_router/go_router.dart';
import 'package:learning_management_system/view/course_listing_screen.dart';
import 'package:learning_management_system/view/forgot_password_screen.dart';
import 'package:learning_management_system/view/login_screen.dart';
import 'package:learning_management_system/view/signup_screen.dart';
import 'package:learning_management_system/view/splash_screen.dart';
import 'package:learning_management_system/view/user_profile_management_screen.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    name: 'splashScreen',
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    name: 'login',
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: 'signup',
    path: '/signup',
    builder: (context, state) => const SignupScreen(),
  ),
  GoRoute(
    name: 'forgotpassword',
    path: '/forgotpassword',
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
  GoRoute(
    name: 'courselisting',
    path: '/courselisting',
    builder: (context, state) => const CourseListingScreen(),
  ),
  GoRoute(
    name: 'userprofilemanagement',
    path: '/userprofilemanagement',
    builder: (context, state) => const UserProfileManagementScreen(),
  ),
]);
