import 'package:get/get.dart';
import 'package:nepal_express/app/models/stats.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:http/http.dart' as http;
class TravelAgencyHomeController extends GetxController {
  //TODO: Implement TravelAgencyHomeController
StatsResponse? statsResponse;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getStats();
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


  void getStats() async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/getStatistics.php');

      var response = await http.post(url, body: {"token": Memory.getToken()});
      statsResponse = statsResponseFromJson(response.body);
      update();

      if (statsResponse?.success ?? false) {
        // showCustomSnackBar(
        //   message: specializationResponse?.message ?? '',
        //   isSuccess: true,
        // );
      } else {
        showCustomSnackBar(
          message: statsResponse?.message ?? '',
        );
      }
    } catch (e) {
      print(e);
      showCustomSnackBar(
        message: 'Something went wrong',
      );
    }
  }

}
