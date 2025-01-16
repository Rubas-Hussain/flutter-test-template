import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
// import '../../../../../utils/extensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  const CustomButton({super.key, required this.onPress, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: (49/720)*MediaQuery.sizeOf(context).height,
        width: context.width,
        decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(title,style: AppTextStyles.m500white14)),
      ),
    );
  }
}
