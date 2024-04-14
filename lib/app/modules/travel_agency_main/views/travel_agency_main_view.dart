import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

import '../controllers/travel_agency_main_controller.dart';

class TravelAgencyMainView extends GetView<TravelAgencyMainController> {
  const TravelAgencyMainView({Key? key}) : super(key: key);
  @override
 Widget build(BuildContext context) {
        return Obx(
      () => Scaffold(
        body: controller.screens[controller.currentIndex.value],
        bottomNavigationBar: SizedBox(
          height:105,
          child: FloatingNavbar(
            backgroundColor: primaryColor,
            onTap: (int val) {
              controller.currentIndex.value = val;
            },
            currentIndex: controller.currentIndex.value,
            items: [
              FloatingNavbarItem(icon: Icons.home, title: 'Home'),
              FloatingNavbarItem(icon: Icons.list, title: 'Bookings'),
              FloatingNavbarItem(icon: Icons.car_rental, title: 'Buses'),
              FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
