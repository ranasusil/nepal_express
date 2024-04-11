import 'package:get/get.dart';
import 'package:nepal_express/app/models/notification.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  NotificationResponse? notificationResponse;
  final count = 0.obs;
  RxBool hasNewNotification = false.obs; // RxBool for observable new notification status

  @override
  void onInit() {
    super.onInit();
    getNotification();
  }

  @override
  void onClose() {
    super.onClose();
  }


Future<void> getNotification() async {
  try {
    var url = Uri.http(ipAddress, 'bus_api/getNotifications.php');

    var response = await http.post(url, body: {"token": Memory.getToken()});
    notificationResponse = notificationResponseFromJson(response.body);
    update();

    if (notificationResponse?.success ?? false) {
      hasNewNotification.value = notificationResponse!.notifications!.isNotEmpty;
      print(notificationResponse);
    } else {
      hasNewNotification.value = false;
      showCustomSnackBar(
        message: notificationResponse?.message ?? '',
      );
    }
  } catch (e) {
    hasNewNotification.value = false;
    print(e);
    showCustomSnackBar(
      message: 'Something went wrongggg',
    );
  }
}



  void increment() => count.value++;
}
