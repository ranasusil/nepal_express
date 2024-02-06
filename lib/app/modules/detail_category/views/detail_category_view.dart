import 'package:flutter/material.dart';
import 'package:nepal_express/app/components/bus_card.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/models/bus.dart';
import 'package:nepal_express/app/models/trip.dart';
import 'package:nepal_express/app/modules/home/controllers/home_controller.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  final Trip trip = Get.arguments;
  DetailCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    List<Bus> buses = [];
    homeController.busesResponse?.buses?.forEach((bus) {
      if (bus.tripId == trip.tripId) {
        buses.add(bus);
      }
    });

    print(buses);
    return Scaffold(
        appBar: AppBar(
          title: Text(trip.title ?? ''),
          centerTitle: true,
        ),
        body: buses.isEmpty
            ? const Center(
                child: Text(
                'No Buses found for this category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ))
            : ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: buses.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 250,
                      child: BusCard(
                          showAnimation: false, bus: buses[index]));
                },
              ));
}
}