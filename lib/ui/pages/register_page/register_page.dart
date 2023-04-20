import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_bloc/provider/news_provider.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key,
  this.showLoginPage
  }) : super(key: key);

  final VoidCallback? showLoginPage;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NewsProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
          Lottie.network('https://assets3.lottiefiles.com/packages/lf20_jcikwtux.json',
          width: 180,
          height: 180,
          ),
          const SizedBox(height: 10,),
          const Text('Let\'s register Now !!!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          ),
          const SizedBox(height: 10,),
            TextFormField(
              //first name textField
              //
              controller: model.nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'First Name',
                  labelText: 'First Name'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              //last name textField
              //
             controller: model.lastNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Last Name',
                  labelText: 'Last Name'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              //Age textField
              //
             controller: model.ageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Age',
                  labelText: 'Age'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              //first name textField
              //
              controller: model.regEmailController,
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
              controller: model.regPasswordController,
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
            TextFormField(
            obscureText: true,
            controller: model.regPasswordConfirmController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password'),
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: (){},
            //     child: const Text('Forgot Password',
            //     style: TextStyle(
            //       color: Colors.deepPurple,
            //       fontSize: 20,
            //     ),
            //     )),
            // ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
               
               ),
               padding: const EdgeInsets.symmetric(horizontal: 20), 
              ),
              onPressed: model.signUp,
              child: const Text(
                'Register',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text('You are a member ?',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              ),
               
              TextButton(onPressed: showLoginPage, child: const Text('Login',
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,
              ),
              ),),
            ],)
          ],
        ),
      ),
    );
  }
}
