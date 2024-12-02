import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_management_system/utils/constants.dart';

class ListWidget extends StatelessWidget {
  const ListWidget(
      {super.key,
      required this.label,
      required this.ontap,
      required this.iconData});
  final String label;
  final Function() ontap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      onTap: ontap,
      leading: CircleAvatar(
        backgroundColor: ConstantColor.profileBlue,
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
            color: ConstantColor.primaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Icon(
          Icons.arrow_forward,
          color: ConstantColor.profileBlue,
        ),
      ),
    );
  }
}
