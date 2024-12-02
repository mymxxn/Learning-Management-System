import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_management_system/controller/profile_provider.dart';
import 'package:learning_management_system/utils/constants.dart';
import 'package:learning_management_system/view/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileProvider profileProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return profileProvider.clearData();
      },
      child: Scaffold(
        backgroundColor: ConstantColor.primaryColor,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              profileProvider.clearData();
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ConstantImages.logo,
                scale: 8,
              ),
              const Text(
                'academy',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Consumer<ProfileProvider>(builder: (context, provider, child) {
                return InkWell(
                  onTap: () => provider.pickImage(),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              backgroundImage:
                                  profileProvider.profileImage != null
                                      ? FileImage(profileProvider.profileImage!)
                                      : null,
                              child: profileProvider.profileImage == null
                                  ? Text((provider.fullName.text.isEmpty
                                          ? 'Unknown'
                                          : provider.fullName.text)
                                      .substring(0, 2)
                                      .toUpperCase())
                                  : null),
                        ],
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: ConstantColor.profileBlue,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              CommonWidgets.commonTextfield(
                isWhite: true,
                controller: profileProvider.fullName,
                label: 'Full Name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }

                  if (value.length < 2) {
                    return 'Please enter a valid Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CommonWidgets.commonTextfield(
                isWhite: true,
                controller: profileProvider.emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const Spacer(),
              CommonWidgets.commonButton(
                  label: 'Save Changes',
                  ontap: () {
                    profileProvider.saveProfile(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
