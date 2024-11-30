import 'package:hive_flutter/hive_flutter.dart';
import 'package:learning_management_system/model/user_model.dart';
import 'package:learning_management_system/utils/constants.dart';

class HiveHelper {
  static Box userBox = Hive.box(Constants.userBox);
  static initHive() async => Hive.initFlutter();
  static registerAdapter() {
    // Hive.registerAdapter(());
  }

  static openBox() => Hive.openBox(Constants.userBox);
}
