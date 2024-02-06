import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final Function? validator;
  final bool isPassword;
  final String label;
  const CustomField({super.key, required this.controller, this.validator, this.isPassword=false, this.label="Email"});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        validator: (value) {
          if (value == null) {
            return 'Please enter some text';
          }
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          if (validator != null) {
            return validator!(value);
          }
          return null;
        },
        decoration:  InputDecoration(
            hintText: label,
            errorStyle: const TextStyle(
              fontSize: 22,
            ),
            contentPadding: const EdgeInsets.all(20),
          
            border: const OutlineInputBorder(
            
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),),
      ),
    );
  }
}