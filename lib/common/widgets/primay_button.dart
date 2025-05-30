
import 'package:construtech/common/constants/app_colors.dart';
import 'package:construtech/common/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const PrimaryButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(38.0)),
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(38.0)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.purpleGradient,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(38.0)),
          onTap: onPressed,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
            alignment: Alignment.center,
            height: 56.0,
            child: Text(
              text,
              style: AppTextStyle.mediumText18.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
