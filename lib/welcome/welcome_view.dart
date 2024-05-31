import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/welcome_button.dart';
import '../login/login_view.dart';
import '../register/register_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.87,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/image/welcome.png"),
              ),
            ),
            child: Center(
              child: Text(
                "Murat To-do List",
                style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            width: Get.width,
            height: Get.height * 0.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WelcomeButton(
                  text: "Giriş Yap",
                  color: Colors.white,
                  textColor: Colors.black,
                  onTap: () {
                    Get.to(() => const LoginView()); //giriş yapma sayfası
                  },
                ),
                WelcomeButton(
                  text: "Kayıt Ol",
                  color: Colors.black,
                  textColor: Colors.white,
                  onTap: () {
                    Get.to(() => const RegisterView()); //kayıt olma sayfası
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
