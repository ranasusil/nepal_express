import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepal_express/app/models/bus.dart';
import 'package:nepal_express/app/models/seat.dart';
import 'package:nepal_express/app/models/trip.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BusController extends GetxController {
    BusesResponse? busesResponse;
  TripResponse? tripResponse;

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
        getBuses();
    getTrips();
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
      // Call the getBuses method directly from the BusController
      getBuses();
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

    Future<void> getBuses() async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/getBuses.php');

      var response = await http.post(url, body: {"token": Memory.getToken()});
      busesResponse = busesResponseFromJson(response.body);
      update();

      if (busesResponse?.success ?? false) {
        // Success handling
      } else {
        // Error handling
      }
    } catch (e) {
      print(e);
      // Error handling
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
  Future<void> getTrips() async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/getTrips.php');

      var response = await http.post(url, body: {"token": Memory.getToken()});
      tripResponse = tripResponseFromJson(response.body);
      update();

      if (tripResponse?.success ?? false) {
        // Success handling
      } else {
        // Error handling
      }
    } catch (e) {
      print(e);
      // Error handling
    }
  }
  final RxList<Seat> seats = <Seat>[].obs;

  Future<void> getSeatsForBus(String busId, String token) async {
    try {
      Uri url = Uri.http(ipAddress, 'bus_api/getSeats.php');

      var response = await http.post(url, body: {'token': token, 'bus_id': busId});

      var result = SeatResponse.fromJson(jsonDecode(response.body));

      if (result.success == true) {
        seats.value = result.seats!
            .map((seat) => Seat(
                  seatId: seat.seatId,
                  seatNumber: seat.seatNumber,
                  availability: seat.availability,
                  busId: seat.busId,
                ))
            .toList();
      } else {
        showCustomSnackBar(
            message: result.message ?? 'Failed to fetch the seats');
      }
    } catch (e) {
      showCustomSnackBar(message: 'Error fetching seats: $e');
    }
  }
  void resetSeats(String busId) async {
  try {
    var url = Uri.http(ipAddress, 'bus_api/resetSeats.php');

    var response = await http.post(url, body: {
      'token': Memory.getToken(),
      'bus_id': busId,
    });

    var result = jsonDecode(response.body);

    if (result['success']) {
      showCustomSnackBar(
        message: result['message'],
        isSuccess: true,
      );
      // Call the getSeatsForBus method directly from the BusController
      getSeatsForBus(busId, Memory.getToken() ?? '');
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
 Future<void> resetBusBookingStatus(String busId) async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/resetBusBookingStatus.php');
      var response = await http.post(url, body: {
        'token': Memory.getToken() ?? '',
        'bus_id': busId,
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
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
        message: 'Error resetting bus booking status: $e',
      );
    }
  }

    void refreshPage() {
    // Trigger an update to refresh the page
    update();
  }
}
