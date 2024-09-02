import 'package:firebase_app/view/screens/personal_data.dart';
import 'package:firebase_app/view/screens/Add_User_Info.dart';
import 'package:firebase_app/view/screens/Username_Info.dart';
import 'package:firebase_app/view/screens/controller/controller.dart';
import 'package:firebase_app/view/widgets/default_text.dart';
import 'package:flutter/material.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width - 150,
        child: Column(
          children: [
            Container(height: 190, color: Colors.amber.withOpacity(0.6)),
          ],
        ),
      ),
      body: Center(
          child: SizedBox(
        height: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddUserInfo()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 95,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.amber),
                  child: DefaultText(
                      text: 'Add User',
                      fontSize: 20,
                      style: const TextStyle(color: Colors.black)),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PersonalData()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 95,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.amber),
                  child: DefaultText(
                      text: 'Personal Data',
                      fontSize: 20,
                      style: const TextStyle(color: Colors.black)),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Detials()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 95,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.amber),
                  child: DefaultText(
                      text: 'All Data',
                      fontSize: 20,
                      style: const TextStyle(color: Colors.black)),
                ),
              ),
              InkWell(
                onTap: () {
                  Controller().signOut(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 95,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.amber),
                  child: DefaultText(
                      text: 'Sign Out',
                      fontSize: 20,
                      style: const TextStyle(color: Colors.black)),
                ),
              ),
            ]),
          ],
        ),
      )),
    );
  }
}
