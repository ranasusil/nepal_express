import 'package:get/get.dart';

import '../controllers/all_buses_controller.dart';

class AllBusesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllBusesController>(
      () => AllBusesController(),
    );
  }
}
