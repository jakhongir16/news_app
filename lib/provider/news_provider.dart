import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_bloc/ui/pages/login_page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsProvider extends ChangeNotifier {
  NewsProvider() {
    getTheme();
  }

  bool isTheme = false;

  // login page controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // register page controllers
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final regEmailController = TextEditingController();
  final regPasswordController = TextEditingController();
  final regPasswordConfirmController = TextEditingController();

  // контроллер сброса пароля
  final resetController = TextEditingController();

  //авторизации
  Future signIn() async {
    if (emailController.text == '' && passwordController.text == '') {
      return const LoginPage();
    } else {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((value) => controllersClear());
    }
  }

  Future controllersClear() async {
    emailController.clear();
    passwordController.clear();
    regEmailController.clear();
    regPasswordController.clear();
    regPasswordConfirmController.clear();
    resetController.clear();
  }

  changeTheme() async {
    isTheme = !isTheme;
    final pref = await SharedPreferences.getInstance();
    pref.setBool('theme', isTheme);
    notifyListeners();
  }

  getTheme() async {
    final pref = await SharedPreferences.getInstance();
    isTheme = pref.getBool('theme') ?? isTheme;
    notifyListeners();
  }

  // переключение между экранам авторизации и регистрации
  bool showLoginPage = true;
  void toggleScreens() {
    showLoginPage = !showLoginPage;
    notifyListeners();
  }

  // регистрация
  Future signUp() async {
    if (passwordConfirmed() && regEmailController.text.trim() != '' ||
        regPasswordController.text.trim() != '') {
      // create user

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: regEmailController.text.trim(),
          password: regPasswordController.text.trim());

      addUserDetails(
        firstName: nameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: regEmailController.text.trim(),
        age: ageController.text.trim(),
      );
    }
  }

  Future addUserDetails(
      {String firstName = '',
      String lastName = '',
      String age = '',
      String email = ''}) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'age': age,
    });
  }

  //проверку совпадения паролей
  bool passwordConfirmed() {
    if (regPasswordController.text.trim() ==
        regPasswordConfirmController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  // сброс пароля
  Future passwordReset(BuildContext context) async {
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetController.text.trim())
          .then((value) =>
              ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                backgroundColor: Colors.grey[700],
                content: Text('Check your ${resetController.text} email'),
                actions: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                    },
                    child: const Text(
                      'Close',
                    ),
                  ),
                ],
              )));
    } catch (e) {
      throw Exception('Error');
    }
  }
}
