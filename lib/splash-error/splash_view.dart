import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../cache/local_storage.dart';
import '../controller/user_controller.dart';
import '../home/home_view.dart';
import '../service/auth_service.dart';
import '../welcome/welcome_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  //getx kullanıcı kontrollerı çağırıyoruz
  //1
  UserController currentUser = //content provider
      Get.put<UserController>(UserController(), permanent: true);

  final AuthService _authService = AuthService();

  Future getUserFromDatabase() async {
    currentUser.user = await _authService
        .getUser((FirebaseAuth.instance.currentUser?.uid).toString());
  }

  bool girisYapildiMi = LocalStorage.isSignIn();
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (girisYapildiMi) {
          //daha önce giriş yapıldıysa   BONUS
          await getUserFromDatabase();
          Get.offAll(() => const HomeView()); //ana sayfa
        } else {
          Get.offAll(() => const WelcomeView()); //hoşgeldiniz sayfası
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //6
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Murat To-Do List",
            style: TextStyle(
              color: Colors.black,
              fontSize: 35.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
