import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/login_provider.dart';
import 'package:learning_management_system/utils/hive_helper.dart';
import 'package:learning_management_system/utils/route_manager.dart';
import 'package:learning_management_system/utils/user_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await HiveHelper.initHive();
  HiveHelper.registerAdapter();
  HiveHelper.openBox();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LoginProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Learning Management System',
        theme: ThemeData(
          useMaterial3: true,
        ),
        routerConfig: router);
  }
}
