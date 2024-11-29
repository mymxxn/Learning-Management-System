import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  String? profilePicture;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      this.profilePicture});
}
