import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nepal_express/app/modules/home/controllers/home_controller.dart';
class BusController extends GetxController {

  var busNameController = TextEditingController();
  var fairController = TextEditingController();
  var yearsUsedController = TextEditingController();
  XFile? image;
  Uint8List? imageBytes;
  String? tripId;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

   void addBus() async {
    try {
      if (formKey.currentState!.validate()) {
        if (imageBytes == null) {
          showCustomSnackBar(
            message: 'Please select image',
          );
          return;
        }
        var url = Uri.http(ipAddress, 'bus_api/addBus.php');

        var request = http.MultipartRequest('POST', url);
        request.fields['token'] = Memory.getToken() ?? '';
        request.fields['name'] = busNameController.text;
        request.fields['fair'] = fairController.text;
        request.fields['years_used'] = yearsUsedController.text;
        request.fields['trip_id'] = tripId ?? '';
        request.files.add(http.MultipartFile.fromBytes(
          'avatar',
          imageBytes!,
          filename: image!.name,
        ));

       var response = await request.send();
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var result = jsonDecode(data);

        if (result['success']) {
          busNameController.clear();
          fairController.clear();
          yearsUsedController.clear();
          tripId = null;
          imageBytes = null;
          image = null;
          update();
          Get.back();
          showCustomSnackBar(
            message: result['message'],
            isSuccess: true,
          );

          Get.find<HomeController>().getBuses();
        } else {
          showCustomSnackBar(
            message: result['message'],
          );
        }
      } else {
        showCustomSnackBar(
          message: 'Failed to add bus. Server returned status code: ${response.statusCode}',
        );
      }
    }
    } catch (e) {
      showCustomSnackBar(
        message: 'Something went wrong while adding the bus.',
      );
    }
  }

  void pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      imageBytes = (await image!.readAsBytes());
      update();
    } catch (e) {}
  }

  void deleteBus(String busId) async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/deleteBus.php');

      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'bus_id': busId,
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.back();
        showCustomSnackBar(
          message: result['message'],
          isSuccess: true,
        );
        await Get.find<HomeController>().getBuses();
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
