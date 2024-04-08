import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/components/pie_chart.dart';
import 'package:nepal_express/app/components/sidebar.dart';
import 'package:nepal_express/app/components/stats_card.dart';
import 'package:nepal_express/app/models/stats.dart';
import 'package:nepal_express/app/utils/memory.dart';
import '../controllers/admin_home_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        sideBar: sidebar(context),
        body: GetBuilder<AdminHomeController>(
          builder: (controller) {
            if (controller.statsResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(children: [
                      StatsContainer(
                        svg: 'assets/images/bus.svg',
                        title: 'Buses',
                        value:
                            controller.statsResponse!.statistics?.noOfBuses ??
                                '',
                        color: Color.fromARGB(255, 254, 204, 204),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: Memory.getRole() == 'admin',
                        child: StatsContainer(
                          svg: 'assets/images/people.svg',
                          title: 'No of Users',
                          value: controller
                                  .statsResponse!.statistics?.totalUsers ??
                              '',
                          color: Color.fromARGB(255, 252, 252, 169),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      StatsContainer(
                        svg: 'assets/images/bookings.svg',
                        title: 'Bookings',
                        value: controller
                                .statsResponse!.statistics?.totalBookings ??
                            '',
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      StatsContainer(
                        svg: 'assets/images/income.svg',
                        title: 'Total Monthly Income',
                        value:
                            "Rs.${controller.statsResponse!.statistics?.totalMonthlyIncome}" ??
                                '',
                        color: Color.fromARGB(255, 209, 173, 250),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      StatsContainer(
                        svg: 'assets/images/totalIncome.svg',
                        title: 'Total Income',
                        value:
                            "Rs.${controller.statsResponse!.statistics?.totalIncome}" ??
                                '',
                        color: Color.fromARGB(255, 168, 252, 175),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      Text("Revenue data of past 5 months.")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      Container(
                        height: 350,
                        child: NewPieChart(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top Users',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          _buildTopUsersTable(
                              controller.statsResponse!.statistics?.topUsers),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bus Bookings',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          _buildBusBookingsTable(controller
                              .statsResponse!.statistics?.busBookings),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Revenue Data',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          _buildRevenueDataTable(controller
                              .statsResponse!.statistics?.revenueData),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _buildTopUsersTable(List<TopUser>? topUsers) {
    if (topUsers == null || topUsers.isEmpty) {
      return SizedBox.shrink();
    }

    List<DataRow> rows = topUsers.map((user) {
      return DataRow(cells: [
        DataCell(Text(user.userName ?? '')),
        DataCell(Text(user.totalAmountPaid ?? '')),
      ]);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Change the color as needed
          ),
          child: DataTable(
            columns: [
              DataColumn(label: Text('User Name',style: TextStyle(fontWeight: FontWeight.bold)),),
              DataColumn(label: Text('Total Amount Paid',style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: rows,
          ),
        ),
      ],
    );
  }

  Widget _buildBusBookingsTable(List<BusBooking>? busBookings) {
    if (busBookings == null || busBookings.isEmpty) {
      return SizedBox.shrink();
    }

    List<DataRow> rows = busBookings.map((booking) {
      return DataRow(cells: [
        DataCell(Text(booking.name ?? '')),
        DataCell(Text(booking.id ?? '')),
        DataCell(Text(booking.totalBookings ?? '')),
      ]);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Change the color as needed
          ),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Bus Name',style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Bus ID',style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Total Bookings',style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: rows,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueDataTable(List<RevenueDatum>? revenueData) {
    if (revenueData == null || revenueData.isEmpty) {
      return SizedBox.shrink();
    }

    List<DataRow> rows = revenueData.map((data) {
      return DataRow(cells: [
        DataCell(Text(data.monthName ?? '')),
        DataCell(Text(data.paymentYear ?? '')),
        DataCell(Text(data.totalIncome ?? '')),
      ]);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Change the color as needed
          ),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Month Name',style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Payment Year',style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Total Income',style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: rows,
          ),
        ),
      ],
    );
  }
}
