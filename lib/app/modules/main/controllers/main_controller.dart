import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nepal_express/app/modules/bookings/views/bookings_view.dart';
import 'package:nepal_express/app/modules/home/views/home_view.dart';
import 'package:nepal_express/app/modules/profile/views/profile_view.dart';
class MainController extends GetxController {
  //TODO: Implement MainController
 var currentIndex = 0.obs;
  List<Widget> screens = [
    HomeView(),
    BookingsView(),
    ProfileView(),

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
