import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/course_provider.dart';
import 'package:learning_management_system/controller/login_provider.dart';
import 'package:learning_management_system/controller/profile_provider.dart';
import 'package:learning_management_system/utils/hive_helper.dart';
import 'package:learning_management_system/utils/route_manager.dart';
import 'package:learning_management_system/utils/user_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserPreferences.init();
  await HiveHelper.initHive();
  HiveHelper.registerAdapter();
  HiveHelper.openBox();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LoginProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CourseProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Learning Management System',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/splashscreen',
        routes: router);
  }
}
