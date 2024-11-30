import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/profile_provider.dart';
import 'package:provider/provider.dart';

class UserProfileManagementScreen extends StatelessWidget {
  const UserProfileManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Consumer<ProfileProvider>(
      builder:(context, provider, child) {
        return CircleAvatar(child: provider.profileImage==null?Text(''):null);
      }
    )],);
  }
}