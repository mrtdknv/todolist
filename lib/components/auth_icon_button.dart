import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthIconButton extends StatelessWidget {
  const AuthIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.reply,
          color: Colors.black,
          size: 30.sp,
        ),
      ),
    );
  }
}
