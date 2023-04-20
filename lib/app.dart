import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_bloc/provider/news_provider.dart';
import 'package:news_bloc/ui/pages/main_page/main_page.dart';
import 'package:provider/provider.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return ChangeNotifierProvider(
        create: (context) => NewsProvider(), child: const MaterialAppWidget());
  }
}

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NewsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: model.isTheme ?ThemeData.dark() : ThemeData.light(
        
     
      ),
      home: const MainPage(),
      
    );
  }
}
