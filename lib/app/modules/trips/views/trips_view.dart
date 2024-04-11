import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepal_express/app/components/sidebar.dart';
import 'package:nepal_express/app/models/allTrips.dart';
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
                offset: const Offset(0, 3),
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
                      builder: (context) => const AddTripDialog(),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Add Trip'),
                      Icon(Icons.add),
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
                    DataColumn(
                      label: Text('Is Deleted',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Actions',
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
                        DataCell(Text(controller.trips[index].isDeleted ?? '')),
                        DataCell(
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => UpdateTripDialog(
                                        trip: controller.trips[index]),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.grey),
                                      SizedBox(width: 8.0),
                                      Text('Edit',
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showConfirmationDialog(context, () {
                                    controller.deleteTrip(
                                        controller.trips[index].tripId ?? '');
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8.0),
                                      Text('Delete',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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

  Future<void> showConfirmationDialog(
      BuildContext context, Function onConfirm) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to perform this action?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
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

class UpdateTripDialog extends StatelessWidget {
  final Trip trip;

  const UpdateTripDialog({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: trip.title ?? '');
    final TextEditingController cityFromController =
        TextEditingController(text: trip.cityFrom ?? '');
    final TextEditingController cityToController =
        TextEditingController(text: trip.cityTo ?? '');

    return AlertDialog(
      title: const Text('Update Trip Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: cityFromController,
              decoration: const InputDecoration(labelText: 'From'),
            ),
            TextFormField(
              controller: cityToController,
              decoration: const InputDecoration(labelText: 'To'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            TripsController controller = Get.find<TripsController>();
            controller.updateTripDetails(
              trip.tripId ?? '',
              titleController.text,
              cityFromController.text,
              cityToController.text,
            );
            Get.back();
          },
          child: const Text('Update'),
        ),
        ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
