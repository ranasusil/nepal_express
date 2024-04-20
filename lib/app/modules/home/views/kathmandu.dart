import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Kathmandu extends StatelessWidget {
  const Kathmandu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kathmandu'),
          centerTitle: true,
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Image(image: AssetImage('assets/images/ktm.png'),
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,),
              ),
              Container(
                height: 80,
                
                child: Center(
                  child: Text(
                    'Kathmandu',
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,        
                child: Center(
                  child: Text(
                    "Where Tradition Meets Modernity",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: 500,
                margin: const EdgeInsets.all(20),
                  child: Text(
                    'Kathmandu, the capital city of Nepal, is a vibrant and culturally rich metropolis nestled in the heart of the Himalayas. Known for its ancient temples, bustling markets, and unique blend of traditional and modern lifestyles, Kathmandu offers a captivating experience to visitors and residents alike. The city is a melting pot of diverse cultures and ethnicities, with a rich history dating back thousands of years.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.crimsonText(
                      fontSize: 25,
                      color:const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                
              ),
            ],
          ),
        ));
  }
}
