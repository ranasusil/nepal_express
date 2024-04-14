import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

class FeedbackController extends GetxController {
 final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

   void sendFeedback() async {
    try {
      Uri url = Uri.http(ipAddress, 'bus_api/sendFeedback.php');
      var response = await http.post(
        url,
        body: {
          'token': Memory.getToken() ?? '',
          'description': descriptionController.text,
        },
      );

      var result = jsonDecode(response.body);
      if (result['success']) {
        showCustomSnackBar(
          message: "Feedback submitted successfully!",
          color: const Color.fromARGB(255, 32, 253, 76).withOpacity(0.70),
        );
        

        descriptionController.clear();


        FocusScope.of(Get.context!).unfocus();
      } else {
        showCustomSnackBar(
          message: result['message'],
          color: Colors.red,
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: e.toString(),
        color: Colors.red,
      );
    }
  }

  void showCustomSnackBar({required String message, Color? color}) {
    Get.snackbar(
      'Feedback Status',
      message,
      backgroundColor: color ?? Colors.red,
    );
  }

  void increment() => count.value++;
}
