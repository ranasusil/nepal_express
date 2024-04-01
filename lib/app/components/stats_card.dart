import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsContainer extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final String svg;
  const StatsContainer({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade500, // Set the border color
          width: 0.5, // Set the border width
        ),
        borderRadius: BorderRadius.circular(8), // Set border radius if needed
      ),
      child: Card(
        color: color,
        child: Container(
          padding: const EdgeInsets.all(12),
          width: Get.width * 0.15,
          height: 150,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    Color.fromARGB(255, 204, 203, 203).withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (SvgPicture.asset(
                  svg,
                  height: 50,
                )),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.arsenal(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
