import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/auth_button.dart';
import '../../../components/auth_field.dart';
import '../../../components/auth_icon_button.dart';
import '../../../components/auth_title.dart';
import '../../../service/auth_service.dart';
import '../splash-error/splash_view.dart';
import '../validator/app_validator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthService authService = AuthService();
  Future<void> register() async {
    await authService.createUser(
      nameController.text.toString(),
      emailController.text.toString(),
      passwordController.text.toString(),
    );
    Get.to(() => const SplashView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 50.h,
          bottom: 15.h,
        ),
        children: [
          const AuthIconButton(),
          const AuthTitle(title: "Kayıt Ol "),
          Form(
            key: formKey,
            child: Column(
              children: [
                AuthField(
                  isPassword: false,
                  hintText: "Isim Soyisim",
                  controller: nameController,
                  validator: AppValidator.instance.validateName,
                ),
                AuthField(
                  isPassword: false,
                  hintText: "Email",
                  controller: emailController,
                  validator: AppValidator.instance.validateEmail,
                ),
                AuthField(
                  isPassword: true,
                  hintText: "Şifre",
                  controller: passwordController,
                  validator: AppValidator.instance.validatePassword,
                ),
              ],
            ),
          ),
          AuthButton(
            onTap: () {
              if (formKey.currentState!.validate()) {
                register();
              }
            },
            title: "Kayıt Ol",
          ),
        ],
      ),
    );
  }
}
