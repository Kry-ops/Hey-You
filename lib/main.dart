import 'package:flutter/material.dart';
import 'package:hey_you/pages/first_loading_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HeYou',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const FirstLoadingPage(),
    );
  }
}