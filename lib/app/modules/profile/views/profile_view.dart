import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/models/user.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ProfileController>(
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
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 206, 216, 228),
                                Color.fromARGB(255, 191, 198, 207),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => ChangePasswordScreen());
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: ListTile(
                                leading: Text(
                                  'Change Password',
                                  style: GoogleFonts.yanoneKaffeesatz(
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 94, 103, 109),
                                  ),
                                ),
                                // trailing: Icon(Icons.change_circle_rounded),
                                trailing: Icon(
                                  CupertinoIcons.arrow_2_circlepath,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 206, 216, 228),
                                Color.fromARGB(255, 191, 198, 207),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => EditProfileScreen());
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: ListTile(
                                leading: Text(
                                  'Edit Profile',
                                  style: GoogleFonts.yanoneKaffeesatz(
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 94, 103, 109),
                                  ),
                                ),
                                trailing: Icon(Icons.edit_rounded),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 211, 221, 233),
                                Color.fromARGB(255, 191, 198, 207),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,

                            borderRadius: BorderRadius.circular(8.0),
                            elevation:
                                0, // Set elevation to 0 to remove the default box shadow of Material
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Logout'),
                                      content: const Text(
                                          'Are you sure you want to logout?'),
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
                              borderRadius: BorderRadius.circular(8.0),
                              child: ListTile(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 20, 0),
                                leading: Text(
                                  'Logout',
                                  style: GoogleFonts.yanoneKaffeesatz(
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 94, 103, 109),
                                  ),
                                ),
                                trailing: Icon(Icons.logout),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newPassword = newPasswordController.text;
                String confirmPassword = confirmPasswordController.text;
                if (newPassword == confirmPassword) {
                  ProfileController profileController = Get.find();
                  profileController.changePassword(newPassword);
                  Get.back(); // Close the ChangePasswordScreen
                } else {
                  Get.snackbar(
                    'Error',
                    'Passwords do not match',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    User? currentUser = profileController.userResponse?.user;

    fullNameController.text = currentUser?.fullName ?? '';
    emailController.text = currentUser?.email ?? '';
    addressController.text = currentUser?.address ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit your profile.', style: GoogleFonts.arsenal()),
              SizedBox(height: 20),
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String fullName = fullNameController.text;
                  String email = emailController.text;
                  String address = addressController.text;

                  profileController.editProfile(fullName, email, address);
                  Get.back();
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
