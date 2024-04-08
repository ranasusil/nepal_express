import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/models/users.dart';
import 'package:nepal_express/app/modules/users/controllers/users_controller.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

class EditUserController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
var selectedUser = User().obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    selectedUser.value = Get.find<UsersController>().selectedUser.value;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
        fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }
  void updateUserDetails(User user) async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/editUser.php');

      var response = await http.post(url, body: {
          'token': Memory.getToken(),
        'user_id': user.userId ?? '',
        'email': user.email ?? '',
        'fullname': user.fullName ?? '',
        'address': user.address ?? '',
      });

      var result = jsonDecode(response.body);

      if (result['success']) {

        print(result['message']);
      } else {

        print(result['message']);
      }
    } catch (e) {

      print('Error: $e');
    }
  }

  void increment() => count.value++;
}
