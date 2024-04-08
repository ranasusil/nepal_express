import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/models/users.dart'; 
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:nepal_express/app/components/sidebar.dart';
import 'package:nepal_express/app/modules/edit_user/controllers/edit_user_controller.dart';


class EditUserView extends StatelessWidget {
  const EditUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Get.arguments as User? ?? User();
    final EditUserController controller = Get.find<EditUserController>();

    TextEditingController fullNameController = TextEditingController(text: user.fullName);
    TextEditingController emailController = TextEditingController(text: user.email);
    TextEditingController addressController = TextEditingController(text: user.address);

    return AdminScaffold(
      sideBar: sidebar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User ID: ${user.userId ?? ''}'),
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
              // Add onChanged and controller for editing the full name
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              // Add onChanged and controller for editing the email
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
              // Add onChanged and controller for editing the address
            ),
            ElevatedButton(
              onPressed: () {
                // Handle update user details logic
                controller.updateUserDetails(
                  User(
                    userId: user.userId,
                    fullName: fullNameController.text,
                    email: emailController.text,
                    address: addressController.text,
                  ),
                );
              },
              child: Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }
}
