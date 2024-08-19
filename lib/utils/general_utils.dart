import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static void fieldFocusChange(BuildContext context, FocusNode currFocus, FocusNode nextFocus){
    currFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }



  static toastMessage(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(20),
        borderColor: Colors.white,
        borderWidth: 2,
        title: 'Routing',
        message: message,
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        positionOffset: 20,
        icon: const Icon(
          Icons.warning,
          size: 30,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 2),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.yellow,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
