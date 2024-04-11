import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/modules/travel_agency_home/controllers/travel_agency_home_controller.dart';

import '../controllers/travel_agency_home_controller.dart';

class TravelAgencyHomeView extends GetView<TravelAgencyHomeController> {
  const TravelAgencyHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(TravelAgencyHomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelAgencyHomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              'TravelAgencyHomeView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
