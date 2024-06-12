
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'my_colors.dart';

class ToastClass{
  static void showCustomToast(BuildContext context,String message, String toastType, {bool lonMsg = false}) {
  MotionToast(
    width: 300,
    height: lonMsg == true ? 150 : 80,
    dismissable: false,
    toastDuration: const Duration(milliseconds: 2000),
    layoutOrientation:
        translator.activeLanguageCode=="en"
            ? ToastOrientation.ltr
            : ToastOrientation.rtl,
    icon: toastType == "sucess" ? Icons.check_circle : Icons.error,
    displayBorder: false,
    displaySideBar: false,
    title: Text(
      toastType,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: _getToastColor(toastType)),
    ),
    position: toastType == "sucess"
        ? MotionToastPosition.bottom
        : MotionToastPosition.top,
    animationType:
        toastType == "error" ? AnimationType.fromTop : AnimationType.fromBottom,
    description: Text(
      message,
      style: const TextStyle(fontSize: 16, color: Colors.black),
    ),
    primaryColor: _getToastColor(toastType),
  ).show(context);
}

static _getToastColor(String toastType) {
  switch (toastType) {
    case "sucess":
      return Colors.green;
    case "error":
      return Colors.red;
    case "info":
      return Colors.blue;
  }
}
}