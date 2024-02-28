import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pokhara extends StatelessWidget {
  const Pokhara({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokhara'),
          centerTitle: true,
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Image(image: AssetImage('assets/images/pokhara2.jpg'),
                width: double.infinity,
                fit: BoxFit.cover,),
              ),
              Container(
                height: 80,
                
                child: Center(
                  child: Text(
                    'Pokhara',
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
                    "Nature's Haven in Nepal",
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
                    'Pokhara Valley, situated in the western part of Nepal, is a picturesque and enchanting destination that draws visitors with its natural beauty and serene surroundings. Nestled within the Annapurna mountain range, Pokhara is often referred to as the "City of Lakes" due to its numerous freshwater lakes, the most prominent being Phewa Lake.',
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
