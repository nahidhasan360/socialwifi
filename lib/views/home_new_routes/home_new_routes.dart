import 'package:flutter/material.dart';

class HomeNewRoutes extends StatelessWidget {
  const HomeNewRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff341e7f),

      body: Center(   // <-- পুরো কন্টেন্ট এখন স্ক্রিনের একদম মাঝখানে যাবে
        child: SizedBox(
          width: 330,
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'League Gothic',
                fontWeight: FontWeight.w400,
                height: 1.25,
                letterSpacing: 1,
              ),
              children: [
                TextSpan(text: 'EXPERIENCE THE EASE OF '),
                TextSpan(text: 'AUTOMATED'),
                TextSpan(text: ' VISUAL AND VOICE GUIDED '),
                TextSpan(text: 'PERMITTED '),
                TextSpan(text: 'ROUTE NAVIGATION'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
