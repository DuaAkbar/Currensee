import 'package:curren_see/widgets/confirmationModal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helpers {
  static void showCustomSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      backgroundColor:  Color(0xFFD81B60), // Primary color
      colorText: Colors.white,
      titleText: Text(
      title,
      style:  TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    messageText: Text(
      message,
      style:  TextStyle(
        color: Colors.white,
      ),
    ),
    );
  }

  static void showConfirmationDialogue(
    String title,
    String message,
    VoidCallback callback,
  ) {
    Get.dialog(
      ConfirmationModal(title: title, message: message, callback: callback),
    );
  }
}
