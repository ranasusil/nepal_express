import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepal_express/app/components/bus_card.dart';
import 'package:nepal_express/app/models/bus.dart';
import 'package:nepal_express/app/modules/home/views/pokhara.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        // title: const Text('HomeView'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(155, 179, 208, 228),
        title: const Text(
          'Nepal Express',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(context: context, delegate: SearchView());
            },
            icon: const Icon(Icons.search),
          ),
          // IconButton(
          //   onPressed: () async {
          //     Get.toNamed(Routes.NOTIFICATION);
          //   },
          //   icon: const Icon(Icons.notifications),
          // )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getTrips();
          await controller.getBuses();
        },
        child: SingleChildScrollView(
          physics: const ScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: GetBuilder<HomeController>(
            builder: (controller) {
              if (controller.tripResponse == null ||
                  controller.busesResponse == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Trips',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.tripResponse?.trip?.length ?? 0,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_CATEGORY,
                                arguments:
                                    controller.tripResponse?.trip?[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: primaryColor.withOpacity(0.7),
                            ),
                            margin: const EdgeInsets.only(
                              right: 10,
                              top: 10,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                controller.tripResponse?.trip?[index].title ??
                                    '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Available Buses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1.6,
                      ),
                      itemCount: controller.busesResponse?.buses?.length ?? 0,
                      itemBuilder: (context, index) {
                        return BusCard(
                            bus: controller.busesResponse!.buses![index]);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 400,
                                width: 200,
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/pokhara.png'),
                                      fit: BoxFit.cover),
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
                                        // color: Colors.grey.withOpacity(0.5),
                                        height: 50,
                                        width: 170,
                                        margin: EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                              color: Color.fromARGB(
                                                      255, 48, 51, 59)
                                                  .withOpacity(0.7),
                                              spreadRadius: 3,
                                              blurRadius: 3,
                                              offset: const Offset(3, 2),
                                            ),
                                          ],
                                        ),
                                        // width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Pokhara',
                                              style: GoogleFonts.arsenal(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Gandaki',
                                              style: GoogleFonts.arsenal(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )),
                                    onTap: () {
                                      Get.to(() => const Pokhara());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 400,
                                width: 200,
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/ktm.png'),
                                      fit: BoxFit.cover),
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
                                      // color: Colors.grey.withOpacity(0.5),
                                      height: 50,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 20),
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
                                            color:
                                                Color.fromARGB(255, 48, 51, 59)
                                                    .withOpacity(0.7),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: const Offset(3, 2),
                                          ),
                                        ],
                                      ),
                                      // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Kathmandu',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Bagmati',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(() => const Pokhara());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 400,
                                width: 200,
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/dharan.png'),
                                      fit: BoxFit.cover),
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
                                      // color: Colors.grey.withOpacity(0.5),
                                      height: 50,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 20),
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
                                            color:
                                                Color.fromARGB(255, 48, 51, 59)
                                                    .withOpacity(0.7),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: const Offset(3, 2),
                                          ),
                                        ],
                                      ),
                                      // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Dharan',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Koshi',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(() => const Pokhara());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 400,
                                width: 200,
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/chitwan.png'),
                                      fit: BoxFit.cover),
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
                                      // color: Colors.grey.withOpacity(0.5),
                                      height: 50,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 20),
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
                                            color:
                                                Color.fromARGB(255, 48, 51, 59)
                                                    .withOpacity(0.7),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: const Offset(3, 2),
                                          ),
                                        ],
                                      ),
                                      // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Chitwan',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Bagmati',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(() => const Pokhara());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 400,
                                width: 200,
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/butwal.png'),
                                      fit: BoxFit.cover),
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
                                      // color: Colors.grey.withOpacity(0.5),
                                      height: 50,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 20),
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
                                            color:
                                                Color.fromARGB(255, 48, 51, 59)
                                                    .withOpacity(0.7),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: const Offset(3, 2),
                                          ),
                                        ],
                                      ),
                                      // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Butwal',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Lumbini',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(() => const Pokhara());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 400,
                                width: 200,
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/birgunj.png'),
                                      fit: BoxFit.cover),
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
                                      // color: Colors.grey.withOpacity(0.5),
                                      height: 50,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 20),
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
                                            color:
                                                Color.fromARGB(255, 48, 51, 59)
                                                    .withOpacity(0.7),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: const Offset(3, 2),
                                          ),
                                        ],
                                      ),
                                      // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Birgunj',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Madhesh',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(() => const Pokhara());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 400,
                                width: 200,
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/butwal.png'),
                                      fit: BoxFit.cover),
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
                                      // color: Colors.grey.withOpacity(0.5),
                                      height: 50,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 20),
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
                                            color:
                                                Color.fromARGB(255, 48, 51, 59)
                                                    .withOpacity(0.7),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: const Offset(3, 2),
                                          ),
                                        ],
                                      ),
                                      // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Biratnagar',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Koshi',
                                            style: GoogleFonts.arsenal(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                    Get.to(() => const Pokhara());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var homeController = Get.find<HomeController>();
    List<Bus> suggestions = [];
    // suggestions = query.isEmpty
    //     ? []
    //     : homeController.doctorsResponse?.doctors
    //             ?.where((doctor) =>
    //                 (doctor.name
    //                         ?.toLowerCase()
    //                         .contains(query.toLowerCase()) ??
    //                     false) ||
    //                 (doctor.hospitalName
    //                         ?.toLowerCase()
    //                         .contains(query.toLowerCase()) ??
    //                     false) ||
    //                 (doctor.title
    //                         ?.toLowerCase()
    //                         .contains(query.toLowerCase()) ??
    //                     false) ||
    //                 (doctor.consultationCharge
    //                         ?.toLowerCase()
    //                         .contains(query.toLowerCase()) ??
    //                     false))
    //             .toList() ??
    //         [];
    var newQuery = query.toLowerCase().trim();
    suggestions = homeController.busesResponse?.buses
            ?.where(
              (bus) =>
                  (bus.name?.toLowerCase().contains(newQuery) ?? false) ||
                  (bus.agencyName?.toLowerCase().contains(newQuery) ?? false) ||
                  (bus.title?.toLowerCase().contains(newQuery) ?? false) ||
                  (bus.fair?.toLowerCase().contains(newQuery) ?? false),
            )
            .toList() ??
        [];
    return suggestions.isEmpty
        ? const Center(
            child: Text(
              'No Buses found ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 250,
                  child: BusCard(bus: suggestions[index]));
            },
          );
  }
}
