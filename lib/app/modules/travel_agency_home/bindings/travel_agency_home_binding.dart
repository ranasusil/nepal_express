import 'package:get/get.dart';

import '../controllers/travel_agency_home_controller.dart';

class TravelAgencyHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelAgencyHomeController>(
      () => TravelAgencyHomeController(),
    );
  }
}
