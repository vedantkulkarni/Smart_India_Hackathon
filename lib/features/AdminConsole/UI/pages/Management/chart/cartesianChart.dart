import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/injection_container.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

class Cartesian extends StatefulWidget {
  const Cartesian({Key? key}) : super(key: key);

  @override
  _CartesianState createState() => _CartesianState();
}

class _CartesianState extends State<Cartesian> {
  final List<SalesData> chartData = [
    // SalesData('Jan', 12, Colors.green),
    // SalesData('Feb', 23, Colors.green),
    // SalesData('March', 78, Colors.green),
    // SalesData('April', 54, Colors.green),
    // SalesData('May', 34, Colors.green),
    // SalesData('June', 3, Colors.green),
    // SalesData('July', 34, Colors.green),
    // SalesData('Aug', 64, Colors.green),
    // SalesData('Sept', 54, Colors.green),
    // SalesData('Oct', 4, Colors.green),
    // SalesData('Nov', 89, Colors.green),
    // SalesData('Dec', 34, Colors.green),
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

        // chartData.add(SalesData(monthTemp[i], 0, Colors.red));
      }
    }
    setState(() {
      BlocProvider.of<AdminCubit>(context).isAnalyticsFetched = true;
      isLoaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    isLoaded = BlocProvider.of<AdminCubit>(context).isAnalyticsFetched;
    if (isLoaded == false) {
      searchAttendanecByMonth();
    }
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
              margin: EdgeInsets.all(20.sp),
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
