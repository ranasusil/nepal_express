import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nepal_express/app/models/users.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

class UsersController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var addressController = TextEditingController();
  var registerFormKey = GlobalKey<FormState>();
  String roleValue = 'user';

  var users = <User>[].obs;
  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  void onRegister() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAddress, 'bus_api/addUser.php');

        var response = await http.post(url, body: {
          'token': Memory.getToken(),
          'fullname': fullNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'address': addressController.text,
          'role': roleValue,
        });

        var result = jsonDecode(response.body);

        if (result['success']) {
          fullNameController.clear();
          emailController.clear();
          passwordController.clear();
          addressController.clear();
          // update();
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

  void getUsers() async {
    try {
      var url = Uri.http(
          ipAddress, 'bus_api/getUsers.php', {'token': Memory.getToken()});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          List<dynamic> usersData = jsonData['users'];
          users.assignAll(
              usersData.map((userData) => User.fromJson(userData)).toList());
        } else {
          print('API Error: ${jsonData['message']}');
        }
      } else {
        print('HTTP Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
