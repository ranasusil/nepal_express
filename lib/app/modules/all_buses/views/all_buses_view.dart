import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/components/sidebar.dart';

import '../controllers/all_buses_controller.dart';

class AllBusesView extends GetView<AllBusesController> {
  const AllBusesView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      sideBar: sidebar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
height: 100,
              child: Text(
                'All Buses', // Title text
                style: TextStyle(
                  fontSize: 60, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Obx(() {
                final sortedBuses = controller.allBuses.toList()
                  ..sort((a, b) => a.agencyName!.compareTo(b.agencyName!)); // Sort by agency name
                return Wrap(
                  spacing: 20, // Space between each card
                  runSpacing: 20, // Space between rows of cards
                  children: sortedBuses.map((bus) {
                    return Container(
                      width: 200, // Width of each card
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bus ID: ${bus.id}'),
                          SizedBox(height: 5),
                          Text('Agency: ${bus.agencyName}'),
                          SizedBox(height: 5),
                          Text('Email: ${bus.agencyEmail}'),
                          SizedBox(height: 5),
                          Text('Address: ${bus.agencyAddress}'),
                          SizedBox(height: 5),
                          Text('Name: ${bus.name}'),
                          SizedBox(height: 5),
                          Text('Fair: ${bus.fair}'),
                          SizedBox(height: 5),
                          Text('Trip ID: ${bus.tripId}'),
                          SizedBox(height: 5),
                          Text('Years Used: ${bus.yearsUsed}'),
                          // Include other information of the bus here
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}