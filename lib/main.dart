import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_template/ui/home/home_screen.dart';
import 'package:test_template/utils/routes.dart';
import 'package:test_template/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.home,
      getPages: [
        GetPage(name: Routes.home, page: () =>HomeScreen())
      ],
      // home: HomeScreen(),
    );
  }
}