class AppValidator {
  static AppValidator? _instace;
  static AppValidator get instance {
    // ignore: prefer_conditional_assignment
    if (_instace == null) _instace = AppValidator._init();
    return _instace!;
  }

  AppValidator._init();

  String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return "Yanlış Email Formatı..";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return "Şifreniz En Az 6 Harf Olmalı..";
    } else {
      return null;
    }
  }

  String? validateName(String? value) {
    String pattern = r'^[a-zA-ZçğıöşüÇĞİÖŞÜ ]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return "Uygun Olmayan Karakter Girdiniz..";
    } else {
      return null;
    }
  }
}
