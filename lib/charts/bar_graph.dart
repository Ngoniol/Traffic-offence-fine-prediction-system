import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project/charts/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklySummary;
  const MyBarGraph({Key? key, required this.weeklySummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //initialize bar data
    BarData myBarData = BarData(
        sunAmount: weeklySummary[0],
        monAmount: weeklySummary[1],
        tueAmount: weeklySummary[2],
        wedAmount: weeklySummary[3],
        thurAmount:weeklySummary[4],
        friAmount: weeklySummary[5],
        satAmount: weeklySummary[6]);
    myBarData.initializedBarData();
    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: myBarData.barData
            .map(
                (data) => BarChartGroupData(
                    x: data.x,
                  barRods: [
                    BarChartRodData(toY: data.y,
                      color: Color(0xFF1D438C),
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                )).toList(),
      )
    );
  }
}