// ignore_for_file: prefer_collection_literals, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;

  UserModel({
    this.uid,
    this.name,
    this.email,
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    uid = documentSnapshot?.id;
    name = documentSnapshot?["name"];
    email = documentSnapshot?["email"];
  }
}
