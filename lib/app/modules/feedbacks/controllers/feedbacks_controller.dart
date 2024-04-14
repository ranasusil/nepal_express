import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nepal_express/app/models/feedback.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';

class FeedbacksController extends GetxController {
   final List<Feedback> feedbacks = <Feedback>[].obs;

  final count = 0.obs;
  @override
    void onInit() {
    super.onInit();
    getFeedbacks();
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

   Future<void> getFeedbacks() async {
    try {
      var url = Uri.http(ipAddress, 'bus_api/getFeedbacks.php', {'token': Memory.getToken() ?? ''});

      var response = await http.get(url);

      var result = jsonDecode(response.body);

      if (result['success']) {
        List<dynamic>? feedbackList = result['feedbacks'];
        feedbacks.assignAll(feedbackList!.map((feedback) => Feedback.fromJson(feedback)).toList());
      } else {
        showCustomSnackBar(
          message: result['message'] ?? 'Failed to fetch feedbacks',
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: 'Error fetching feedbacks: $e',
      );
    }
  }

  void increment() => count.value++;
}
