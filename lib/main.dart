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
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF4B4242),
          selectionColor: Color(0xFFD58A65),
          selectionHandleColor: Color(0xFF4B4242),
        ),
      ),
      home: const FirstLoadingPage(),
    );
  }
}