import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepal_express/app/models/booking.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(BookingsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingsView'),
        centerTitle: true,
      ),
      body: GetBuilder<BookingsController>(
          builder: (controller) {
            if (controller.bookingResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount:
                  controller.bookingResponse?.bookings?.length ?? 0,
              itemBuilder: (context, index) {
                Booking booking =
                    controller.bookingResponse!.bookings![index];
                var formattedDate =
                    DateFormat("yyyy-MM-dd hh:MM aa").format(booking.date!);
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      getImageUrl(booking.avatar),
                      height: 200,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    isThreeLine: true,
                    title: Text(booking.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formattedDate),
                        Text('Rs.${booking.amount}',
                            style: const  TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    trailing: Text(
                      booking.status?.toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: booking.status == 'paid'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        )
    );
  }
}
