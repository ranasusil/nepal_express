import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nepal_express/app/components/sidebar.dart';

import 'package:nepal_express/app/modules/agency/controllers/agency_controller.dart';

class AgencyView extends GetView<AgencyController> {
  const AgencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      sideBar: sidebar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
              children: [
                           Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'All Agencies',
                    style: GoogleFonts.arsenal(fontSize: 50),
                  ),
                ),
                DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[300]!),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
