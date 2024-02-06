import 'package:get/get.dart';

import '../controllers/travel_agency_main_controller.dart';

class TravelAgencyMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelAgencyMainController>(
      () => TravelAgencyMainController(),
    );
  }
}
