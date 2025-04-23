import 'package:betclic_app/res/app_colors.dart';
import 'package:betclic_app/style.dart';
import 'package:betclic_app/ui/details/product_details.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Avenir',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        extensions: [OffThemeExtension.defaultValues()],
        dividerColor: AppColors.gray2,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.blue,
          unselectedItemColor: AppColors.gray2,
          type: BottomNavigationBarType.fixed,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          indicatorColor: AppColors.blue,
        ),
      ),
      home: const ProductDetails(),
    );
  }
}
