import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/core/errors/exceptions.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../UI/pages/attendance.dart';

abstract class AWSApiClient {
  //User
  Future<void> authenticateUser(
      {required String email, required String password});
  Future<User> createUser({required User user});
  Future<User> getAdminDetails({required String userID});
  Future<User> updateUser({required User updatedUser});
  Future<User> deleteUser({required String email});
  Future<List<User>> getListOfUsers({required Role role});
  Future<void> signOutUser({required String email});
  Future<void> signUpUser({required String userID, required String password});
  Future<bool> confirmUser(
      {required String userID, required String confirmationCode});
  //School
  Future<School> createSchool({required School school});
  Future<School> getSchoolDetails({required String schoolID});

  //Groups
  Future<Group> createGroup({required Group group});
  Future<List<Group>> getGroupsBySchool({required String schoolID});
  Future<Group> getGroupDetails({required String groupID});
  Future<Group> updateGroup({required Group updatedGroup});

  //Class
  Future<void> createClassRoom({required ClassRoom classRoom});
  Future<ClassRoom> getClassRoom({required String classRoomID});
  Future<List<ClassRoom>> getListOfClassrooms({required int limit});
  Future<ClassRoom> deleteClassRoom({required String classRoomID});
  Future<ClassRoom> updateClassRoom({required ClassRoom classRoom});
  //Student
  Future<Student> createStudent({required Student student});
  Future<List<Student>> getListOfStudent({required int limit});
  Future<Student> deleteStudent({required String studentID});
  Future<Student> updateStudent({required Student updatedStudent});
  Future<Student> getStudent({required String studentID});

  //Attendance
  Future<Attendance> createAttendance({required Attendance attendance});
  Future<ClassAttendance> createClassAttendance(
      {required ClassAttendance classAttendance});
  Future<ClassAttendance> getClassAttendanceList({required String classID});
  Future<List<Attendance>> getStudentAnalytics(
      {required String studentId, required String month});

  // Future<Attendance> getAttendance({required })

  Future<List<ClassAttendance>> classAttendanceDateWiseList(
      {required String classId});

  //Elastic Search
  // Future<List<Student>> globalSearch(
  //     {required String searchQuery, required StudentSearchMode mode});//Implement User search also
  Future<List<Student>> searchStudent(
      {required String searchQuery, required StudentSearchMode mode});
  Future<List<Attendance>> searchAttendance(
      {required List<SearchQuery> searchQuery, required int limit});

  Future<List<ClassAttendance>> searchByMonth({required String searchQuery});
  Future<List<ClassAttendance>> searchByMonthandClassRoom(
      {required String month, required String classID});

  // Future<List<Student>> searchAttendance(
  //     {required String searchQuery, required StudentSearchMode mode});

  //Leaves
  Future<Leave> createLeave({required Leave leave});
  Future<Leave> getLeave({required String leaveID});
  Future<List<Leave>> getListOfLeaves({required int limit});
}

class AWSApiClientImpl implements AWSApiClient {
  final _endpoint = Uri.parse(
      'https://viwnyvetl5huzp44ma2ejqidju.appsync-api.ap-south-1.amazonaws.com/graphql');

  final userPool = CognitoUserPool(
    'ap-south-1_TAqXrMNgh',
    '5r2nk0dcq5gv6813j23289n9m8',
  );

  //Helper

