import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nepal_express/app/modules/bookings/views/bookings_view.dart';
import 'package:nepal_express/app/modules/bus/views/bus_view.dart';
import 'package:nepal_express/app/modules/travel_agency_home/views/travel_agency_home_view.dart';
import 'package:nepal_express/app/modules/profile/views/profile_view.dart';
class TravelAgencyMainController extends GetxController {

  var currentIndex = 0.obs;
  List<Widget> screens = [

    const TravelAgencyHomeView(),
    const BookingsView(),
    const BusView(),
    const ProfileView(),
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
