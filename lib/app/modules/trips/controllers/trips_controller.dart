import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_express/app/models/allTrips.dart';

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
    var url = Uri.http(ipAddress, 'bus_api/getAllTrips.php', {
      'token': Memory.getToken(),
    });
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      AllTripsResponse allTripsResponse = AllTripsResponse.fromJson(jsonData);
      if (allTripsResponse.success!) {
        trips.assignAll(allTripsResponse.trip!);
      } else {
        print('API Error: ${allTripsResponse.message}');
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
  void deleteTrip(String tripId) async {
  try {
    var url = Uri.http(ipAddress, 'bus_api/deleteTrip.php');

    var response = await http.post(url, body: {
      'token': Memory.getToken(),
      'trip_id': tripId,
    });

    var result = jsonDecode(response.body);

    if (result['success']) {

      showCustomSnackBar(
        message: result['message'],
        isSuccess: true,
      );

      getTrips();
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
 void fetchById(String tripId) async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/getTripById.php', {'trip_id': tripId});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          // Handle the retrieved trip data as needed
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

  void updateTripDetails(String tripId, String title, String cityFrom, String cityTo) async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/editTrip.php');
      var response = await http.post(url, body: {
        'token': Memory.getToken(),
        'trip_id': tripId,
        'title': title,
        'cityFrom': cityFrom,
        'cityTo': cityTo,
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        getTrips(); // Refresh the trip list after update
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
    getTrips();
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      getTrips();
    }
  }
}
