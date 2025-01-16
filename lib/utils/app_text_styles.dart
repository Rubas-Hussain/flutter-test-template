import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

class AppTextStyles{
  static final sp=Get.context!.textScaleFactor;

  static TextStyle l400black12=TextStyle(color: AppColors.blackColor,fontSize: 12*sp,
      fontFamily: 'Pop-L',fontWeight: FontWeight.w400);
  static TextStyle l400black13=TextStyle(color: AppColors.blackColor,fontSize: 13*sp,
      fontFamily: 'Pop-L',fontWeight: FontWeight.w400);
  static TextStyle l400black15=TextStyle(color: AppColors.blackColor,fontSize: 15*sp,
      fontFamily: 'Pop-L',fontWeight: FontWeight.w400);

  static TextStyle l300black10=TextStyle(color: AppColors.blackColor,fontSize: 10*sp,
      fontFamily: 'Pop-L',fontWeight: FontWeight.w300);

  // Medium
  static TextStyle m600black24=TextStyle(color: AppColors.blackColor,fontSize: 24*sp,
      fontFamily: 'Pop-M',fontWeight: FontWeight.w600);
  static TextStyle m500black18=TextStyle(color: AppColors.blackColor,fontSize: 18*sp,
      fontFamily: 'Pop-M',fontWeight: FontWeight.w500);

  static TextStyle m500white14=TextStyle(color: AppColors.whiteColor,fontSize: 14*sp,
      fontFamily: 'Pop-M',fontWeight: FontWeight.w500);

  static TextStyle m400black14=TextStyle(color: AppColors.blackColor,fontSize: 14*sp,
      fontFamily: 'Pop-M',fontWeight: FontWeight.w400);

}