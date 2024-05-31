import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../cache/local_storage.dart';
import '../model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<User?> signIn(String email, String password) async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    LocalStorage.setToken(user.user!.uid);
    return user.user;
  }

  signOut() async {
    LocalStorage.clearToken();
    return await _auth.signOut();
  }

  Future<User?> createUser(
    String name,
    String email,
    String password,
  ) async {
    var user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _firestore.collection("User").doc(user.user?.uid).set(
      {
        'uid': user.user?.uid.toString(),
        'name': name,
        'email': email,
      },
    );
    LocalStorage.setToken(user.user!.uid);
    return user.user;
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection("User").doc(uid).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: doc);
    } catch (e) {
      return UserModel(uid: "errorrr");
    }
  }
}
