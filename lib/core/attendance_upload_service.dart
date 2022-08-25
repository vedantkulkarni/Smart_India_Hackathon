import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/models/ClassAttendance.dart';
import '../features/AdminConsole/Backend/aws_api_client.dart';
import '../injection_container.dart';
import '../models/Attendance.dart';
import '../models/ClassRoom.dart';

class AttendanceUploadModel {
  int id = 0;
  TemporalDate date;
  TemporalTime time;

  final ClassAttendance classAttendance;
  final List<Attendance> attendanceList;
  final ClassRoom updatedClassRoom;

  AttendanceUploadModel(
      {required this.classAttendance,
      required this.attendanceList,
      required this.updatedClassRoom,
      required this.date,
      required this.time});

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toString(),
        'time': time.toString(),
        'classAttendance': classAttendance.toJson(),
        'attendanceList': attendanceListToJson(),
        'updatedClassRoom': updatedClassRoom,
      };

  List<Map<String, dynamic>> attendanceListToJson() {
    List<Map<String, dynamic>> attendanceListJson = [];
    for (var att in attendanceList) {
      attendanceListJson.add(att.toJson());
    }

    return attendanceListJson;
  }
}

class AttendanceUploadService {
  // late AttendanceUploadModel _attendanceUploadModel;
  late AWSApiClient apiClient;
  var prefs;
  Future<bool> uploadAttendance(
      {required AttendanceUploadModel attendanceUploadModel}) async {
    prefs = await SharedPreferences.getInstance();
    apiClient = getIt<AWSApiClient>();
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      await uploadAttendanceToDatabase(
          attendanceUploadModel: attendanceUploadModel);

      return true;
    } else {
      await putInLocalStore(attendanceUploadModel: attendanceUploadModel);
      return false;
    }
  }

  Future<void> uploadAttendanceToDatabase(
      {required AttendanceUploadModel attendanceUploadModel}) async {
    for (var attendance in attendanceUploadModel.attendanceList) {
      await apiClient.createAttendance(attendance: attendance);
    }
    await apiClient.createClassAttendance(
        classAttendance: attendanceUploadModel.classAttendance);
    await apiClient.updateClassRoom(
        classRoom: attendanceUploadModel.updatedClassRoom);
  }

  Future<void> putInLocalStore(
      {required AttendanceUploadModel attendanceUploadModel}) async {
    var classAttendanceJson = attendanceUploadModel.toJson();
    print(classAttendanceJson);
    print("putting in local store");

    var classAttendanceString = json.encode(classAttendanceJson);

    List<String> getItemsAlreadyPresent =
        await prefs.getStringList(sharedPrefKey);
    if (getItemsAlreadyPresent == null) {
      getItemsAlreadyPresent = [];
    } else {
      getItemsAlreadyPresent.add(classAttendanceString);
    }
    // print(classAttendanceJson);
    await prefs.setStringList(sharedPrefKey, getItemsAlreadyPresent);

    // var finalJson = _attendanceUploadModel.toJson();
  }
}
