import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({Key? key}) : super(key: key);

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  var pieData = [
    _PieData(
      'Jan',
      86,
    ),
    _PieData(
      'Feb',
      70,
    ),
    _PieData(
      'Mar',
      34,
    ),
    _PieData(
      'Apr',
      68,
    ),
    _PieData(
      'May',
      100,
    ),
    _PieData(
      'Jun',
      5,
    ),
    _PieData(
      'Jul',
      40,
    ),
    _PieData(
      'Aug',
      77,
    ),
    _PieData(
      'Sep',
      90,
    ),
    _PieData(
      'Oct',
      97,
    ),
    _PieData(
      'Nov',
      84,
    ),
    _PieData(
      'Dec',
      54,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart'),
      ),
      body: Center(
          child: Container(
        margin: EdgeInsets.all(20),
        child: SfCircularChart(
            backgroundColor: Colors.brown,
            // palette: [Colors.red, Colors.green, Colors.blue],
            title: ChartTitle(
                text: 'Attendace of class',
                textStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            legend: Legend(isVisible: true),
            series: <PieSeries<_PieData, String>>[
              PieSeries<_PieData, String>(
                  explode: true,
                  explodeIndex: 0,
                  dataSource: pieData,
                  // enableSmartLabels: true,
                  radius: '50',
                  strokeWidth: 0,
                  strokeColor: Colors.black,
                  xValueMapper: (_PieData data, _) => data.xData,
                  yValueMapper: (_PieData data, _) => data.yData,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(color: Colors.black, fontSize: 18))),
            ]),
      )),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData);
  final String xData;
  final num yData;
}
