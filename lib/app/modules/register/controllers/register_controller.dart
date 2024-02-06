import 'dart:convert';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var addressController = TextEditingController();

  var registerFormKey = GlobalKey<FormState>();

  final count = 0.obs;

  void onRegister() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAddress, 'bus_api/auth/register.php');

        var response = await http.post(url, body: {
          'fullname': fullNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'address': addressController.text,
        });

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          showCustomSnackBar(
            message: result['message'],
            isSuccess: true,
          );
        } else {
          showCustomSnackBar(
            message: result['message'],
          );
        }
      } catch (e) {
        showCustomSnackBar(
          message: 'Something went wrong',
        );
      }
    }
  }

  void increment() => count.value++;
}

