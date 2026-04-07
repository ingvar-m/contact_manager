import 'package:contact_manager/presentation/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DataField extends StatelessWidget {

  final String text;
  final TextEditingController controller;

  const DataField({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.primaryColor,
      style: TextStyle(
          color: AppColors.textColor,
          fontSize: 24,
          fontWeight: FontWeight.w300
      ),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w300
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 2
          )
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.secondaryColor,
              width: 2
            )
        ),
      ),
    );
  }
}
