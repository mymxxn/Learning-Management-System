import 'package:hive_flutter/hive_flutter.dart';
import 'package:learning_management_system/model/user_model.dart';

class HiveHelper {
 static initHive() async => Hive.initFlutter();
 static registerAdapter(){
   Hive.registerAdapter(UserModelAdapter());
 }
}
