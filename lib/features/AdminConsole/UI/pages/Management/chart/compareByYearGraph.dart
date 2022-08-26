import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CartesianYear extends StatefulWidget {
  const CartesianYear({Key? key}) : super(key: key);

  @override
  _CartesianYearState createState() => _CartesianYearState();
}

class _CartesianYearState extends State<CartesianYear> {
  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(1, 30, Colors.red),
      SalesData(2, 33, Colors.red),
      SalesData(3, 34, Colors.red),
      SalesData(4, 35, Colors.red),
      SalesData(5, 30, Colors.red),
      SalesData(6, 35, Colors.red),
      SalesData(7, 40, Colors.red),
      SalesData(8, 47, Colors.red),
      SalesData(9, 40, Colors.red),
      SalesData(10, 47, Colors.red),
      SalesData(11, 44, Colors.red),
      SalesData(12, 44, Colors.red),
      SalesData(13, 59, Colors.red),
      SalesData(14, 58, Colors.red),
      SalesData(15, 56, Colors.red),
      SalesData(16, 50, Colors.red),
      SalesData(17, 52, Colors.red),
      SalesData(18, 56, Colors.red),
      SalesData(19, 59, Colors.red),
      SalesData(20, 55, Colors.red),
      SalesData(21, 66, Colors.red),
      SalesData(22, 69, Colors.red),
      SalesData(23, 66, Colors.red),
      SalesData(24, 63, Colors.red),
      SalesData(25, 69, Colors.red),
      SalesData(26, 62, Colors.red),
      SalesData(27, 65, Colors.red),
      SalesData(28, 67, Colors.red),
      SalesData(29, 71, Colors.red),
      SalesData(30, 71, Colors.red),
      SalesData(31, 72, Colors.red),
    ];

    final List<SalesData> chartData1 = [
      SalesData(1, 60, Colors.green),
      SalesData(2, 62, Colors.green),
      SalesData(3, 64, Colors.green),
      SalesData(4, 68, Colors.green),
      SalesData(5, 60, Colors.green),
      SalesData(6, 60, Colors.green),
      SalesData(7, 60, Colors.green),
      SalesData(8, 70, Colors.green),
      SalesData(9, 79, Colors.green),
      SalesData(10, 70, Colors.green),
      SalesData(11, 74, Colors.green),
      SalesData(12, 70, Colors.green),
      SalesData(13, 79, Colors.green),
      SalesData(14, 80, Colors.green),
      SalesData(15, 86, Colors.green),
      SalesData(16, 89, Colors.green),
      SalesData(17, 85, Colors.green),
      SalesData(18, 80, Colors.green),
      SalesData(19, 99, Colors.green),
      SalesData(20, 95, Colors.green),
      SalesData(21, 86, Colors.green),
      SalesData(22, 89, Colors.green),
      SalesData(23, 86, Colors.green),
      SalesData(24, 83, Colors.green),
      SalesData(25, 99, Colors.green),
      SalesData(26, 92, Colors.green),
      SalesData(27, 95, Colors.green),
      SalesData(28, 99, Colors.green),
      SalesData(29, 91, Colors.green),
      SalesData(30, 91, Colors.green),
      SalesData(31, 100, Colors.green),
    ];

    return Container(
      margin: EdgeInsets.all(20),
      child: Center(
          child: Container(
              // width: 200,

              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Attendace by month'),
                  legend: Legend(isVisible: true),
                  series: <ChartSeries>[
            // Renders line chart

            SplineSeries<SalesData, String>(
                //Line | Bar |  Spline  |  Area  |  Column  | Waterfall
                // dashArray: <double>[10, 8], //length, gap
                color: Colors.red,
                dataSource: chartData,
                pointColorMapper: (SalesData sales, _) => sales.color,
                xValueMapper: (SalesData sales, _) => sales.date.toString(),
                yValueMapper: (SalesData sales, _) => sales.sales),
            SplineSeries<SalesData, String>(
                //Line | Bar |  Spline  |  Area  |  Column  | Waterfall
                // dashArray: <double>[10, 8], //length, gap
                color: Colors.green,
                dataSource: chartData1,
                pointColorMapper: (SalesData sales, _) => sales.color,
                xValueMapper: (SalesData sales, _) => sales.date.toString(),
                yValueMapper: (SalesData sales, _) => sales.sales)
          ]))),
    );
  }
}

class SalesData {
  SalesData(this.date, this.sales, this.color);
  final int date;
  final double sales;
  final Color color;
}
