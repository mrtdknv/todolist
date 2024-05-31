import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton(
      {super.key,
      required this.color,
      required this.textColor,
      required this.text,
      required this.onTap});
  final Color color;
  final Color textColor;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.45,
      height: Get.height * 0.07,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(
          color: Colors.black,
          width: 3.sp,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
