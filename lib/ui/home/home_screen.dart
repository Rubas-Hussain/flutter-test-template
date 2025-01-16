import 'package:flutter/material.dart';
import 'package:test_template/widgets/custom_button.dart';

import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello'),
                CustomButton(onPress: (){}, title: 'title')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
