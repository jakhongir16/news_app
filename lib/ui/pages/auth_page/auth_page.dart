import 'package:flutter/material.dart';
import 'package:news_bloc/provider/news_provider.dart';
import 'package:news_bloc/ui/pages/login_page/login_page.dart';
import 'package:news_bloc/ui/pages/register_page/register_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NewsProvider>(context);
    if (model.showLoginPage) {
      return LoginPage(
        showRegisterPage: model.toggleScreens,
      );
    } else {
      return RegisterPage(
        showLoginPage: model.toggleScreens,
      );
    }
  }
}
