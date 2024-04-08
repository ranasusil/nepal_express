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
  final selectedUser = User().obs; // Observable for storing selected user data

  String roleValue = 'user';
  static const int usersPerPage = 10; // Static member for total users per page
  var users = <User>[].obs;

  int currentPage = 1; // Current page number
  // int usersPerPage = 10; // Remove this line, as it conflicts with the static member

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
      int startIndex = (currentPage - 1) * usersPerPage;
      var url = Uri.http(ipAddress, 'bus_api/getUsers.php', {
        'token': Memory.getToken(),
        'page': '$currentPage',
        'limit': '$usersPerPage'
      });
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

  void deleteUser(String userId) async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/deleteUser.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'user_id': userId,
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.back();
        showCustomSnackBar(
          message: result['message'],
          isSuccess: true,
        );

        getUsers();
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
  void fetchUserById(String userId) async {
  try {
    var url = Uri.http(ipAddress, 'bus_api/getUserById.php', {'user_id': userId});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        var userData = jsonData['user'];
        var user = User.fromJson(userData);
        // Update the user details in the controller
        selectedUser.value = user;
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

void updateUserDetails(String userId, String fullName, String email, String address) async {
  try {
    var url = Uri.http(ipAddress, 'bus_api/editUser.php');
    var response = await http.post(url, body: {
      'token': Memory.getToken(),
      'user_id': userId,
      'fullname': fullName,
      'email': email,
      'address': address,
    });

    var result = jsonDecode(response.body);

    if (result['success']) {
      getUsers(); 
      showCustomSnackBar(message: result['message'], isSuccess: true);
    } else {
      showCustomSnackBar(message: result['message']);
    }
  } catch (e) {
    showCustomSnackBar(message: 'Error: $e');
  }
}


  void nextPage() {
    currentPage++;
    getUsers();
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      getUsers();
    }
  }
}