  Future<String> uploadJsonBodyRequest(Map<String, dynamic> body) async {
    http.Response response;
    try {
      response = await http.post(
        _endpoint,
        headers: {
          'Authorization': 'API_KEY',
          'Content-Type': 'application/json',
          'x-api-key': 'da2-4kmbndiaprgwxnfjtpbqsnjlqa'
        },
        body: json.encode(body),
      );

      return response.body;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //User
  @override
  Future<void> authenticateUser(
      {required String email, required String password}) async {
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
    } on CognitoUserNewPasswordRequiredException {
      // handle New Password challenge
    } on CognitoUserMfaRequiredException {
      // handle SMS_MFA challenge
    } on CognitoUserSelectMfaTypeException {
      // handle SELECT_MFA_TYPE challenge
    } on CognitoUserMfaSetupException {
      // handle MFA_SETUP challenge
    } on CognitoUserTotpRequiredException {
      // handle SOFTWARE_TOKEN_MFA challenge
    } on CognitoUserCustomChallengeException {
      // handle CUSTOM_CHALLENGE challenge
    } on CognitoUserConfirmationNecessaryException {
      // handle User Confirmation Necessary
    } on CognitoClientException {
      // handle Wrong Username and Password and Cognito Client
      throw CredentialsNotCorrectException();
    } catch (e) {
      print(e);
    }
    print(session!.getAccessToken().getJwtToken());

    List<CognitoUserAttribute>? attributes;
    try {
      attributes = await cognitoUser.getUserAttributes();
    } catch (e) {
      print(e);
    }
    for (var attribute in attributes!) {
      print(
          'attribute ${attribute.getName()} has value ${attribute.getValue()}');
    }
  }

  Future<void> signUpUser(
      {required String userID, required String password}) async {
    CognitoUserPoolData data;
    try {
      data = await userPool.signUp(
        userID.toString(),
        password.toString(),
        // userAttributes: userAttributes,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> confirmUser(
      {required String userID, required String confirmationCode}) async {
    final cognitoUser = CognitoUser(userID, userPool);

    bool isConfirmed = await cognitoUser.confirmRegistration(confirmationCode);

    return isConfirmed;
  }

  @override
  Future<void> signOutUser({required String email}) async {
    // TODO: implement signOutUser
    final cognitoUser = CognitoUser(email.toString(), userPool);
    await cognitoUser.signOut();
    print("signout done");
  }

  @override
  Future<User> getAdminDetails({required String userID}) async {
    var body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  getUser(email: "$userID") {
    address
    age
    assignedClass {
      items {
       
        id
        classRoomName
      }
    }
    createdAt
    description
    email
    gender
    idCard
    name
    phoneNumber
    photo
    role
    schoolID
    updatedAt
    shitfInfo
  }
}
'''
    };

    try {
      final responseString = await uploadJsonBodyRequest(body);
      print(responseString);
      final myJsonMap = json.decode(responseString);

      var user = User.fromJson(myJsonMap['data']['getUser']);
      List<ClassRoom> classRoomList = [];
      for (var classRoom in json.decode(responseString)['data']['getUser']
          ['assignedClass']['items']) {
        classRoomList.add(ClassRoom.fromJson(classRoom));
      }
      user = user.copyWith(assignedClass: classRoomList);
      return user;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<User> createUser({required User user}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createUser(input: {address: "${user.address}", age: ${user.age}, description: "${user.description}", email: "${user.email}", gender: "${user.gender}", idCard: ${user.idCard}, name: "${user.name}", phoneNumber: "${user.phoneNumber}", photo: ${user.photo}, role: ${user.role.name}, schoolID: "${user.schoolID}", shitfInfo: "${user.shitfInfo}"}) {
    email
    description
    createdAt
    gender
    idCard 
    name
    phoneNumber
    photo
    role
    schoolID
    shitfInfo
    updatedAt
    age
    address
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return User.fromJson(json.decode(responseString)['data']['createUser']);
  }

  @override
  Future<User> deleteUser({required String email}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''
      mutation MyMutation {
  deleteUser(input: {email: "$email"}) {
    email
    name
    role
  }
}
'''
    };
    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return User.fromJson(json.decode(responseString));
  }

  @override
  Future<User> updateUser({required User updatedUser}) async {
    //Updated

    final body = {
      'operationName': 'MyMutation',
      'query': '''
      mutation MyMutation {
  updateUser(input: {address: "${updatedUser.address}", age: ${updatedUser.age}, description: "${updatedUser.description}", email: "${updatedUser.email}", gender: "${updatedUser.gender}", name: "${updatedUser.name}", role: ${updatedUser.role.name}, schoolID: "${updatedUser.schoolID}", shitfInfo: "${updatedUser.shitfInfo}", phoneNumber: "${updatedUser.phoneNumber}"}) {
    email
    schoolID
    age
    address
    createdAt
    description
    gender
    idCard
    name
    phoneNumber
    photo
    role
    shitfInfo
    updatedAt
  }
}
'''
    };
    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return User.fromJson(json.decode(responseString));
  }

  @override
  Future<List<User>> getListOfUsers({required Role role}) async {
    final myRole = role.name;

    final body = {
      'operationName': 'MyQuery',
      'query': '''
      query MyQuery {
  listUsers( filter: {role: {eq: $myRole}}) {
    items {
      email
      gender
      name
      phoneNumber
      role
    }
  }
}
'''
    };

    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    List<User> returnList = [];
    for (var eachUser in jsonMap['data']['listUsers']['items']) {
      returnList.add(User.fromJson(eachUser));
    }

    return returnList;
  }

  //School
  @override
  Future<School> createSchool({required School school}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createSchool(input: {address: "${school.address}", contactEmail: "${school.contactEmail}", contactPhone: "${school.contactPhone}", location: "${school.location}", schoolID: "${school.schoolID}", schoolName: "${school.schoolName}", studentCount: 10, superAdmin: "${school.superAdmin}", teacherCount: 10}) {
    address
    contactEmail
    contactPhone
    createdAt
    location
    schoolID
    schoolName
    studentCount
    superAdmin
    teacherCount
    updatedAt
  }
}''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return School.fromJson(json.decode(responseString)['data']['createSchool']);
  }

