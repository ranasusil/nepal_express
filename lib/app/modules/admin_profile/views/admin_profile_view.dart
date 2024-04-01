import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/components/sidebar.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/memory.dart';

import '../controllers/admin_profile_controller.dart';

class AdminProfileView extends GetView<AdminProfileController> {
  const AdminProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminProfileController());
    return AdminScaffold(
      sideBar: sidebar(context),
      body: GetBuilder<AdminProfileController>(
        builder: (controller) {
          if (controller.userResponse == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 75,
                  child: Text(
                    controller.userResponse!.user?.fullName?[0] ?? 'U',
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.userResponse?.user?.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.userResponse!.user!.email!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.userResponse?.user?.role?.toUpperCase() ?? '',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.userResponse?.user?.address ?? 'No Address',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.grey[300],
                    leading: const Text('Logout',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    trailing: const Icon(Icons.logout),
                    onTap: () {
                      // Memory.clear();
                      // Get.offAllNamed(Routes.LOGIN);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content:
                                const Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Memory.clear();
                                  Get.offAllNamed(Routes.LOGIN);
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
