import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExitConfirmationController extends GetxController {
  Future<bool> showExitConfirmation() async {
    final result = await Get.dialog(
      AlertDialog(
        title: Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false); // Dismiss popup, don't exit
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true); // Dismiss popup, exit app
              if (Platform.isIOS) {
                exit(0); // Handle iOS exit gracefully
              } else {
                SystemNavigator.pop(animated: true);
              }
            },
            child: Text('Yes'),
          ),
        ],
      ),
      barrierDismissible: false, // Prevent dismissal by tapping outside
    );
    return result ??
        false; // Default to false if popup is dismissed without a choice
  }
}
