import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    this.controller,
    required this.isPassword,
    required this.hintText,
    this.validator,
    this.isRead,
    this.onTap,
    this.keyboardType,
  });
  final TextEditingController? controller;
  final bool isPassword;
  final String hintText;
  final String? Function(String? value)? validator;
  final bool? isRead;
  final void Function()? onTap;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        keyboardType: keyboardType,
        onTap: onTap,
        readOnly: isRead ?? false,
        validator: validator,
        controller: controller,
        obscureText: isPassword ? true : false,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: getInputBorder,
          enabledBorder: getInputBorder,
          errorBorder: getInputBorder,
          focusedErrorBorder: getInputBorder,
          disabledBorder: getInputBorder,
        ),
      ),
    );
  }

  OutlineInputBorder get getInputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.sp),
      borderSide: BorderSide(
        color: Colors.black,
        width: 3.sp,
      ),
    );
  }
}
