import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/models/seat.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import '../controllers/bus_controller.dart';

class BusView extends StatelessWidget {
  const BusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final busController = Get.put(BusController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buses'),
        centerTitle: true,
      ),
      body: GetBuilder<BusController>(
        builder: (controller) {
          if (controller.busesResponse == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: controller.busesResponse?.buses?.length,
              itemBuilder: (context, index) {
                var bus = controller.busesResponse!.buses![index];
                return GestureDetector(
                  onTap: () {
                    if (bus.id != null) {
                      Get.to(() => BusDetailsView(), arguments: bus.id!);
                    } else {
                      // Handle case where busId is null
                      print('Error: busId is null');
                    }
                  },
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          getImageUrl(bus.avatar),
                          width: 100,
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    (bus.name ?? ''),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (bus.isDeleted ==
                                      '1') // Add this condition to show deleted text
                                    Text(
                                      ' (Deleted)',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                bus.title ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                bus.fair ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            print(
                                'isDeleted inside IconButton: ${bus.isDeleted}');
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(bus.isDeleted == '0'
                                      ? 'Delete bus'
                                      : 'Restore Bus'),
                                  content: Text(bus.isDeleted == '0'
                                      ? "Are you sure want to delete?"
                                      : "Are you sure want to restore?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                        if (bus.isDeleted == '0') {
                                          busController.deleteBus(bus.id ?? '');
                                        } else {
                                          // Code to restore bus
                                        }
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: bus.isDeleted == '1'
                              ? const Icon(Icons.restore, color: Colors.green)
                              : const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const AddBusPopup();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BusDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String busId = Get.arguments;
    final BusController controller = Get.find();

    // Call the getSeatsForBus method to fetch the seat data for the current busId
    controller.getSeatsForBus(busId, Memory.getToken() ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Call the resetSeats function from the BusController
                  controller.resetBusBookingStatus(busId);
                },
                child: Text('Reset Bus Booking Status'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call the resetSeats function from the BusController
                  controller.resetSeats(busId);
                },
                child: Text('Reset Seats'),
              ),
              SizedBox(height: 20),
              Text(
                'Seat Data:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Obx(() {
                if (controller.seats.isEmpty) {
                  return Text('No seat data available.');
                } else {
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('Seat Number')),
                      DataColumn(label: Text('Availability')),
                    ],
                    rows: controller.seats.map((seat) {
                      return DataRow(cells: [
                        DataCell(Text(seat.seatNumber ?? '')),
                        DataCell(Text(
                            seat.availability == 1 ? 'Available' : 'Booked')),
                      ]);
                    }).toList(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class AddBusPopup extends StatelessWidget {
  const AddBusPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BusController>();
    return Dialog(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Bus'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 15,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.busNameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.5, color: Color.fromARGB(196, 32, 55, 79)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Bus Name',
                      hintText: 'Enter your bus name',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.5, color: Color.fromARGB(196, 32, 55, 79)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your bus name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.fairController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.5, color: Color.fromARGB(196, 32, 55, 79)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Bus Fair',
                      hintText: 'Enter the bus fair',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.5, color: Color.fromARGB(196, 32, 55, 79)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your trip fair.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.yearsUsedController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1.5,
                              color: Color.fromARGB(196, 32, 55, 79)),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'Experience',
                        hintText: 'Enter your experience',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1.5,
                              color: Color.fromARGB(196, 32, 55, 79)),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        suffixIcon: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Years'),
                          ],
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the fair.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    items: controller.tripResponse?.trip
                            ?.map((e) => DropdownMenuItem(
                                  value: e.tripId ?? '',
                                  child: Text(e.title ?? ''),
                                ))
                            .toList() ??
                        [],
                    onChanged: (value) {
                      controller.tripId = value;
                    },
                    value: controller.tripId,
                    decoration: InputDecoration(
                      labelText: 'Trip',
                      hintText: 'Select bus trip',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select bus trip';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<BusController>(
                    builder: (controller) => (controller.image == null ||
                            controller.imageBytes == null)
                        ? ElevatedButton(
                            onPressed: controller.pickImage,
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(
                                  208, 101, 118, 180), // background color
                              onPrimary: const Color.fromARGB(
                                  255, 255, 255, 255), // text color
                              elevation:
                                  5, // button's elevation when it's pressed
                            ),
                            child: const Text('Upload Image'),
                          )
                        : Stack(
                            children: [
                              Image.memory(
                                controller.imageBytes!,
                                height: 300,
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.image = null;
                                      controller.imageBytes = null;
                                      controller.update();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.addBus();
                      controller.refreshPage();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(208, 62, 73, 111),
                      onPrimary: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 5,
                    ),
                    child: const Text('Add Bus'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
