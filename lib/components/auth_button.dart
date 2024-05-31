import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onTap, required this.title});
  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.08,
      margin: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
