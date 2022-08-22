import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:team_dart_knights_sih/main.dart';

List<List<String>> itemList = [
  <String>[
    "className",
    "date",
    "geoLatitude",
    "geoLongitude",
    "status",
    "studentName",
    "teacherName",
    "time",
    "verification"
  ]
];

void save() async {
  print('kkkkk');
  itemList.add([
    "5A",
    "2022-08-17",
    "18.4577404",
    "73.8507438",
    "Absent",
    "Utkarsh Gupta",
    "Vedant Dattatray Kulkarni",
    "09:39:29.587049000",
    "ManualAttendance"
  ]);

  print('CSV Function Start');

  String csvData = ListToCsvConverter().convert(itemList);
  print(csvData);
  // DateTime now = DateTime.now();
  //String formattedDate = DateFormat('MM-dd-yyy-HH-mm-ss').format(now);
  // String formattedDate = DateFormat.EEEE().format(DateTime.now());
  if (isDesktop) {
    print('desktop');

    Directory? appDocDir = await getDownloadsDirectory();

    String appDocumentPath = appDocDir!.path;
    String filePath = '$appDocumentPath/demoCSVFile.csv';

    print(filePath);

    File file = File(filePath);

    file.writeAsString(csvData.toString());

    File file1 = File(filePath); // 1
    String fileContent = await file1.readAsString(); // 2

  }
}
