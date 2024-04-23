import 'package:get/get.dart';
import 'package:flutter/material.dart';
const ipAddress = '192.168.0.9';

MaterialColor primaryColor = Colors.blueGrey;
var getImageUrl = (imageUrl) {
  return 'http://$ipAddress/bus_api/$imageUrl';
};
var showCustomSnackBar = ({
  required String message,
  bool isSuccess = false,
}) =>
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        snackPosition: SnackPosition.TOP,
      ),
    );

    