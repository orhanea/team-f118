import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void displayToast(BuildContext context, String text) {

  Fluttertoast.showToast(
    msg: text,
    gravity: ToastGravity.TOP,
  );

}