import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'package:get/get.dart';
import 'package:nepal_express/app/components/sidebar.dart';

import '../controllers/agency_controller.dart';

class AgencyView extends GetView<AgencyController> {
  const AgencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      sideBar: sidebar(context),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Address', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: controller.agencies.map((agency) {
            return DataRow(cells: [
              DataCell(Text(agency.userId ?? '')),
              DataCell(Text(agency.fullName ?? '')),
              DataCell(Text(agency.email ?? '')),
              DataCell(Text(agency.address ?? '')),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}