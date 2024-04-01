import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NewPieChart extends StatelessWidget {
  const NewPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade500,
          width: 0.5,
        ),
      ),
      child: PieChart(
        swapAnimationDuration: const Duration(milliseconds: 750),
        // swapAnimationCurve: Curve.easeInOutQuint,
        PieChartData(
          centerSpaceRadius: 0,
          sections: [
            PieChartSectionData(
              value: 20,
              color: const Color.fromARGB(255, 252, 109, 109),
              radius: 100,
              title: "Dec",
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 10,
              color: Colors.blueAccent,
              radius: 100,
              title: "Jan",
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 30,
              color: const Color.fromARGB(255, 68, 255, 186),
              radius: 100,
              title: "Feb",
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 3,
              color: const Color.fromARGB(255, 255, 124, 68),
              radius: 100,
              title: "Apr",
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 37,
              color: const Color(0xfff8b250),
              radius: 100,
              title: "Mar",
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
