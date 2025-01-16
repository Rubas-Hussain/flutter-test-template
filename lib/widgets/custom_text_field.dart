import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import '../../../../../utils/extensions.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? preIcon;
  final Widget? suffIcon;
  final bool? obscureText;
  final TextStyle? textStyle;
  final Function()? onPress;
  final Function(String)? onSubmitted;
  final Function(PointerDownEvent)? onTapOutside;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool? enabled;
  final BorderRadius? borderRadius;
  final TextInputType? textType;
  final TextEditingController controller;
  final Function(String)? onChangedAction;
  final void Function()? onEditingComplete;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.preIcon,
      this.suffIcon,
      this.onPress,
      this.focusNode,
      this.nextFocusNode,
      this.obscureText,
      this.enabled = true,
      this.textType,
      this.onChangedAction,
      this.contentPadding,
      this.onSubmitted,
      this.onEditingComplete,
      this.textStyle,
      this.inputFormatters,
      this.onTapOutside, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blackColor,
      focusNode: focusNode,
      controller: controller,
      keyboardType: textType,
      enabled: enabled,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      style: textStyle ?? AppTextStyles.l400black15,
      onFieldSubmitted: onSubmitted ??
          (value) {
            FocusScope.of(context).requestFocus();
          },
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
      onChanged: onChangedAction,
      textInputAction: TextInputAction.next,
      onTapOutside: onTapOutside,
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        hintText: hintText,
        hintStyle: AppTextStyles.l400black15.copyWith(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w300,
            fontSize: 13*Get.context!.textScaleFactor),
        fillColor: AppColors.whiteColor,
        filled: true,
        prefixIcon: preIcon,
        suffixIcon: suffIcon, // Now accepts any widget
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.blueColor),
          // borderSide: const BorderSide(color: AppColors.redColor,width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.whiteColor),
          // borderSide: const BorderSide(color: AppColors.redColor,width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
