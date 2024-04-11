
import 'package:nepal_express/app/components/custom_button.dart';
import 'package:nepal_express/app/components/custom_feild.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';
import 'package:flutter/foundation.dart';
class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kIsWeb ? 500 : 20,
              vertical: 40,
            ),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image(image: NetworkImage(''))
                  CircleAvatar(
                    radius: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kIsWeb ? 200 : 100),
                      child: Image.asset(
                        'assets/images/bus.jpg',
                        height: 250,
                         fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Nepal Express',
                    textAlign: TextAlign.center,
                    
                    style: GoogleFonts.yanoneKaffeesatz(fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Enter login details',
                    style: GoogleFonts.nunito(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  
                  TextFormField(
                    controller: controller.emailController,
                    
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      hintText: 'Enter your email address',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.none,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.none,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8) {
                        return 'Password must be atleast 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomButton(onPressed: () => controller.onLogin()),
                  // ElevatedButton(
                  //   onPressed: controller.onLogin,
                  //   child: const SizedBox(
                  //     height: 50,
                  //     child: Center(
                  //       child: Text(
                  //         'Login',
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: Text(
                          'Register',
                        style: GoogleFonts.yanoneKaffeesatz(fontSize: 22, color: Colors.lightBlue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
