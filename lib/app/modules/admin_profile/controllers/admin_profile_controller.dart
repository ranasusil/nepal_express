import 'package:get/get.dart';
import 'package:nepal_express/app/models/user.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:http/http.dart'as http;
class AdminProfileController extends GetxController {
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

      // print(response.body);

      var result = userResponseFromJson(response.body);

      if (result.success ?? false) {
        userResponse = result;
        update();
      } else {
        showCustomSnackBar(
          message: result.message ?? '',
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: e.toString(),
      );
    }
  }
}
