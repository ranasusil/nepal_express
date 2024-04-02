import 'package:flutter/material.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/models/bus.dart';
import '../controllers/bus_detail_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepal_express/app/models/seat.dart';

class BusDetailView extends GetView<BusDetailController> {
  const BusDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bus = Get.arguments as Bus?;
    // Get the token from Memory
    String token = Memory.getToken() ?? '';

    // Call getSeatsForBus with token and bus ID
    controller.getSeatsForBus(bus?.id ?? '', token);

    return Scaffold(
        appBar: AppBar(
          title: Text(bus?.name ?? ''),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
            flex: 2,
            child: Hero(
              tag: bus?.id! ?? '',
              child: Image.network(
                getImageUrl(
                  bus?.avatar,
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                margin: const EdgeInsets.all(5.0),
                // color: Color.fromARGB(170, 176, 217, 249),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bus Details:',
                            style: GoogleFonts.notoSansDisplay(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                decoration: TextDecoration.underline)),
                        Row(
                          children: [
                            Text("Bus's Name: ",
                                style: GoogleFonts.almarai(
                                  fontSize: 25,
                                  // fontWeight: FontWeight.bold,
                                )),
                            Text(
                              bus?.name ?? '',
                              style: GoogleFonts.encodeSans(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 4,
                                wordSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Trip: ",
                                style: GoogleFonts.almarai(
                                  fontSize: 25,
                                  // fontWeight: FontWeight.bold,
                                )),
                            Text(
                              bus?.title ?? '',
                              style: GoogleFonts.encodeSans(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 4,
                                wordSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Bus's Fair: ",
                                style: GoogleFonts.almarai(
                                  fontSize: 25,
                                  // fontWeight: FontWeight.bold,
                                )),
                            Text(
                              bus?.fair ?? '',
                              style: GoogleFonts.encodeSans(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 4,
                                wordSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Agency's Name: ",
                                style: GoogleFonts.almarai(
                                  fontSize: 25,
                                  // fontWeight: FontWeight.bold,
                                )),
                            Text(
                              bus?.agencyName ?? '',
                              style: GoogleFonts.encodeSans(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 4,
                                wordSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Agency's Address: ",
                                style: GoogleFonts.almarai(
                                  fontSize: 25,
                                  // fontWeight: FontWeight.bold,
                                )),
                            Text(
                              bus?.agencyAddress ?? '',
                              style: GoogleFonts.encodeSans(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 4,
                                wordSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Agency's Email: ",
                                style: GoogleFonts.almarai(
                                  fontSize: 25,
                                  // fontWeight: FontWeight.bold,
                                )),
                            Text(
                              bus?.agencyEmail ?? '',
                              style: GoogleFonts.encodeSans(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 4,
                                wordSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ]),
                )),
          ),
        ]),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(188, 87, 126, 147),
                    elevation: 20,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    shadowColor: Colors.black,
                  ),
                  onPressed: () {
                    if (bus?.isBookable == 0) {
                      Get.snackbar(
                        'Seat Booking',
                        'This vehicle is not available for booking.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.to(() => MakeBookingPage(bus: bus!), arguments: bus);
                    }
                  },
                  child: Text(
                    'Book the Vehicle',
                    style: GoogleFonts.arsenal(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(188, 87, 126, 147),
                    elevation: 20,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    shadowColor: Colors.black,
                  ),
                  onPressed: () {
                    controller.navigateToMakeSeatBookingPage();
                  },
                  child: Text(
                    'Book the Seats',
                    style: GoogleFonts.arsenal(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class MakeBookingPage extends StatelessWidget {
  final Bus bus;
  const MakeBookingPage({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BusDetailController());
    return Scaffold(
        appBar: AppBar(
          title: Text(bus.name ?? ''),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    controller: controller.dateController,
                    decoration: InputDecoration(
                      labelText: 'Booking Date',
                      hintText: 'Select your booking date',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      disabledBorder: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 30),
                            ),
                          );
                          if (date != null) {
                            controller.dateController.text =
                                date.toString().split(' ')[0];
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your booking date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: controller.timeController,
                    decoration: InputDecoration(
                      labelText: 'Booking Time',
                      hintText: 'Select your booking time',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            controller.timeController.text =
                                '${time.hour}:${time.minute}';
                          }
                        },
                        icon: const Icon(Icons.timer),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your booking time';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    minLines: 5,
                    maxLines: 5,
                    maxLength: 5000,
                    keyboardType: TextInputType.text,
                    controller: controller.remarksController,
                    decoration: const InputDecoration(
                      labelText: 'Remarks(optional)',
                      hintText: 'Enter your remarks',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: const Color.fromARGB(255, 65, 116, 143),
                  //   elevation: 20,
                  //   padding: const EdgeInsets.symmetric(
                  //     vertical: 20,
                  //   ),
                  // ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 65, 116, 143),
                    elevation: 20,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    shadowColor: Colors.black, // Color of the shadow
                  ),
                  onPressed: controller.makeBooking,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/khaltiLogo.png',
                        width: 60,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Pay with Khalti',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

// class MakeSeatBookingPage extends StatelessWidget {
//   final List<String> seatNumbers;
//    final List<Seat> seats;
//   MakeSeatBookingPage({required this.seatNumbers, required this.seats});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Seat Booking Page'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Seats for the bus.',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//               itemCount: seatNumbers.length,
//               itemBuilder: (context, index) {
//                 Seat seat = seats[index];
//                 Color containerColor = seat.availability == 0
//                     ? Colors.red
//                     : Color.fromARGB(255, 6, 170, 0);
//                 return Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                        color: seat.availability == 0 ? Colors.red : Colors.lightGreen,
//     border: Border.all(),
//     borderRadius: BorderRadius.circular(8.0),

//                     ),
//                     child: Center(
//                       child: Text(
//                         seatNumbers[index],
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class MakeSeatBookingPage extends StatelessWidget {
  final List<String> seatNumbers;
  final List<Seat> seats;
  final BusDetailController controller = Get.find();

  MakeSeatBookingPage({required this.seatNumbers, required this.seats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Booking Page'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0), // Add margin of 5.0
        padding: const EdgeInsets.all(8.0),

        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seats for the bus.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
             
              const SizedBox(height: 15.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: seatNumbers.length,
                  itemBuilder: (context, index) {
                    Seat seat = seats[index];
                    String seatImage = seat.availability == 0
                        ? 'assets/images/seat2.png'
                        : 'assets/images/seat1.png';

                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          if (seat.availability == 1) {
                            Get.defaultDialog(
                              title: "Book Seat",
                              content: ElevatedButton(
                                onPressed: () async {
                                  Get.back();
                                  await controller.bookSeat(seat.seatId);
                                },
                                child: const Text("Book the seat"),
                              ),
                            );
                          }
                        },
                        child: Image.asset(
                          seatImage,
                          width: 48, // Adjust width and height as needed
                          height: 48,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 25,
            child: Image.asset(
              'assets/images/streeing.png',
              width: 50, // Adjust width as needed
              height: 50, // Adjust height as needed
            ),
          ),
        ]),
      ),
    );
  }
}
