import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/auth_button.dart';
import '../../../components/auth_field.dart';
import '../../../components/auth_icon_button.dart';
import '../../../components/auth_title.dart';
import '../home/home_view.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  Timestamp time = Timestamp.now();

  String formatDateTime(DateTime dateTime) {
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    String dayString = day.toString().padLeft(2, '0');
    String monthString = month.toString().padLeft(2, '0');

    return '$dayString/$monthString/$year';
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const AuthIconButton(),
            const AuthTitle(title: "Todo ekle !"),
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
            AuthField(
              isPassword: false,
              hintText: "Zamanı Seçiniz..",
              onTap: () {
                buildDatePicker(context);
              },
              keyboardType: TextInputType.none,
              controller: TextEditingController(
                text: formatDateTime(time.toDate()),
              ),
            ),
            AuthButton(
              //yeni to do ekleniyor
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("User")
                    .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                    .collection("Todo")
                    .doc()
                    .set(
                  {
                    "title": titleController.text.toString(),
                    "subtitle": subtitleController.text.toString(),
                    "time": time,
                  },
                );
                Get.off(() => const HomeView());
              },
              title: "Todo Ekle",
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildDatePicker(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: context.width,
          height: context.height * 0.4,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 75.w,
                height: 10.h,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 250.h,
                width: context.width,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  initialDateTime: DateTime.now(),
                  dateOrder: DatePickerDateOrder.dmy,
                  showDayOfWeek: false,
                  maximumDate: DateTime.utc(2030),
                  maximumYear: 2030,
                  onDateTimeChanged: (value) {
                    time = Timestamp.fromDate(value);
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: Size(300.w, 50.h),
                ),
                onPressed: () {
                  Get.back();
                  setState(() {});
                },
                child: Text(
                  "Kaydet",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
