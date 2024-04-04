import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepal_express/app/components/sidebar.dart';
import '../controllers/trips_controller.dart';

class TripsView extends GetView<TripsController> {
  const TripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      sideBar: sidebar(context),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'All Trips',
                  style: GoogleFonts.arsenal(fontSize: 50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddTripDialog(),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Add Trip'), // Add text to the button if needed
                      const Icon(Icons.add),
                    ],
                  ),
                ),
              ),
              Obx(
                () => DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.grey[300]!),
                  columns: const [
                    DataColumn(
                      label: Text('Title',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('From',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('To',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    controller.trips.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(controller.trips[index].title ?? '')),
                        DataCell(Text(controller.trips[index].cityFrom ?? '')),
                        DataCell(Text(controller.trips[index].cityTo ?? '')),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => controller.previousPage(),
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 10),
                  Text('Page ${controller.currentPage}'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => controller.nextPage(),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddTripDialog extends StatelessWidget {
  const AddTripDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<TripsController>();
    return AlertDialog(
      title: const Text('Add Trip'),
      content: SingleChildScrollView(
        child: Form(
          key: controller.addTripFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.cityFromController,
                decoration: const InputDecoration(labelText: 'From'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city from';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.cityToController,
                decoration: const InputDecoration(labelText: 'To'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city to';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: controller.onAddTrip,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
