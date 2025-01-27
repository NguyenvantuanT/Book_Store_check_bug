import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeText {
   TextTheme get textThemes => _textThemes;

final TextTheme _textThemes =  TextTheme(
  //head1

  headlineLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  ),

  headlineMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  ),

  headlineSmall: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  ),

  displayLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  ),
  //head2
  titleLarge:const TextStyle(
    color: Colors.black87,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  //head3
  bodyLarge:TextStyle(
    color: AppColors.textColor,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  ),
);
}
