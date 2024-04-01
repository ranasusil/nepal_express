import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_express/app/models/users.dart'; // Import User model
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

class AgencyController extends GetxController {
  var agencies = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAgencies();
  }

  //  void getAgencies() async {
  //   try {
  //     var url = Uri.http(ipAddress, 'bus_api/getAgencies.php', {'token': Memory.getToken()});
  //     var response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       var jsonData = jsonDecode(response.body);
  //       if (jsonData['success']) {
  //         List<dynamic> agenciesData = jsonData['agencies'];
  //         agencies.assignAll(
  //             agenciesData.map((agencyData) => User.fromJson(agencyData)).toList());
  //       } else {
  //         print('API Error: ${jsonData['message']}');
  //       }
  //     } else {
  //       print('HTTP Error: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
   void getAgencies() async {
    try {
      var url = Uri.http(
          ipAddress, 'bus_api/getAgencies.php', {'token': Memory.getToken()});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          List<dynamic> agenciesData = jsonData['users'];
          agencies.assignAll(
              agenciesData.map((agencyData) => User.fromJson(agencyData)).toList());
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
