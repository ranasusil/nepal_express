import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:nepal_express/app/models/bus.dart';
import 'package:nepal_express/app/models/seat.dart';
import 'package:nepal_express/app/modules/bus_detail/views/bus_detail_view.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

class BusDetailController extends GetxController {
  final Bus bus = Get.arguments as Bus;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var remarksController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // final RxList<Seat> seats = <Seat>[].obs;

  // Future<void> getSeatsForBus(String busId, String token) async {
  //   try {
  //     Uri url = Uri.http(ipAddress, 'bus_api/getSeats.php');
  //     print('API URL: $url');
  //     var response =
  //         await http.post(url, body: {'token': token, 'bus_id': busId});
  //     print('API Response: ${response.body}');
  //     var result = SeatResponse.fromJson(jsonDecode(response.body));

  //     if (result.success == true) {
  //       seats.value = result.seats!
  //           .map((seat) => Seat(
  //                 seatId: seat.seatId?.toString() ?? '0',
  //                 seatNumber: seat.seatNumber.toString(),
  //                 availability: seat.availability?.toString() ?? '0',
  //                 busId: seat.busId?.toString() ?? '0',
  //               ))
  //           .toList();
  //     } else {
  //       showCustomSnackBar(message: result.message ?? 'Failed to fetch seats');
  //     }
  //   } catch (e) {
  //     showCustomSnackBar(message: 'Error fetching seats: $e');
  //   }
  // }

  // // Add this method to navigate to the 'MakeSeatBookingPage'
  // void navigateToMakeSeatBookingPage() {
  //   Get.to(() => MakeSeatBookingPage(seats: seats));
  // }
  final RxList<Seat> seats = <Seat>[].obs;

Future<void> getSeatsForBus(String busId, String token) async {
  try {
    Uri url = Uri.http(ipAddress, 'bus_api/getSeats.php');
    print('API URL: $url');
    var response =
        await http.post(url, body: {'token': token, 'bus_id': busId});
    print('API Response: ${response.body}');
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
      showCustomSnackBar(message: result.message ?? 'Failed to fetch theseats');
    }
  } catch (e) {
    showCustomSnackBar(message: 'Error fetching seats: $e');
  }
}

void navigateToMakeSeatBookingPage() {

  Get.to(() => MakeSeatBookingPage(
  seatNumbers: seats.map((seat) => seat.seatNumber ?? '').toList(),
  seats: seats,
));

}


  void makeBooking() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      Uri url = Uri.http(ipAddress, 'bus_api/makeBooking.php');
      var response = await http.post(
        url,
        body: {
          'token': Memory.getToken() ?? '',
          'bus_id': bus.id.toString(),
          'date': "${dateController.text} ${timeController.text}",
          'remarks': remarksController.text,
        },
      );

      var result = jsonDecode(response.body);
      if (result['success']) {
        makePayment(result['booking_id'].toString());
      } else {
        showCustomSnackBar(
          message: result['message'],
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: e.toString(),
      );
    }
  }

  void makePayment(String bookingId) {
    try {
      PaymentConfig config = PaymentConfig(
        productName: "Booking",
        //amount: int.parse(bus.fair??'0')*100,
        amount: 100 * 100,
        productIdentity: bookingId,
      );
      KhaltiScope.of(Get.context!).pay(
          config: config,
          preferences: [PaymentPreference.khalti],
          onSuccess: (v) async {
            Uri url = Uri.http(ipAddress, 'bus_api/makePayment.php');
            var response = await http.post(url, body: {
              'token': Memory.getToken() ?? '',
              'bookingId': bookingId,
              'amount': bus.fair ?? '0',
              'details': v.toString()
            });

            print(response.body);
            var result = jsonDecode(response.body);

            if (result['success']) {
              showCustomSnackBar(
                  message: 'Payment Successful', isSuccess: true);
              Get.offAllNamed(Routes.MAIN);
            } else {
              showCustomSnackBar(message: result['message']);
            }
          },
          onFailure: (v) {
            showCustomSnackBar(message: v.message);
          });
    } catch (e) {
      showCustomSnackBar(message: e.toString());
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    var bus = Get.arguments as Bus?;
    if (bus != null) {
      getSeatsForBus(bus.id!, Memory.getToken() ?? '');
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
