import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
  String fullName;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  String? profilePicture;

  UserModel(
      {required this.fullName,
      required this.email,
      required this.password,
      this.profilePicture});
}
