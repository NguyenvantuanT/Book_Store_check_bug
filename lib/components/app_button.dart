import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    this.onTap,
    this.text = "text",
    this.icon,
    this.height = 45.0,
    BorderRadius? borderRadius,
    Color? bgColor,
    Color? boderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
  })  : borderRadius = borderRadius ?? BorderRadius.circular(8.0),
        bgColor = bgColor ?? AppColors.bgColor,
        boderColor = boderColor ?? AppColors.black;

  final Function()? onTap;
  final String text;
  final Icon? icon;
  final double height;
  final BorderRadius? borderRadius;
  final Color bgColor;
  final Color boderColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          border: Border.all(color: AppColors.black),
          borderRadius: borderRadius,
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 4.6),
            ],
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }
}
