import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muratodos/model/todo_model.dart';
import '../../../controller/user_controller.dart';
import '../../../service/auth_service.dart';
import '../components/auth_button.dart';
import '../components/auth_field.dart';
import '../components/auth_title.dart';
import '../todo/todo_view.dart';
import '../welcome/welcome_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthService authService = AuthService();
  late UserController currentUser;

  @override
  void initState() {
    currentUser = Get.find<UserController>();
    super.initState();
  }

  String formatDateTime(DateTime dateTime) {
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    String dayString = day.toString().padLeft(2, '0');
    String monthString = month.toString().padLeft(2, '0');

    return '$dayString/$monthString/$year';
  }

  Color getColorFromData(DateTime datetime) {
    var dateNow = DateTime.now();

    if (dateNow.isBefore(datetime)) {
      return Colors.green;
    }
    if (dateNow.isAfter(datetime)) {
      return Colors.red;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(() => const TodoView()); //todo ekleme sayfası
        },
        child: Icon(
          Icons.add,
          size: 30.sp,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.19,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.15,
                    width: Get.width,
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(text: "Hoşgeldin: "),
                              TextSpan(text: currentUser.user.name.toString()),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            await authService.signOut(); //çıkış
                            Get.to(() => const WelcomeView());
                          },
                          icon: Icon(
                            Icons.logout,
                            size: 25.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              //2
              future: FirebaseFirestore.instance
                  .collection("User")
                  .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                  .collection("Todo")
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //yükeniyor kısmı
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "Şuan Bir todo yok !",
                      style: TextStyle(fontSize: 25.sp),
                    ),
                  );
                }
                return ListView(
                  //3
                  padding: EdgeInsets.all(20.sp),
                  children: snapshot.data!.docs.map((doc) {
                    var model = TodoModel.fromJson({
                      "title": doc['title'],
                      "subtitle": doc['subtitle'],
                      "time": doc['time'],
                    });

                    var formattedTime = formatDateTime(model.time!.toDate());

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      width: Get.width,
                      height: Get.height * 0.115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: ListTile(
                        onTap: () {
                          showTodo(doc);
                        },
                        leading: Icon(
                          Icons.star,
                          size: 30.sp,
                          color: Colors.black,
                        ),
                        title: Text(
                          model.title.toString(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.subtitle.toString(),
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black54,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: getColorFromData(model.time!.toDate()),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateTodo(doc);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 30.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await doc.reference.delete(); //silme işlemi
                                setState(() {});
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.black,
                                size: 30.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showTodo(QueryDocumentSnapshot<Object?> doc) {
    final titleController = TextEditingController(
      text: doc['title'],
    );
    final subtitleController = TextEditingController(
      text: doc['subtitle'],
    );

    Get.bottomSheet(
      Container(
        width: 390.w,
        height: 600.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(10.sp),
        child: ListView(
          children: [
            const AuthTitle(
              title: "Todo Detayları !",
            ),
            AuthField(
              isPassword: false,
              hintText: "Başlık giriniz..",
              controller: titleController,
              isRead: true,
            ),
            AuthField(
              isPassword: false,
              hintText: "İçerik giriniz..",
              controller: subtitleController,
              isRead: true,
            ),
            AuthButton(
              //yeni to do ekleniyor
              onTap: () {
                Get.back();
              },
              title: "Geri Dön",
            )
          ],
        ),
      ),
    );
  }

  void updateTodo(QueryDocumentSnapshot<Object?> doc) {
    final titleController = TextEditingController(
      text: doc['title'],
    );
    final subtitleController = TextEditingController(
      text: doc['subtitle'],
    );

    Get.bottomSheet(
      Container(
        width: 390.w,
        height: 600.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(10.sp),
        child: ListView(
          children: [
            const AuthTitle(title: "Todo güncelle !"),
            AuthField(
              isPassword: false,
              hintText: "Başlık giriniz..",
              controller: titleController,
            ),
            AuthField(
              isPassword: false,
              hintText: "İçerik giriniz..",
              controller: subtitleController,
            ),
            AuthButton(
              //yeni to do ekleniyor
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("User")
                    .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                    .collection("Todo")
                    .doc(doc.id)
                    .update(
                  {
                    "title": titleController.text.toString(),
                    "subtitle": subtitleController.text.toString()
                  },
                );
                Get.back();
                setState(() {});
              },
              title: "Todo Güncelle",
            )
          ],
        ),
      ),
    );
  }
}
