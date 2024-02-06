import 'package:get/get.dart';

import '../controllers/bus_detail_controller.dart';

class BusDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusDetailController>(
      () => BusDetailController(),
    );
  }
}
