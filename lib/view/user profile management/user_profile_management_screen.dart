import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/profile_provider.dart';
import 'package:learning_management_system/view/user%20profile%20management/list_widget.dart';
import 'package:learning_management_system/view/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

class UserProfileManagementScreen extends StatefulWidget {
  const UserProfileManagementScreen({super.key});

  @override
  State<UserProfileManagementScreen> createState() =>
      _UserProfileManagementScreenState();
}

class _UserProfileManagementScreenState
    extends State<UserProfileManagementScreen> {
  late ProfileProvider profileProvider;
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileProvider.fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: profileProvider.profileImage != null
                    ? FileImage(profileProvider.profileImage!)
                    : null,
                child: profileProvider.profileImage == null
                    ? Text((provider.fullName.text.isEmpty
                            ? 'Unknown'
                            : provider.fullName.text)
                        .substring(0, 2)
                        .toUpperCase())
                    : null),
            const SizedBox(
              height: 12,
            ),
            Text(
              provider.fullName.text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            ListWidget(
                label: 'Edit Profile',
                ontap: () {
                  Navigator.pushNamed(context, '/editProfile');
                },
                iconData: Icons.account_circle_rounded),
            const SizedBox(
              height: 15,
            ),
            ListWidget(
                label: 'Logout',
                ontap: () => provider.logout(context),
                iconData: Icons.account_circle_rounded),
          ],
        ),
      );
    });
  }
}
