import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_bloc/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC278MOY4et0ML0waf9-b5VcvX4eI7FTHM", 
      appId: "1:88789684936:android:ba340b47715c1b7e8782fd", 
      messagingSenderId: "887689684936", 
      projectId: "news-app-2e7ac",
      storageBucket: "news-app-2e7ac.appspot.com",
      ),
  );
  runApp(const NewsApp());
}



