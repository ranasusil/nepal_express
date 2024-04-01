import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/components/sidebar.dart';

import '../controllers/admin_main_controller.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class AdminMainView extends GetView<AdminMainController> {
  const AdminMainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      sideBar: sidebar(context),
      body: const Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }

  
}
