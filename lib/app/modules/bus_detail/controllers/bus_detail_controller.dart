import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepal_express/app/models/bus.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
class BusDetailController extends GetxController{

final Bus bus = Get.arguments as Bus;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var remarksController = TextEditingController();
var formKey = GlobalKey<FormState>();


  void makeBooking() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      Uri url = Uri.http(ipAddress, 'bus_api/makeBooking.php');
      var response = await http.post(
        url,
        body: {
          'token': Memory.getToken() ?? '',
          'bus_id': bus.id.toString(),
          'date': "${dateController.text} ${timeController.text}",
          'remarks': remarksController.text,
        },
      );

      var result = jsonDecode(response.body);
      if (result['success']) {
        //makePayment(result['appointment_id'].toString());
      } else {
        showCustomSnackBar(
          message: result['message'],
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: e.toString(),
      );
    }
  }

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

  void increment() => count.value++;
}
