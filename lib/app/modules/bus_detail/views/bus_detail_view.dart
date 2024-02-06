import 'package:flutter/material.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/models/bus.dart';
import '../controllers/bus_detail_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class BusDetailView extends GetView<BusDetailController> {
  const BusDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var bus = Get.arguments as Bus?;
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
                    shadowColor: Colors.black, // Color of the shadow
                  ),
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: const Color.fromARGB(188, 87, 126, 147),
                  //   padding: const EdgeInsets.symmetric(
                  //     vertical: 20,
                  //   ),
                  // ),
                  onPressed: () {
                    Get.to(() => MakeAppointmentPage(bus: bus!),
                        arguments: bus);
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
            ],
          ),
        ));
  }
}

class MakeAppointmentPage extends StatelessWidget {
  final Bus bus;
  const MakeAppointmentPage({super.key, required this.bus});

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
                            icon: const Icon(Icons.calendar_month))),
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