  @override
  Future<School> getSchoolDetails({required String schoolID}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  getSchool(schoolID: "$schoolID") {
    address
    contactEmail
    contactPhone
    createdAt
    location
    schoolID
    schoolName
    studentCount
    superAdmin
    teacherCount
    updatedAt
  }
}
'''
    };

    final responseString = await uploadJsonBodyRequest(body);
    final jsonResult = json.decode(responseString);
    if (jsonResult['data']['getSchool'] == null) {
      throw (SchoolNotFoundException());
    }
    return School.fromJson(jsonResult['data']['getSchool']);
  }

  //Groups
  @override
  Future<Group> createGroup({required Group group}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createGroup(input: {groupID: "${group.groupID}", schoolGroupsId: "${group.schoolGroupsId}", groupName: "${group.groupName}", createdBy: "${group.createdBy}"}) {
    groupID
    groupName
    schoolGroupsId
  }
}


''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    return Group.fromJson(json.decode(responseString));
  }

  @override
  Future<List<Group>> getGroupsBySchool({required String schoolID}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''query MyQuery {
  getSchool(schoolID: "$schoolID") {
    groups {
      items {
        groupName
        groupID
      }
    }
  }
}
''',
    };
    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    List<Group> groupsList = [];
    for (var everyItem in json.decode(responseString)['data']['getSchool']
        ['groups']['items']) {
      groupsList.add(Group.fromJson(everyItem));
    }

    return groupsList;
  }

  @override
  Future<Group> getGroupDetails({required String groupID}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''query MyQuery {
  getGroup(groupID: "$groupID") {
    createdBy
    groupID
    groupName
    schoolGroupsId
    classRooms {
      items {
        classRoomID
        classRoomName
        assignedTeacherName
        classRoomAssignedTeacherId
      }
    }
  }
}
''',
    };
    final responseString = await uploadJsonBodyRequest(body);
    return Group.fromJson(json.decode(responseString));
  }

  @override
  Future<Group> updateGroup({required Group updatedGroup}) {
    // TODO: implement updateGroup
    throw UnimplementedError();
  }

  //Class Room
  @override
  Future<ClassRoom> getClassRoom({required String classRoomID}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  getClassRoom(id: "$classRoomID") {
    attendanceMode
    classRoomName
    createdAt
    currentAttendanceDate
    groupClassRoomsId
    id
    importantNotice
    schoolClassRoomsId
    schoolID
    updatedAt
    userAssignedClassId
    students {
      items {
         dob
        classRoomStudentsId
        address
        email
        gender
        modelData
        phoneNumber
        roll
        profilePhoto
        studentID
        studentName
        idCardPhoto
      }
    }
  }
}

'''
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    var classroomResult =
        ClassRoom.fromJson(json.decode(responseString)['data']['getClassRoom']);

    List<Student> studentList = [];
    for (var student in json.decode(responseString)['data']['getClassRoom']
        ['students']['items']) {
      studentList.add(Student.fromJson(student));
    }
    classroomResult = classroomResult.copyWith(students: studentList);

    return classroomResult;
  }

  @override
  Future<ClassRoom> createClassRoom({required ClassRoom classRoom}) async {
    var attendanceMode = classRoom.attendanceMode.name;

    final body = {
      'operationName': 'MyMutation',
      'query': '''
      mutation MyMutation {
  createClassRoom(input: {attendanceMode: $attendanceMode, classRoomName: "${classRoom.classRoomName}", schoolID: "${classRoom.schoolID}", currentAttendanceDate: ${f(classRoom.currentAttendanceDate)}, groupClassRoomsId: "${classRoom.groupClassRoomsId}", importantNotice: ${classRoom.importantNotice}, schoolClassRoomsId: "${classRoom.schoolClassRoomsId}", userAssignedClassId: "${classRoom.userAssignedClassId}"}) {
    schoolID
    classRoomName
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return ClassRoom.fromJson(
        json.decode(responseString)['data']['createClassRoom']);
  }

  @override
  Future<List<ClassRoom>> getListOfClassrooms({required int limit}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
     query MyQuery {
  listClassRooms(limit: ${limit.toString()}) {
    items {
      attendanceMode
      classRoomName
      currentAttendanceDate
      groupClassRoomsId
      importantNotice
      schoolClassRoomsId
      schoolID
      userAssignedClassId
      id
    }
  }
}
'''
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    final jsonMap = json.decode(responseString);
    print(jsonMap);
    List<ClassRoom> returnList = [];

    for (var eachStudent in jsonMap['data']['listClassRooms']['items']) {
      returnList.add(ClassRoom.fromJson(eachStudent));
    }

    return returnList;
  }

  @override
  Future<ClassRoom> deleteClassRoom({required String classRoomID}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  deleteClassRoom(input: {id: "$classRoomID"}) {
    classRoomName
  }
}


''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    return ClassRoom.fromJson(
        json.decode(responseString)['data']['deleteClassRoom']);
  }

  @override
  Future<ClassRoom> updateClassRoom({required ClassRoom classRoom}) async {
    var attendanceMode = classRoom.attendanceMode.name;
    var currDate = TemporalDate(DateTime.now()).toString();
    print("$attendanceMode $currDate");

    VerificationStatus.ManualAttendance.name;
    final body = {
      'operationName': 'MyMutation',
      'query': '''
  mutation MyMutation {
  updateClassRoom(input: {attendanceMode: ${classRoom.attendanceMode.name}, classRoomName: "${classRoom.classRoomName}", currentAttendanceDate: "${classRoom.currentAttendanceDate}", id: "${classRoom.id}", importantNotice: "${classRoom.importantNotice}", schoolClassRoomsId: "${classRoom.schoolClassRoomsId}", userAssignedClassId: "${classRoom.userAssignedClassId}", schoolID: "${classRoom.schoolID}"}) {
    attendanceMode
    classRoomName
    currentAttendanceDate
    id
    importantNotice
    schoolClassRoomsId
    schoolID
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return ClassRoom.fromJson(
        json.decode(responseString)['data']['updateClassRoom']);
  }

  //Student

  @override
  Future<Student> createStudent({required Student student}) async {
    var gender = student.gender == Gender.Male ? "Male" : "Female";
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createStudent(input: {address: "${student.address}", dob: ${student.dob}, email: "${student.email}", gender: $gender, idCardPhoto: ${student.idCardPhoto}, modelData: ${student.modelData}, phoneNumber: "${student.phoneNumber}", profilePhoto: ${student.profilePhoto}, roll: "${student.roll}", studentID: "${student.studentID}", studentName: "${student.studentName}", classRoomStudentsId: "${student.classRoomStudentsId}"}) {
    email
    gender
    studentName
    studentID
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);

    return Student.fromJson(
        json.decode(responseString)['data']['createStudent']);
  }

  @override
  Future<Student> getStudent({required String studentID}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
   query MyQuery {
  getStudent(studentID: "$studentID") {
    address
    classRoomStudentsId
    email
    idCardPhoto
    phoneNumber
    profilePhoto
    studentID
    studentName
    roll
    modelData
  }
}

'''
    };

    final responseString = await uploadJsonBodyRequest(body);

    return Student.fromJson(json.decode(responseString)['data']['getStudent']);
  }

  @override
  Future<Student> updateStudent({required Student updatedStudent}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  updateStudent(input: {address: ${f(updatedStudent.address)}, classRoomStudentsId: ${f(updatedStudent.classRoomStudentsId)}, email: ${f(updatedStudent.email)}, idCardPhoto: ${f(updatedStudent.idCardPhoto)}, modelData:${updatedStudent.modelData}, phoneNumber: ${f(updatedStudent.phoneNumber)}, profilePhoto: ${f(updatedStudent.profilePhoto)}, roll: ${f(updatedStudent.roll)}, studentID: ${f(updatedStudent.studentID)},studentName: ${f(updatedStudent.studentName)}}) {
    email
    classRoomStudentsId
    modelData
    phoneNumber
    profilePhoto
    roll
    studentID
    studentName
    idCardPhoto
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return Student.fromJson(
        json.decode(responseString)['data']['updateStudent']);
  }

  @override
  Future<Student> deleteStudent({required String studentID}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  deleteStudent(input: {studentID: "$studentID"}) {
    studentName
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return Student.fromJson(json.decode(responseString));
  }

  @override
  Future<List<Student>> getListOfStudent({required int limit}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
      query MyQuery {
  listStudents(limit: $limit) {
    items {
      studentName
      studentID
      profilePhoto
      classRoomStudentsId
      modelData
      phoneNumber
      email
      roll
    }
  }
}
'''
    };

    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    print(jsonMap);
    List<Student> returnList = [];

    for (var eachStudent in jsonMap['data']['listStudents']['items']) {
      returnList.add(Student.fromJson(eachStudent));
    }

    return returnList;
  }

  @override
  Future<Attendance> createAttendance({required Attendance attendance}) async {
    String? gender;
    if (attendance.gender == null || attendance.gender == Gender.Other)
      gender = "Other";
    else {
      gender = attendance.gender == Gender.Male ? "Male" : "Female";
    }
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createAttendance(input: {date: "${attendance.date}", classID: "${attendance.classID}" , geoLatitude: ${attendance.geoLatitude.toString()}, geoLongitude: ${attendance.geoLongitude}, status: ${attendance.status.name}, studentID: "${attendance.studentID}", className: "${attendance.className}", studentName: "${attendance.studentName}", teacherID: "${attendance.teacherID}", teacherName: "${attendance.teacherName}", time: "${attendance.time}", gender: $gender,verification: ${attendance.verification.name}}) {
    date
    studentID
    time
    status
    classID
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return Attendance.fromJson(
        json.decode(responseString)['data']['createAttendance']);
  }

  @override
  Future<ClassAttendance> createClassAttendance(
      {required ClassAttendance classAttendance}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createClassAttendance(input: {classID: "${classAttendance.classID}", date: "${classAttendance.date}", presentPercent: ${classAttendance.presentPercent}, teacherEmail: "${classAttendance.teacherEmail}", time: "${classAttendance.time}"}) {
    classID
    date
    presentPercent
    teacherEmail
  }
}


''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return ClassAttendance.fromJson(
        json.decode(responseString)['data']['createClassAttendance']);
  }

  //Elastic Search
  @override
  Future<List<Student>> searchStudent(
      {required String searchQuery, required StudentSearchMode mode}) async {
    String searchFilter = '';
    switch (mode) {
      case StudentSearchMode.email:
        searchFilter = 'email';
        break;
      case StudentSearchMode.name:
        searchFilter = 'studentName';
        break;
      case StudentSearchMode.roll:
        searchFilter = 'roll';
        break;
      case StudentSearchMode.studentID:
        searchFilter = 'studentID';
        break;
      default:
    }
    final body = {
      'operationName': 'MyQuery',
      'query': '''
      query MyQuery {
  searchStudents(filter: {$searchFilter: {match: "$searchQuery"}}) {
    items {
      roll
      studentID
      studentName
      profilePhoto
      classRoomStudentsId
    }
  }
}
'''
    };

    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    print(jsonMap);
    List<Student> returnList = [];

    for (var eachStudent in jsonMap['data']['searchStudents']['items']) {
      returnList.add(Student.fromJson(eachStudent));
    }

    return returnList;
  }

  @override
  Future<List<Attendance>> searchAttendance(
      {required List<SearchQuery> searchQuery, required int limit}) async {
    List<String> searchFiltersList = [];
    for (var searchq in searchQuery) {
      String searchFilter = '';
      switch (searchq.mode) {
        case AttendanceSearchMode.date:
          searchFilter = 'date';
          searchFiltersList.add(searchFilter);

          break;
        case AttendanceSearchMode.classID:
          searchFilter = 'classID';
          searchFiltersList.add(searchFilter);

          break;
        case AttendanceSearchMode.status:
          searchFilter = 'status';
          searchFiltersList.add(searchFilter);
          break;
        case AttendanceSearchMode.className:
          searchFilter = 'className';
          searchFiltersList.add(searchFilter);
          break;
        case AttendanceSearchMode.teacherID:
          searchFilter = 'teacherID';
          searchFiltersList.add(searchFilter);
          break;
        case AttendanceSearchMode.teacherName:
          searchFilter = 'teacherName';
          searchFiltersList.add(searchFilter);
          break;
        case AttendanceSearchMode.studentName:
          searchFilter = 'studentName';
          searchFiltersList.add(searchFilter);
          break;
        case AttendanceSearchMode.verification:
          searchFilter = 'verification';
          searchFiltersList.add(searchFilter);
          break;
        case AttendanceSearchMode.gender:
          searchFilter = 'gender';
          searchFiltersList.add(searchFilter);
          break;
        default:
      }
    }
    String temp =
        '{className: {match: "5A"}, and: {verification: {match: "ManualAttendance"}, and: {status: {match: "Absent"}, and: {gender {match: "Male"}}}}}';

    String finalSearch = '';
    for (int i = 0; i < searchQuery.length; i++) {
      finalSearch += '{';
      finalSearch += '${searchFiltersList[i]}:';
      finalSearch += '{match: "${searchQuery[i].searchText}"},';
      if (i == searchQuery.length - 1) {
        for (int j = 0; j < searchQuery.length; j++) {
          finalSearch += '}';
        }
        break;
      } else {
        finalSearch += 'and: ';
      }
    }
    print(finalSearch);
    final body = {
      'operationName': 'MyQuery',
      'query': '''
     query MyQuery {
  searchAttendances(filter: $finalSearch) {
    items {
      classID
      geoLatitude
      geoLongitude
      date
      status
      studentID
      teacherID
      teacherName
      verification
      time
      className
      studentName
      gender
    }
  }
}
'''
    };

    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    print(jsonMap);
    List<Attendance> returnList = [];

    for (var eachStudent in jsonMap['data']['searchAttendances']['items']) {
      returnList.add(Attendance.fromJson(eachStudent));
    }

    return returnList;
  }

  @override
  Future<ClassAttendance> getClassAttendanceList({required String classID}) {
    // TODO: implement getClassAttendanceList
    throw UnimplementedError();
  }

  @override
  Future<List<ClassAttendance>> classAttendanceDateWiseList(
      {required String classId}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  listClassAttendances(classID: "$classId") {
    items {
      classID
      date
      presentPercent
      teacherEmail
    }
  }
}''',
    };
    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    List<ClassAttendance> returnList = [];
    for (var classAttendance in jsonMap['data']['listClassAttendances']
        ['items']) {
      returnList.add(ClassAttendance.fromJson(classAttendance));
    }

    return returnList;
  }

  @override
  Future<List<ClassAttendance>> searchByMonth(
      {required String searchQuery}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  searchClassAttendances(filter: {date: {range: $searchQuery}}) {
    items {
      date
      classID
      teacherEmail
      presentPercent
    }
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    print(jsonMap);
    List<ClassAttendance> returnList = [];

    for (var eachStudent in jsonMap['data']['searchClassAttendances']
        ['items']) {
      returnList.add(ClassAttendance.fromJson(eachStudent));
    }

    return returnList;
  }

  @override
  Future<Leave> createLeave({required Leave leave}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''
mutation MyMutation {
  createLeave(input: {leaveBody: "${leave.leaveBody}", leaveDate: "${leave.leaveDate}", leaveDays: ${leave.leaveDays}, leaveDocLink: "${leave.leaveDocLink}", leaveReason: "${leave.leaveReason}", leaveStatus: ${leave.leaveStatus}, studentID: "${leave.studentID}", teacherID: "${leave.teacherID}"}) {
    leaveBody
    leaveDate
    leaveDays
    leaveDocLink
    leaveReason
    leaveStatus
    studentID
    teacherID
  }
}
''',
    };
    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return Leave.fromJson(json.decode(responseString)['data']['createLeave']);
  }

  @override
  Future<Leave> getLeave({required String leaveID}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''
query MyQuery {
  listLeaves {
    items {
      createdAt
      leaveBody
      leaveDate
      leaveDays
      leaveDocLink
      leaveReason
      leaveStatus
      studentID
      teacherID
      updatedAt
    }
  }
}
''',
    };
    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return Leave.fromJson(json.decode(responseString)['data']['createLeave']);
  }

  @override
  Future<List<Leave>> getListOfLeaves({required int limit}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  listLeaves(limit: $limit) {
    items {
      createdAt
      leaveBody
      leaveDate
      leaveDays
      leaveDocLink
      leaveReason
      leaveStatus
      studentID
      teacherID
      updatedAt
    }
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    print(jsonMap);
    List<Leave> returnList = [];

    for (var eachStudent in jsonMap['data']['listLeaves']['items']) {
      returnList.add(Leave.fromJson(eachStudent));
    }

    return returnList;
  }

  @override
  Future<List<Attendance>> getStudentAnalytics(
      {required String studentId, required String month}) async {
    String range = '["2022-$month-01","2022-$month-30"]';
    print(studentId);
    print('lklkl');
    final body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  searchAttendances(filter: {studentID: {match: "e35e0f5b-619c-45c8-b063-5e7254af73c5"}}) {
    items {
      classID
      className
      date
      gender
      studentName
      geoLatitude
      geoLongitude
      status
      studentID
      teacherID
      teacherName
      time
      verification
    }
  }
}''',
    };

    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    print(jsonMap);
    List<Attendance> returnList = [];

    for (var eachStudent in jsonMap['data']['searchAttendances']['items']) {
      returnList.add(Attendance.fromJson(eachStudent));
    }

    return returnList;
  }

  @override
  Future<List<ClassAttendance>> searchByMonthandClassRoom(
      {required String month, required String classID}) async {
    String range = '["2022-$month-01","2022-$month-30"]';

    final body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  searchClassAttendances(filter: {classID: {match: "$classID"}, and: {date: {range: "$month"}}}) {
    items {
      date
      presentPercent
      time
      teacherEmail
      classID
    }
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);

    final jsonMap = json.decode(responseString);
    print(jsonMap);
    List<ClassAttendance> returnList = [];

    for (var eachStudent in jsonMap['data']['searchClassAttendances']
        ['items']) {
      returnList.add(ClassAttendance.fromJson(eachStudent));
    }

    return returnList;
  }
}

String f(var val) {
  if (val == null) {
    return null.toString();
  }

  var ans = '''"$val"''';
  return ans;
}
