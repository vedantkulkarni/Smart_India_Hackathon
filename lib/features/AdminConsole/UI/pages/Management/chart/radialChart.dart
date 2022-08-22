import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialChartWidget extends StatefulWidget {
  const RadialChartWidget({Key? key}) : super(key: key);

  @override
  _RadialChartWidgetState createState() => _RadialChartWidgetState();
}

class _RadialChartWidgetState extends State<RadialChartWidget> {
  var chartData = [
    _ChartData('Jan', 86, Colors.red),
    _ChartData('Feb', 70, Colors.red),
    _ChartData('Mar', 34, Colors.green),
    _ChartData('Apr', 68, Colors.red),
    _ChartData('May', 100, Colors.red),
    _ChartData('Jun', 5, Colors.green),
    _ChartData('Jul', 40, Colors.green),
    _ChartData('Aug', 77, Colors.red),
    _ChartData('Sep', 90, Colors.red),
    _ChartData('Oct', 97, Colors.red),
    _ChartData('Nov', 84, Colors.red),
    _ChartData('Dec', 54, Colors.red),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCircularChart(
                    backgroundColor: Colors.black,
                    series: <CircularSeries>[
          // RADIAL | DOUGHNUT SERIES
          DoughnutSeries<_ChartData, String>(
            // trackColor: Colors.grey.shade800,
            dataSource: chartData,
            // gap: '3%',
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            //  pointColorMapper: (_ChartData data, _) => data.color,
            // cornerStyle: CornerStyle.bothCurve,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            // radius: '70%',
            // innerRadius: '30%'
          ),
        ]))));
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);
  final String x;
  final num y;
  final Color color;
}
