import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/view/screens/Auth_Screen.dart';
import 'package:firebase_app/view/screens/homescreen.dart';
import 'package:firebase_app/view/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Controller {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  var auth = FirebaseAuth.instance;
  var signinwithfacebook = FacebookAuth.instance;

  signUpWithEmailAndPassword(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential);
      // CustomSnackbar().customsnackbar(context, 'Success');

      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomSnackbar()
            .customsnackbar(context, 'The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithEmailAndPassword(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      CustomSnackbar().customsnackbar(context, 'Success');

      print(credential);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomSnackbar()
            .customsnackbar(context, 'No user found for that email.');

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await signinwithfacebook.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signinwithgoogle() async {
    //googleSignInAccount
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    //GoogleSignInAuthentication
    final GoogleSignInAuthentication googleauth =
        await googleSignInAccount!.authentication;

    //Firebase credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleauth.accessToken, idToken: googleauth.idToken);

    return await _auth.signInWithCredential(credential);
  }

  signOut(context) async {
    await GoogleSignIn().signOut();
    await auth.currentUser!.delete();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AuthScreen()));
  }

  final firestore = FirebaseFirestore.instance;
  final realtime = FirebaseDatabase.instance;
  int index = 0;

  upLoadImage(fullname, age, phone, address, File? image) async {
    index++;
    // Upload image file to Firebase Storage
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef =
        FirebaseStorage.instance.ref().child('users/$imageName.jpg');
    var uploadTask = storageRef.putFile(image!);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();

    // using firestore

    firestore.collection("user").add({
      "Name": fullname,
      "Age": age,
      "Address": address,
      "Phone": phone,
      // Add image reference to document
      "Image": downloadUrl.toString()
    });

    //using firebase real time database
    realtime
        .reference()
        .child("User_Information")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "Name": fullname,
      "Age": age,
      "Address": address,
      "Phone": phone,
      "Image": downloadUrl.toString()
    });
  }

  List<Map<dynamic, dynamic>> listofdata = [];
  getData() async {
    listofdata.clear();
    await firestore.collection('user').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
        listofdata.add(element.data());
        print('===============================');
        print(listofdata);
      });
    });
    // await realtime.ref().child('User_Information').get().then((snapshot) {
    //   Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    //   values.forEach((key, value) {
    //     print(value);
    //     if (value is Map<dynamic, dynamic>) {
    //       listofdata.add(value);
    //       print('===============================  true');
    //     }
    //   });
    // });
  }

  List listofpersonaldata = [];

  getPersonalData() async {
    final snapshot = await realtime
        .reference()
        .child("User_Information")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      listofpersonaldata.add(snapshot.value);
      print('///////// $listofpersonaldata');
    } else {
      throw ("***************************No data available");
    }
  }
}
