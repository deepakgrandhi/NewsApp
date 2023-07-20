import 'package:cometlabs/screens/home/home_screen.dart';
import 'package:cometlabs/screens/news_page/news_item_details_screen.dart';
import 'package:cometlabs/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme
          .apply(bodyColor: Colors.black),
      ),
      routes: {
        "/": (context) => const SplashScreen(),
        "/home": (context) => const HomeScreen(),
        "/news_item_details": (context) => const NewsItemDetailsScreen()
      },
    );
  }
}
