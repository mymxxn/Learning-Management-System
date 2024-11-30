import 'package:flutter/material.dart';
import 'package:learning_management_system/utils/constants.dart';

class CommonWidgets {
  static commonTextfield(
          {required TextEditingController controller,
          required String label,
          required IconData icon,
          required FormFieldValidator validator,
          bool visiblePassword = false,
          Widget? suffixIcon}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            obscureText: visiblePassword,
            decoration: InputDecoration(
                filled: true,
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)),
                isCollapsed: true,
                fillColor: ConstantColor.primaryColor,
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w300),
                prefixIcon: Icon(
                  icon,
                  size: 20,
                  color: Colors.grey,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                hintText: label),
          ),
        ],
      );
  static commonButton({required String label, required Function() ontap}) =>
      InkWell(
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ConstantColor.buttonRed,
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ),
      );
}
