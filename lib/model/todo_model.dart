import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? title;
  String? subtitle;
  Timestamp? time;

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    time = json['time'] as Timestamp?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['time'] = time;
    return data;
  }
}
