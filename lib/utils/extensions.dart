import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResponsiveUtil {
  static late double screenHeight;
  static late double screenWidth;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }
}
//
//
const double baseHeight = 758.0;
const double baseWidth = 360.0;
//
// // double MediaQuery.of(Get.context!).size.height=MediaQuery.of(Get.context!).size.height;
// // double MediaQuery.of(Get.context!).size.width=MediaQuery.of(Get.context!).size.width;
//
// final view = WidgetsBinding.instance.platformDispatcher.views.first;
// final size = view.physicalSize;
// final pixelRatio = view.devicePixelRatio;
//
// // Size in physical pixels:
// final width = size.width;
// final height = size.height;

// For Font size
extension ResponsiveFontSize on num {
  double get sp => (this / baseHeight) * ResponsiveUtil.screenHeight;
}

// For Radial sizes such as icons and others
extension ResponsiveRadialSize on num {
    /*(14/758)*MediaQuery.of(this).size.height*/
    // return (baseRadialSize / 758) * MediaQuery.of(this).size.height;
  double get r => (this / baseHeight) * ResponsiveUtil.screenHeight;

}

// For height
extension ResponsiveHeight on num {
  double get h => (this / baseHeight) * ResponsiveUtil.screenHeight;
}

// For Width
extension ResponsiveWidth on num {
  double get w => (this / baseWidth) * ResponsiveUtil.screenWidth;
}



