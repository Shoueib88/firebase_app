import 'package:flutter/material.dart';

class CustomSnackbar {
  customsnackbar(context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 50, 47, 47),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 120,
            right: 17,
            left: 17),
        dismissDirection: DismissDirection.up,
        content:
            Container(margin: const EdgeInsets.all(15), child: Text(text))));
  }
}
