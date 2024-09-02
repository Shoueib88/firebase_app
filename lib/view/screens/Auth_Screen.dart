import 'package:firebase_app/view/widgets/auth_face_and_google.dart';
import 'package:firebase_app/view/screens/controller/controller.dart';
import 'package:firebase_app/view/widgets/default_form_filed.dart';
import 'package:firebase_app/view/widgets/default_text.dart';
import 'package:firebase_app/view/widgets/defult_button.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_snackbar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 150),
        DefaultText(
            text: 'Login',
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.amber),
        const SizedBox(height: 40),
        DefaultFormField(
          hintText: 'E-mail',
          controller: controller.email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        DefaultFormField(
          hintText: 'Password',
          controller: controller.password,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 70),
        DefultButton(
          text: 'Sign Up',
          textcolor: Colors.white,
          backgroundcolor: Colors.amber,
          onpressed: () {
            controller.signUpWithEmailAndPassword(
                controller.email.text, controller.password.text, context);
            controller.email.clear();
            controller.password.clear();
            CustomSnackbar().customsnackbar(context, 'Successful signup');
          },
        ),
        const SizedBox(height: 20),
        DefultButton(
          text: 'Sign In',
          textcolor: Colors.white,
          backgroundcolor: Colors.amber,
          onpressed: () {
            controller.signInWithEmailAndPassword(
                controller.email.text, controller.password.text, context);
          },
        ),
        const SizedBox(height: 20),
        DefaultText(text: '__________ Or Login With Account __________'),
        const SizedBox(height: 40),
        AuthWithFaceAndGoogle()
      ],
    )));
  }
}
