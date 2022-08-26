import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:team_dart_knights_sih/injection_container.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../Backend/aws_api_client.dart';

class Month extends StatefulWidget {
  List<ClassRoom> selectedList = [];
  Month({Key? key, required this.selectedList}) : super(key: key);

  @override
  _MonthState createState() => _MonthState();
}

class _MonthState extends State<Month> {
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
  List<List<SalesData>> sd = [];

  // Future<void> MakeList() async {
  //   List<SalesData> v = [];
  //   for (int i = 0; i < widget.selectedList.length; i++) {
  //     var apiclient = getIt<AWSApiClient>();
  //     var studentAttendanceList = [];
  //     print(studentAttendanceList);
  //     print('o');
  //     studentAttendanceList = await apiclient.searchByMonthandClassRoom(
  //         month: '01', classID: widget.selectedList[i].id);
  //     print(studentAttendanceList);
  //     print('ll');
  //     for (int j = 0; j < studentAttendanceList.length; j++) {
  //       v.add(SalesData(monthTemp[i], studentAttendanceList[j], Colors.red));
  //     }
  //     sd.add(v);
  //   }
  //   print(sd);
  //   print('object');
  // }

  final List<SalesData> chartData = [
    SalesData('Jan', 86, Colors.orangeAccent),
    SalesData('Feb', 70, Colors.orangeAccent),
    SalesData('Mar', 34, Colors.orangeAccent),
    SalesData('Apr', 68, Colors.orangeAccent),
    SalesData('May', 100, Colors.orangeAccent),
    SalesData('Jun', 5, Colors.orangeAccent),
    SalesData('Jul', 40, Colors.orangeAccent),
    SalesData('Aug', 77, Colors.orangeAccent),
    SalesData('Sept', 90, Colors.orangeAccent),
    SalesData('Oct', 97, Colors.orangeAccent),
    SalesData('Nov', 84, Colors.orangeAccent),
    SalesData('Dec', 54, Colors.orangeAccent),
  ];

  final List<SalesData> chartData1 = [
    SalesData('Jan', 66, Colors.green),
    SalesData('Feb', 50, Colors.green),
    SalesData('Mar', 34, Colors.green),
    SalesData('Apr', 28, Colors.green),
    SalesData('May', 100, Colors.green),
    SalesData('Jun', 50, Colors.green),
    SalesData('Jul', 40, Colors.green),
    SalesData('Aug', 70, Colors.green),
    SalesData('Sept', 89, Colors.green),
    SalesData('Oct', 60, Colors.green),
    SalesData('Nov', 64, Colors.green),
    SalesData('Dec', 50, Colors.green),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MakeList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Center(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Attendace by month'),
              legend: Legend(isVisible: true),
              // series: List.generate(
              //     widget.selectedList.length,
              //     (index) => ColumnSeries(
              //         //Line | Bar |  Spline  |  Area  |  Column  | Waterfall
              //         // dashArray: <double>[10, 8], //length, gap
              //         color: Colors.orangeAccent,
              //         dataSource: sd[index],
              //         pointColorMapper: (SalesData sales, _) => sales.color,
              //         xValueMapper: (SalesData sales, _) => sales.month,
              //         yValueMapper: (SalesData sales, _) => sales.sales)),
              series: <ChartSeries>[
            // Renders line chart

            ColumnSeries<SalesData, String>(
                //Line | Bar |  Spline  |  Area  |  Column  | Waterfall
                // dashArray: <double>[10, 8], //length, gap
                color: Colors.orangeAccent,
                dataSource: chartData,
                pointColorMapper: (SalesData sales, _) => sales.color,
                xValueMapper: (SalesData sales, _) => sales.month,
                yValueMapper: (SalesData sales, _) => sales.sales),
          ])),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales, this.color);
  final String month;
  final double sales;
  final Color color;
}
