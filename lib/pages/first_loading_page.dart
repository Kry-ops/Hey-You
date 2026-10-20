import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:hey_you/pages/login_pages/regis_page.dart';

class FirstLoadingPage extends StatefulWidget {
  const FirstLoadingPage({super.key});

  @override
  State<FirstLoadingPage> createState() =>
      _FirstLoadingPageState();
}

class _FirstLoadingPageState extends State<FirstLoadingPage> {
  @override
  void initState() {
    super.initState();
    _mulaiLoading();
  }

  Future<void> _mulaiLoading() async {
    await Future.delayed(const Duration(seconds: 10));

    if (!mounted) return;

    Navigator.pushReplacement(
      context, MaterialPageRoute(
        builder: (context) => const RegistrationPage(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: Colors.deepPurpleAccent,
          secondRingColor: Colors.black,
          thirdRingColor: Colors.yellowAccent,
          size: 60,
        ),
      ),
    );
  }
}