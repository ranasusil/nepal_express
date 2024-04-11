import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_express/app/models/user.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:nepal_express/app/utils/constants.dart';

class ProfileController extends GetxController {
  UserResponse? userResponse;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getMyDetails();
  }

  void getMyDetails() async {
    try {
      Uri url = Uri.http(ipAddress, 'bus_api/getMyDetails.php');
      var response = await http.post(url, body: {"token": Memory.getToken()});
      var result = userResponseFromJson(response.body);

      if (result.success ?? false) {
        userResponse = result;
        update();
      } else {
        showCustomSnackBar(message: result.message ?? 'Failed to fetch details');
      }
    } catch (e) {
      showCustomSnackBar(message: 'Error: ${e.toString()}');
    }
  }

  void changePassword(String newPassword) async {
    try {
      Uri url = Uri.http(ipAddress, 'bus_api/changePassword.php');
      var response = await http.post(url, body: {
        "token": Memory.getToken(),
        "email": userResponse?.user?.email ?? '',
        "new_password": newPassword
      });

      var result = jsonDecode(response.body);

      if (result['success'] ?? false) {
        showCustomSnackBar(message: result['message'] ?? 'Password changed successfully',isSuccess: true,);
      } else {
        showCustomSnackBar(message: result['message'] ?? 'Failed to change password');
      }
    } catch (e) {
      showCustomSnackBar(message: 'Error: ${e.toString()}');
    }
  }


  void editProfile(String email, String fullname, String address) async {
  try {
    Uri url = Uri.http(ipAddress, 'bus_api/editProfile.php');
    var response = await http.post(url, body: {
      "token": Memory.getToken(),
      "email": email,
      "fullname": fullname,
      "address": address,
    });

    var result = jsonDecode(response.body);

    if (result['success'] ?? false) {
      showCustomSnackBar(message: result['message'] ?? 'Profile updated successfully', isSuccess: true,);
 getMyDetails();
      update();
      update();
      
    } else {
      showCustomSnackBar(message: result['message'] ?? 'Failed to update profile');
    }
  } catch (e) {
    showCustomSnackBar(message: 'Error: ${e.toString()}');
  }
}

}
