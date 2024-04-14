import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/components/sidebar.dart';
import 'package:nepal_express/app/models/feedback.dart';
import 'package:nepal_express/app/modules/feedbacks/controllers/feedbacks_controller.dart';

class FeedbacksView extends GetView<FeedbacksController> {
  const FeedbacksView({Key? key}) : super(key: key);

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
                  'All Feedbacks',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Obx(
                () => DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey[300]!,
                  ),
                  columns: const [
                    DataColumn(
                      label: Text('Feedback ID'),
                    ),
                    DataColumn(
                      label: Text('User ID'),
                    ),
                    DataColumn(
                      label: Text('Description'),
                    ),
                    DataColumn(
                      label: Text('Created At'),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    controller.feedbacks.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(controller.feedbacks[index].feedbackId ?? '')),
                        DataCell(Text(controller.feedbacks[index].userId ?? '')),
                        DataCell(Text(controller.feedbacks[index].description ?? '')),
                        DataCell(Text(controller.feedbacks[index].createdAt?.toString() ?? '')),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
