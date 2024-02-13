import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CityCard extends StatelessWidget {
  const CityCard({Key? key, required this.image, required this.text,this.text2=""}) : super(key: key);

  final String image;
  final String text;
  final String text2;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 400,
          width: 200,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(5, 2),
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              child: Container(
                height: 50,
                width: 170,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 74, 91, 125),
                      Color.fromARGB(255, 33, 39, 54),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 48, 51, 59).withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: const Offset(3, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text,  // Use the provided text parameter here
                      style: GoogleFonts.arsenal(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      text2,  // Use the provided text parameter here
                      style: GoogleFonts.arsenal(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
