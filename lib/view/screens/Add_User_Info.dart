import 'dart:io';
import 'package:firebase_app/view/screens/controller/controller.dart';
import 'package:firebase_app/view/screens/homescreen.dart';
import 'package:firebase_app/view/widgets/default_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_snackbar.dart';

class AddUserInfo extends StatefulWidget {
  const AddUserInfo({super.key});

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

class _AddUserInfoState extends State<AddUserInfo> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    final controller = Controller();
    return Center(
        child: Scaffold(
            appBar: AppBar(
              title: DefaultText(text: 'Add User'),
              centerTitle: true,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          Container(
                              height: 210,
                              width: 300,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                    Center(
                                      child: _image == null
                                          ? Text('No image selected.')
                                          : Image.file(_image!,
                                              width: 110,
                                              height: 110,
                                              fit: BoxFit.fill),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final image = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (image != null) {
                                          setState(() {
                                            _image = File(image.path);
                                          });
                                        }
                                      },
                                      child: Text('Select image'),
                                    )
                                  ]))),
                          const SizedBox(height: 15),
                          TextFormField(
                              controller: controller.fullname,
                              decoration: const InputDecoration(
                                  hintText: 'Full Name',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.amber)))),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: controller.age,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Age',
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber))),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: controller.address,
                            decoration: const InputDecoration(
                                hintText: 'Address',
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber))),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: controller.phone,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Phone',
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber))),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () async {
                              if (controller.fullname.text.isNotEmpty &&
                                  controller.age.text.isNotEmpty &&
                                  controller.address.text.isNotEmpty &&
                                  controller.phone.text.isNotEmpty &&
                                  _image.toString().isNotEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title:
                                              DefaultText(text: "Confirmation"),
                                          content: DefaultText(
                                              text:
                                                  "Are you sure you want to submit these details?"),
                                          actions: [
                                            TextButton(
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              ),
                                              onPressed: () {
                                                controller.fullname.clear();
                                                controller.age.clear();
                                                controller.address.clear();
                                                Navigator.of(context).pop();
                                                controller.phone.clear();
                                                _image!.delete();
                                              },
                                            ),
                                            TextButton(
                                                child: const Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      color: Colors.amber),
                                                ),
                                                onPressed: () async {
                                                  await controller.upLoadImage(
                                                      controller.fullname.text,
                                                      controller.age.text,
                                                      controller.phone.text,
                                                      controller.address.text,
                                                      _image);

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()));
                                                  controller.fullname.clear();
                                                  controller.age.clear();
                                                  controller.address.clear();
                                                  controller.phone.clear();

                                                  setState(() {
                                                    _image!.delete();
                                                  });
                                                  CustomSnackbar().customsnackbar(
                                                      context,
                                                      'Successful operation');
                                                })
                                          ]);
                                    });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: DefaultText(text: "Submit"),
                          ),
                        ]))))));
  }
}
