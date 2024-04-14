import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepal_express/app/models/notification.dart' as AppModels; // Import with prefix
import 'package:nepal_express/app/models/notification.dart';

import '../controllers/notification_controller.dart';
class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Detail'),
        centerTitle: true,
      ),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          if (controller.notificationResponse == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.notificationResponse!.notifications!.isEmpty) {
            return const Center(
              child: Text('No notifications', style: TextStyle(fontSize: 20)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.notificationResponse!.notifications!.length,
            itemBuilder: (context, index) {
              AppModels.Notification notif = controller.notificationResponse!.notifications![index];
              var formattedDate = DateFormat("yyyy-MM-dd hh:mm aa").format(notif.createdAt!);

              // Check if notification is clicked (isClicked = 1), change container color accordingly
              Color containerColor = notif.isClicked == '1' ? Colors.white : const Color.fromARGB(255, 140, 176, 192);

              return GestureDetector(
                onTap: () {
                  // Update isClicked property when container is tapped in the UI
                  controller.notificationResponse!.notifications![index].isClicked = '1';
                  controller.update(); // Update UI

                  // Call clickNotification function to update backend
                  String? notificationId = notif.notificationId; // Nullable
                  if (notificationId != null) {
                    controller.clickNotification(notificationId);
                  } else {
                    // Handle null notificationId, e.g., show an error message
                    print('Notification ID is null');
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notif.title ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: notif.isClicked == '1' ? Colors.black : Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notif.description ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}