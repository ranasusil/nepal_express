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

      var response =
          await http.post(url, body: {'token': token, 'bus_id': busId});

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
            message: result.message ?? 'Failed to fetch theseats');
      }
    } catch (e) {
      showCustomSnackBar(message: 'Error fetching seats: $e');
    }
  }

 void sortSeats() {
    // Sort the seats based on row and column positions
    seats.sort((a, b) {
      if (a.seatNumber == null || b.seatNumber == null) return 0;

      // Extract row and column numbers from seat numbers (e.g., "1A" -> row: 1, column: 1)
      final aRow = int.tryParse(a.seatNumber![0]) ?? 0;
      final bRow = int.tryParse(b.seatNumber![0]) ?? 0;
      final aColumn = a.seatNumber![1].codeUnitAt(0);
      final bColumn = b.seatNumber![1].codeUnitAt(0);

      // Sort first by row and then by column
      if (aRow == bRow) {
        return aColumn.compareTo(bColumn);
      } else {
        return aRow.compareTo(bRow);
      }
    });
  }




Future<void> bookSeat(int? seatId) async {
  if (seatId == null) {
    // Handle the case where seatId is null
    return;
  }
  
  try {
    final response = await http.post(
      Uri.http(ipAddress, 'bus_api/bookSeat.php'),
      body: {
        'token': Memory.getToken() ?? '',
        'seat_id': seatId.toString(),
      },
    );

    final result = jsonDecode(response.body);
    if (result['success']) {
      await makePayment(result['booking_id'].toString());
      // updateSeatAvailability(seatId, 0);
    } else {
      if (result['message'] == 'Seat is already booked!') {
        // Show snackbar indicating the seat is already booked
        Get.snackbar(
          'Seat Booking',
          'The selected seat is already booked.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Show other error messages
        showCustomSnackBar(message: result['message']);
      }
    }

    if (result['success']) {
      await makePayment(result['booking_id'].toString());
    } else {
      showCustomSnackBar(
        message: result['message'],
      );
    }
  } catch (e) {
    showCustomSnackBar(message: 'Error booking seat: $e');
  }
}


void updateSeatAvailability(int index, int availability) {
  seats[index].availability = availability;
  update();
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
      print(result['booking_id'].toString());
      if (result['success']) {
        await makePayment(result['booking_id'].toString());
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

  makePayment(String bookingId) async {
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
  makeSeatPayment(String seat_booking_id) async {
    try {
      PaymentConfig config = PaymentConfig(
        productName: "Booking",
        //amount: int.parse(bus.fair??'0')*100,
        amount: 100 * 100,
        productIdentity: seat_booking_id,
      );
      KhaltiScope.of(Get.context!).pay(
          config: config,
          preferences: [PaymentPreference.khalti],
          onSuccess: (v) async {
            Uri url = Uri.http(ipAddress, 'bus_api/makeSeatPayment.php');
            var response = await http.post(url, body: {
              'token': Memory.getToken() ?? '',
              'seat_booking_id': seat_booking_id,
              // 'amount':'1240',
              'remarks': v.toString()
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
void fetchSeats() async {
    try {
      // Replace this with your API call to fetch seat data
      final response = ''; // Make API call to fetch seat data
      final seatResponse = seatResponseFromJson(response);
      seats.assignAll(seatResponse.seats ?? []);
      sortSeats(); // Sort seats after fetching
    } catch (e) {
      print('Error fetching seats: $e');
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
