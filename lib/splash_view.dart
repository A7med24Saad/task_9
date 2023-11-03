import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_9/core/styles.dart';
import 'package:task_9/features/firstscreen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const firstscreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/Animation - 1698840814116.json"),
            Text(
              'Taskati',
              style: getTitleStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'It\'s Time To Get Orginzed',
              style: getSmallTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
