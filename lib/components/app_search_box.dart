import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppSearchBox extends StatelessWidget {
  const AppSearchBox({super.key, this.searchText, this.onChange, this.controller});

  final String? searchText;
  final Function(String?)? onChange;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 45.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          border: Border.all(color: AppColors.grey,width: 0.8),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              offset:const Offset(3.0, 3.0),
              blurRadius: 6.0
            ),
          ]
        ),
        child: TextField(
          controller: controller,
          onChanged: onChange,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
            border: InputBorder.none,
            hintText: "Search for book",
            hintStyle: TextStyle(color: AppColors.grey, fontSize: 15),
            suffixIcon: Icon(Icons.search, color: AppColors.grey,),
          ),
        ),
      ),
    );
  }
}