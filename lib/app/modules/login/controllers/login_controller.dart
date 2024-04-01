import 'dart:convert';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final count = 0.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void increment() {
    count.value++;
  }

  void onLogin() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAddress, 'bus_api/auth/login.php');

        var response = await http.post(url, body: {
          'email': emailController.text,
          'password': passwordController.text,
        });
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);

          if (result['success'] != null && result['success']) {
            showCustomSnackBar(
              message: result['message'],
              isSuccess: true,
            );
            Memory.setToken(result['token']);
            Memory.setRole(result['role']);

            var role = Memory.getRole();

            var isAgency = role == 'agency';
            var isAdmin = role == 'admin';

            if (isAgency) {
              Get.offAllNamed(Routes.TRAVEL_AGENCY_HOME);
            } else if (isAdmin) {
              Get.offAllNamed(Routes.ADMIN_MAIN);
            } else {
              Get.offAllNamed(Routes.MAIN);
            }
          } else {
            showCustomSnackBar(
              message: result['message']?? 'Login failed',
            );
          }
        } else {
          showCustomSnackBar(
            message: 'Failed to connect to the server',
          );
        }
      } catch (e) {
        showCustomSnackBar(
          message: 'Something went wronggg',
        );
      }
    }
  }
   void showCustomSnackBar({required String message, bool isSuccess = false}) {
    Get.snackbar(
      isSuccess ? 'Success' : 'Error',
      message,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
  }
}
