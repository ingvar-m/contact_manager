import 'package:contact_manager/data/models/contact_model.dart';
import 'package:contact_manager/presentation/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppColors.primaryColor,
            elevation: 0
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 24,
                color: AppColors.secondaryColor,
            ),
          )
      ),
    );
  }
}
