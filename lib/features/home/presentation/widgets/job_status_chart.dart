import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class JobStatusChart extends StatelessWidget {

  final int appliedCount;

  final int interviewCount;

  final int offerCount;

  final int rejectedCount;

  const JobStatusChart({

    super.key,

    required this.appliedCount,

    required this.interviewCount,

    required this.offerCount,

    required this.rejectedCount,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      height: 250,

      child: PieChart(

        PieChartData(

          sectionsSpace: 4,

          centerSpaceRadius: 60,

          sections: [

            PieChartSectionData(

              value: appliedCount.toDouble(),

              color: Colors.blue,

              title: "Applied",
            ),

            PieChartSectionData(

              value: interviewCount.toDouble(),

              color: Colors.orange,

              title: "Interview",
            ),

            PieChartSectionData(

              value: offerCount.toDouble(),

              color: Colors.green,

              title: "Offer",
            ),

            PieChartSectionData(

              value: rejectedCount.toDouble(),

              color: Colors.red,

              title: "Rejected",
            ),
          ],
        ),
      ),
    );
  }
}