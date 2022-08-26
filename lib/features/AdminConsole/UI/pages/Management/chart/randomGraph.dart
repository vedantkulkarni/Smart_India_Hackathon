import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../injection_container.dart';
import '../../../../../../models/ClassRoom.dart';
import '../../../../Backend/aws_api_client.dart';

class CartesianClass extends StatefulWidget {
  final ClassRoom classRoom;
  const CartesianClass({Key? key, required this.classRoom}) : super(key: key);

  @override
  State<CartesianClass> createState() => _CartesianClassState();
}

class _CartesianClassState extends State<CartesianClass> {
  final List<SalesData> chartData = [
    // SalesData(1, 86, Colors.red),
    // SalesData(2, 70, Colors.red),
    // SalesData(3, 34, Colors.green),
    // SalesData(4, 68, Colors.red),
    // SalesData(5, 100, Colors.red),
    // SalesData(6, 5, Colors.green),
    // SalesData(7, 140, Colors.green),
    // SalesData(8, 177, Colors.red),
    // SalesData(9, 90, Colors.red),
    // SalesData(10, 197, Colors.red),
    // SalesData(11, 184, Colors.red),
    // SalesData(12, 54, Colors.red),
    // SalesData(13, 59, Colors.red),
    // SalesData(14, 198, Colors.red),
    // SalesData(15, 186, Colors.red),
    // SalesData(16, 170, Colors.red),
    // SalesData(17, 72, Colors.red),
    // SalesData(18, 86, Colors.red),
    // SalesData(19, 89, Colors.red),
    // SalesData(20, 195, Colors.red),
    // SalesData(21, 176, Colors.red),
    // SalesData(22, 199, Colors.red),
    // SalesData(23, 166, Colors.red),
    // SalesData(24, 63, Colors.red),
    // SalesData(25, 89, Colors.red),
    // SalesData(26, 72, Colors.red),
    // SalesData(27, 195, Colors.red),
    // SalesData(28, 187, Colors.red),
    // SalesData(29, 91, Colors.red),
    // SalesData(30, 181, Colors.red),
    // SalesData(31, 82, Colors.red),
  ];

  var studentAttendanceList = [];
  Future<void> getClassRoomGraph(ClassRoom classRoom, String month) async {
    var apiclient = getIt<AWSApiClient>();
    studentAttendanceList = await apiclient.searchByMonthandClassRoom(
        month: month, classID: classRoom.id);
    for (int i = 0; i < studentAttendanceList.length; i++) {
      chartData.add(SalesData(i + 1, studentAttendanceList[i], Colors.red));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClassRoomGraph(widget.classRoom, '09');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 400,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Attenadace by month'),
                legend: Legend(isVisible: true),
                series: <ChartSeries>[
                  // Renders line chart

                  SplineSeries<SalesData, String>(
                      //Line | Bar |  Spline  |  Area  |  Column  | Waterfall
                      // dashArray: <double>[10, 8], //length, gap
                      color: Colors.red,
                      dataSource: chartData,
                      pointColorMapper: (SalesData sales, _) => sales.color,
                      xValueMapper: (SalesData sales, _) =>
                          sales.date.toString(),
                      yValueMapper: (SalesData sales, _) => sales.sales)
                ])));
  }
}

class SalesData {
  SalesData(this.date, this.sales, this.color);
  final int date;
  final double sales;
  final Color color;
}
