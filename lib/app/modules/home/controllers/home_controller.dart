import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:nepal_express/app/models/bus.dart';
import 'package:nepal_express/app/models/trip.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:nepal_express/app/utils/constants.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
BusesResponse? busesResponse;
TripResponse? tripResponse;
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

Future<void> getTrips() async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/getTrips.php');

      var response = await http.post(url, body: {"token": Memory.getToken()});
      tripResponse = tripResponseFromJson(response.body);
      update();

      if (tripResponse?.success ?? false) {
        // showCustomSnackBar(
        //   message: specializationResponse?.message ?? '',
        //   isSuccess: true,
        // );
      } else {
        showCustomSnackBar(
          message: tripResponse?.message ?? '',
        );
      }
    } catch (e) {
      print(e);
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

      if (tripResponse?.success ?? false) {
      } else {
        showCustomSnackBar(
          message: tripResponse?.message ?? '',
        );
      }
    } catch (e) {
      print(e);
      showCustomSnackBar(
        message: 'Something went wronggg',
      );
    }
  }
}
