
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/extensions.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class MyDropDown extends StatelessWidget {
  final List<dynamic>? myList;
  final dynamic defaultValue;
  final ValueChanged<dynamic>? onPress;
  final String Function(dynamic item)? getItemValue;
  const MyDropDown({super.key,  this.myList, this.onPress, this.defaultValue, this.getItemValue });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 49.h,
        width: context.width,
        decoration:  BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),

        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              menuMaxHeight: 200.h,
              iconEnabledColor: AppColors.blackColor,
              iconDisabledColor: AppColors.blackColor,
              style: AppTextStyles.l400black15,
              dropdownColor: AppColors.whiteColor,
              elevation: 0,
              icon: Icon(Icons.keyboard_arrow_down,size: 22.r,),
              borderRadius: BorderRadius.circular(12.r),
              value: defaultValue,
              items: myList?.map((e) => DropdownMenuItem(
                value: e,
                child: Text(getItemValue != null ? getItemValue!(e): e.toString()),)).toList(),
              onChanged: (newValue) {
                if (onPress != null) {
                  onPress!(newValue);
                }
              },
            ),
          ),
        ));
  }
}
