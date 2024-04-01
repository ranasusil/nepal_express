import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_express/app/models/allBuses.dart';

import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

class AllBusesController extends GetxController {
  var allBuses = <Bus>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllBuses(); // Fetch all buses when the controller initializes
  }

  void getAllBuses() async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/getAllBuses.php', {'token': Memory.getToken()});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          List<dynamic> busesData = jsonData['buses'];
          allBuses.assignAll(busesData.map((busData) => Bus.fromJson(busData)).toList());
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
