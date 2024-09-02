import 'package:firebase_app/view/screens/homescreen.dart';
import 'package:flutter/material.dart';

import '../screens/controller/controller.dart';
import 'default_text.dart';

class AuthWithFaceAndGoogle extends StatelessWidget {
  const AuthWithFaceAndGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Controller();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.signinwithgoogle();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Container(
                alignment: Alignment.center,
                width: 145,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/google.jpg', scale: 15),
                    const SizedBox(width: 10),
                    DefaultText(text: 'Google'),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10))),
          ),
          GestureDetector(
            onTap: () {
              controller.signInWithFacebook();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Container(
                alignment: Alignment.center,
                width: 145,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/facebook.png', scale: 20),
                    const SizedBox(width: 10),
                    DefaultText(text: 'Facebook'),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }
}
