import 'package:nepal_express/app/models/bus.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusCard extends StatelessWidget {
  final Bus bus;
  final bool showAnimation;
  const BusCard({super.key, required this.bus, this.showAnimation = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 158, 158, 158).withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ]),
      child: Row(
        children: [
          Expanded(
            child: showAnimation
                ? Hero(
                    tag: bus.id!,
                    child: Image.network(
                      getImageUrl(bus.avatar),
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  )
                : Image.network(
                    getImageUrl(bus.avatar),
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bus.name ?? '',
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(bus.title ?? '', style: const TextStyle(fontSize: 16)),
                Text(bus.agencyName ?? '', style: const TextStyle(fontSize: 16)),
                Text(bus.agencyAddress ?? ''),
                Text(bus.agencyEmail ?? ''),
                Text(
                  "Fair: Rs.${bus.fair}" ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //view bus button
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.BUS_DETAIL, arguments: bus);
                  },
                  child: Text('View Bus'),
                  style: ElevatedButton.styleFrom(
                    primary:
                        Color.fromARGB(208, 92, 117, 143), // background color
                    onPrimary:
                        const Color.fromARGB(255, 255, 255, 255), // text color
                    elevation: 5, // button's elevation when it's pressed
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
