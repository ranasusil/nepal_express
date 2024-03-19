import 'package:get/get.dart';
import 'package:nepal_express/app/models/booking.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:http/http.dart' as http;
class BookingsController extends GetxController {
  //TODO: Implement BookingsController
  BookingResponse? bookingResponse;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getBookingDetails();
  }

   void getBookingDetails() async {
    try {
      Uri url = Uri.http(ipAddress, 'bus_api/getBookings.php');

      var response = await http.post(url, body: {"token": Memory.getToken()});

      // print(response.body);

      var result = bookingResponseFromJson(response.body);

      if (result.success ?? false) {
        bookingResponse = result;
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
