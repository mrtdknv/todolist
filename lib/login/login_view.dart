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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //1
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //2
  final AuthService _authService = AuthService();
  //3
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    if (_emailController.text.toString().isEmpty ||
        _passwordController.text.toString().isEmpty) {
      // ignore: avoid_print
      print("controllers empty");
    } else {
      await _authService
          .signIn(_emailController.text.toString(),
              _passwordController.text.toString())
          .then(
        (_) {
          Get.to(() => const SplashView());
        },
      );
    }
  }

  @override
  void dispose() {
    //sayfa kapanacağı zaman controller ları temizliyoruz
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 50.h,
          bottom: 15.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthIconButton(),
            const AuthTitle(title: "Giriş Yap "),
            Form(
              key: formKey,
              child: Wrap(
                children: [
                  AuthField(
                    isPassword: false,
                    controller: _emailController,
                    hintText: "Email",
                    validator: AppValidator.instance.validateEmail,
                  ),
                  AuthField(
                    isPassword: true,
                    controller: _passwordController,
                    hintText: "Şifre",
                    validator: AppValidator.instance.validatePassword,
                  ),
                ],
              ),
            ),
            AuthButton(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  signIn();
                }
              },
              title: "Giriş Yap",
            ),
          ],
        ),
      ),
    );
  }
}
