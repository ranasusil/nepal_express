import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/modules/home/controllers/home_controller.dart';
import 'package:nepal_express/app/utils/constants.dart';

import '../controllers/bus_controller.dart';

class BusView extends GetView<BusController> {
  const BusView({Key? key}) : super(key: key);
  @override
 Widget build(BuildContext context) {
    Get.put(BusController());
    var busController = controller;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Buses'),
          centerTitle: true,
        ),
        body: GetBuilder<HomeController>(
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
                  return Card(
                    elevation: 15,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(184, 215, 227, 233),
                        borderRadius: BorderRadius.circular(15.0),
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
                                    Text(
                                      bus.isDeleted == '1'
                                          ? ' (Deleted)'
                                          : '',
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
                                          busController
                                              .deleteBus(bus.id ?? '');
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
                                ? const Icon(
                                    Icons.restore,
                                    color: Colors.green,
                                  )
                                : const Icon(Icons.delete),
                            color: Colors.red,
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
        ));
  }
}

class AddBusPopup extends StatelessWidget {
  const AddBusPopup({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BusController>();
    return Dialog.fullscreen(
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
                            width: 1.5,
                            color:
                                Color.fromARGB(196, 32, 55, 79)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Bus Name',
                      hintText: 'Enter your bus name',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.5,
                            color:
                                Color.fromARGB(196, 32, 55, 79)),
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
                            width: 1.5,
                            color:
                                Color.fromARGB(196, 32, 55, 79)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Bus Fair',
                      hintText: 'Enter the bus fair',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.5,
                            color:
                                Color.fromARGB(196, 32, 55, 79)),
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
                              color: Color.fromARGB(
                                  196, 32, 55, 79)), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'Experience',
                        hintText: 'Enter your experience',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1.5,
                              color: Color.fromARGB(
                                  196, 32, 55, 79)), //<-- SEE HERE
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
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<HomeController>(
                    builder: (homeController) {
                      if (homeController.tripResponse == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return DropdownButtonFormField<String>(
                        items: homeController
                            .tripResponse!.trip!
                            .map((e) => DropdownMenuItem(
                                  value: e.tripId.toString(),
                                  child: Text(e.title ?? ''),
                                ))
                            .toList(),

                        // items: [
                        //   DropdownMenuItem(
                        //     child: Text('Admin'),
                        //     value: 'admin',
                        //   ),
                        //   DropdownMenuItem(
                        //     child: Text('Agency'),
                        //     value: 'agency',
                        //   ),
                        // ],

                        onChanged: (v) {
                          controller.tripId = v;
                          controller.update();
                        },
                        value: controller.tripId,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(
                                    196, 32, 55, 79)),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          labelText: 'Trip',
                          hintText: 'Select bus trip',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(
                                    196, 32, 55, 79)),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select bus trip';
                          }
                          return null;
                        },
                      );
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
                    onPressed: controller.addBus,
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(208, 62, 73, 111), // background color
                      onPrimary: const Color.fromARGB(
                          255, 255, 255, 255), // text color
                      elevation: 5, // button's elevation when it's pressed
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
