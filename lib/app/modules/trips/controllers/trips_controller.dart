import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_express/app/models/trip.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

class TripsController extends GetxController {
  static const int tripsPerPage = 10;
  var trips = <Trip>[].obs;
    var titleController = TextEditingController();
  var cityFromController = TextEditingController();
  var cityToController = TextEditingController();
  var addTripFormKey = GlobalKey<FormState>();
  int currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    getTrips();
  }

 void getTrips() async {
  try {
    var url = Uri.http(ipAddress, 'bus_api/getTrips.php', {
      'token': Memory.getToken(),
    });
    var response = await http.get(url);
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        List<dynamic> tripsData = jsonData['trip'];
        trips.assignAll(tripsData.map((tripData) => Trip.fromJson(tripData)).toList());
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
 void onAddTrip() async {
    if (addTripFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAddress, 'bus_api/addTrip.php');

        var response = await http.post(url, body: {
          'token': Memory.getToken(),
          'title': titleController.text,
          'cityFrom': cityFromController.text,
          'cityTo': cityToController.text,
        });

        var result = jsonDecode(response.body);

        if (result['success']) {
          titleController.clear();
          cityFromController.clear();
          cityToController.clear();
          getTrips();
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


  void nextPage() {
    currentPage++;
    getTrips();
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      getTrips();
    }
  }
}
