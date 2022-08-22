import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/injection_container.dart';
import 'package:team_dart_knights_sih/models/ClassAttendance.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

class Cartesian extends StatefulWidget {
  const Cartesian({Key? key}) : super(key: key);

  @override
  _CartesianState createState() => _CartesianState();
}

class _CartesianState extends State<Cartesian> {
  final List<SalesData> chartData = [
    // SalesData('Jan', 86, Colors.red),
    // SalesData('Feb', 70, Colors.red),
    // SalesData('Mar', 34, Colors.green),
    // SalesData('Apr', 68, Colors.red),
    // SalesData('May', 100, Colors.red),
    // SalesData('Jun', 5, Colors.green),
    // SalesData('Jul', 40, Colors.green),
    // SalesData('Aug', 77, Colors.red),
    // SalesData('Sep', 90, Colors.red),
    // SalesData('Oct', 97, Colors.red),
    // SalesData('Nov', 84, Colors.red),
    // SalesData('Dec', 54, Colors.red),
  ];
  List<double> monthWise = [];
  bool isLoaded = false;
  Future<void> searchAttendanecByMonth() async {
    var apiclient = getIt<AWSApiClient>();
    monthWise.add(0);
    for (int i = 1; i <= 12; i++) {
      String startDate, endDate;
      if (i <= 9) {
        startDate = "2022-0$i-01";
        endDate = "2022-0$i-30";
      } else {
        startDate = "2022-$i-01";
        endDate = "2022-$i-30";
      }
      var classAttendanceList = await apiclient.searchByMonth(
          searchQuery: '["$startDate","$endDate"]');
      int listLenght = classAttendanceList.length;
      double sum = 0;
      if (classAttendanceList.isEmpty) {
        monthWise.add(0);
        continue;
      }
      for (var classAttendance in classAttendanceList) {
        sum += double.parse(classAttendance.presentPercent == double.nan
            ? '0'
            : classAttendance.presentPercent.toString());
      }
      var avg = sum / listLenght;
      print(avg);
      monthWise.add(avg);
    }
    List<String> monthTemp = [
      'Nan',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    for (int i = 0; i <= 12; i++) {
      print(monthTemp[i] + " " + monthWise[i].toString());
      if (monthWise[i] < 1) {
        chartData.add(SalesData(monthTemp[i], 0, Colors.red));
      } else {
        chartData.add(SalesData(monthTemp[i], monthWise[i], Colors.red));
      }
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    searchAttendanecByMonth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      // appBar: AppBar(
      //   title: const Text('Line Chart'),
      // ),
      body: isLoaded == false
          ? Container(
              child: progressIndicator,
            )
          : Container(
              margin: const EdgeInsets.all(20),
              child: Center(
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Attenadace by month'),
                      legend: Legend(isVisible: true),
                      series: <ChartSeries>[
                    ColumnSeries<SalesData, String>(
                        //Line | Bar |  Spline  |  Area  |  Column  | Waterfall
                        // dashArray: <double>[10, 8], //length, gap
                        color: Colors.red,
                        dataSource: chartData,
                        pointColorMapper: (SalesData sales, _) => sales.color,
                        xValueMapper: (SalesData sales, _) => sales.month,
                        yValueMapper: (SalesData sales, _) => sales.sales)
                  ])),
            ),
    ));
  }
}

class SalesData {
  SalesData(this.month, this.sales, this.color);
  final String month;
  final double sales;
  final Color color;
}
