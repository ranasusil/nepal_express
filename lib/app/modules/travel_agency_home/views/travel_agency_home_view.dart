import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/components/stats_card_agency.dart';
import 'package:nepal_express/app/modules/notification/controllers/notification_controller.dart';
import 'package:nepal_express/app/modules/travel_agency_home/controllers/travel_agency_home_controller.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/memory.dart';

import '../controllers/travel_agency_home_controller.dart';

class TravelAgencyHomeView extends GetView<TravelAgencyHomeController> {
  const TravelAgencyHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TravelAgencyHomeController());
    final NotificationController notificationController =
        Get.put(NotificationController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('TravelAgencyHomeView'),
          centerTitle: true,
          actions: [
            Obx(() {
              final bool hasNewNotification =
                  notificationController.hasNewNotification.value;
              return IconButton(
                onPressed: () async {
                  Get.toNamed(Routes.NOTIFICATION);
                },
                icon: hasNewNotification
                    ? Badge(
                        label: Text("1"),
                        child: Icon(Icons.notifications),
                      )
                    : Icon(Icons.notifications),
              );
            }),
          ],
        ),
        body: GetBuilder<TravelAgencyHomeController>(
          builder: (controller) {
            if (controller.statsResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Wrap(children: [
                  Container(
                    child: StatsContainer2(
                      svg: 'assets/images/bus.svg',
                      title: 'Buses',
                      value:
                          controller.statsResponse!.statistics?.noOfBuses ?? '',
                      color: Color.fromARGB(255, 254, 204, 204),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  StatsContainer2(
                    svg: 'assets/images/bookings.svg',
                    title: 'Bookings',
                    value:
                        controller.statsResponse!.statistics?.totalBookings ??
                            '',
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  StatsContainer2(
                    svg: 'assets/images/income.svg',
                    title: 'Total Monthly Income',
                    value:
                        "Rs.${controller.statsResponse!.statistics?.totalMonthlyIncome}" ??
                            '',
                    color: Color.fromARGB(255, 209, 173, 250),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  StatsContainer2(
                    svg: 'assets/images/totalIncome.svg',
                    title: 'Total Income',
                    value:
                        "Rs.${controller.statsResponse!.statistics?.totalIncome}" ??
                            '',
                    color: Color.fromARGB(255, 168, 252, 175),
                  ),
                ]),
              ),
            );
          },
        ));
  }
}
