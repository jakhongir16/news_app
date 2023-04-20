import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_bloc/provider/news_provider.dart';
import 'package:news_bloc/ui/pages/forgot_page/forgot_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, this.showRegisterPage}) : super(key: key);

  final VoidCallback? showRegisterPage;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NewsProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_TGwyPsBlNo.json',
              width: 180,
              height: 180,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Hello Again !!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: model.emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Email',
                  labelText: 'Email'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              obscureText: true,
              controller: model.passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Password',
                  labelText: 'Password'),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const ForgotPage(),
                    ));
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onPressed: model.signIn,
              child: const Text(
                'Sign in',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Not a member yet ?',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: showRegisterPage,
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
