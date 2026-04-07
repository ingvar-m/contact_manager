import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../constants/app_colors.dart';

class PhoneField extends StatelessWidget {

  final String text;
  final TextEditingController controller;

  const PhoneField({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    final phoneFormatter = MaskTextInputFormatter(
      mask: "+# (###) ###-##-##",
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
    );
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
      keyboardType: TextInputType.phone,
      inputFormatters: [phoneFormatter],
    );
  }
}
