import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:http/http.dart' as http;
import 'package:team_dart_knights_sih/core/errors/exceptions.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

abstract class AWSApiClient {
  //User
  Future<void> authenticateUser(
      {required String email, required String password});
  Future<User> createUser({required User user});
  Future<User> getAdminDetails();
  Future<User> updateUser({required User updatedUser});
  Future<User> deleteUser({required String email});
  Future<List<User>> getListOfUsers({required Role role});

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
  Future<List<ClassRoom>> getListOfClassrooms();
  Future<ClassRoom> deleteClassRoom({required String classRoomID});
  Future<ClassRoom> updateClassRoom({required ClassRoom classRoom});
  //Student
  Future<Student> createStudent({required Student student});
  Future<List<Student>> getListOfStudent({required int limit});
  Future<Student> deleteStudent({required String studentID});
  Future<Student> updateStudent({required Student updatedStudent});
  Future<Student> getStudent({required String studentID});
}

class AWSApiClientImpl implements AWSApiClient {
  final _endpoint = Uri.parse(
      'https://4pz4owy3grhoxm3dfszqo2fhie.appsync-api.ap-south-1.amazonaws.com/graphql');

  //Helper

  Future<String> uploadJsonBodyRequest(Map<String, dynamic> body) async {
    http.Response response;
    try {
      response = await http.post(
        _endpoint,
        headers: {
          'Authorization': 'API_KEY',
          'Content-Type': 'application/json',
          'x-api-key': 'da2-vkgvsw6ydjblzbglkioacaaqy4'
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
    final userPool = CognitoUserPool(
      'ap-south-1_TAqXrMNgh',
      '5r2nk0dcq5gv6813j23289n9m8',
    );
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

  @override
  Future<User> getAdminDetails() async {
    const body = {
      'operationName': 'MyQuery',
      'query': '''
query MyQuery {
  getUser(email: "vedantk60@gmail.com") {
    address
    age
    assignedClass {
      items {
       
        
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

    http.Response response;

    final _endpoint = Uri.parse(
        'https://4pz4owy3grhoxm3dfszqo2fhie.appsync-api.ap-south-1.amazonaws.com/graphql');

    try {
      response = await http.post(
        _endpoint,
        headers: {
          'Authorization': 'API_KEY',
          'Content-Type': 'application/json',
          'x-api-key': 'da2-vkgvsw6ydjblzbglkioacaaqy4'
        },
        body: json.encode(body),
      );

      final myJsonMap = json.decode(response.body);

      final user = User.fromJson(myJsonMap['data']['getUser']);
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
  updateUser(input: {address: "${updatedUser.address}", age: 10, description: "${updatedUser.description}", email: "${updatedUser.email}", gender: "${updatedUser.gender}", name: "${updatedUser.name}", role: SuperAdmin, schoolID: "${updatedUser.schoolID}", shitfInfo: "${updatedUser.shitfInfo}", phoneNumber: "${updatedUser.phoneNumber}"}) {
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
  listUsers(filter: {role: {eq: $myRole}}) {
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
    assignedTeacherName
    attendanceMode
    classRoomName
    currentAttendance
    groupClassRoomsId
    id
    importantNotice
    schoolClassRoomsId
    schoolID
    updatedAt
    userAssignedClassId
    students {
      items {
        address
        email
        idCardPhoto
        phoneNumber
        profilePhoto
        studentID
        studentName
      }
    }
  }
  }
'''
    };

    final responseString = await uploadJsonBodyRequest(body);
    
    var classroomResult =
        ClassRoom.fromJson(json.decode(responseString)['data']['getClassRoom']);
    final List<Student> studentList = [];
    for (var everyStudent in json.decode(responseString)['data']['getClassRoom']
        ['students']['items']) {
      studentList.add(Student.fromJson(everyStudent));
    }
    classroomResult = classroomResult.copyWith(students: studentList);
    print(classroomResult);
    return classroomResult;
  }

  @override
  Future<ClassRoom> createClassRoom({required ClassRoom classRoom}) async {
    var attendanceMode = classRoom.attendanceMode.name;
    attendanceMode ??= VerificationStatus.ManualAttendance.name;
    final body = {
      'operationName': 'MyMutation',
      'query': '''
      mutation MyMutation {
  createClassRoom(input: {assignedTeacherName: "${classRoom.assignedTeacherName}", attendanceMode: $attendanceMode, classRoomName: "${classRoom.classRoomName}", currentAttendance: 10, groupClassRoomsId: "${classRoom.groupClassRoomsId}", id: "${classRoom.id}", importantNotice: "${classRoom.importantNotice}", schoolClassRoomsId: "${classRoom.schoolClassRoomsId}", schoolID: "${classRoom.schoolID}", userAssignedClassId: "${classRoom.userAssignedClassId}"}) {
    assignedTeacherName
    attendanceMode
    classRoomName
    currentAttendance
    groupClassRoomsId
    id
    importantNotice
    schoolClassRoomsId
    schoolID
    userAssignedClassId
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    return ClassRoom.fromJson(
        json.decode(responseString)['data']['createClassRoom']);
  }

  @override
  Future<List<ClassRoom>> getListOfClassrooms() async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
      query MyQuery {
  listClassRooms {
    items {
      assignedTeacherName
      classRoomName
      currentAttendance
      id
      userAssignedClassId
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
    attendanceMode ??= VerificationStatus.ManualAttendance.name;
    final body = {
      'operationName': 'MyMutation',
      'query': '''
      mutation MyMutation {
  updateClassRoom(input: {id: "${classRoom.id}", classRoomName: "${classRoom.classRoomName}", assignedTeacherName: "${classRoom.assignedTeacherName}", attendanceMode: $attendanceMode, currentAttendance: 10, groupClassRoomsId: "${classRoom.groupClassRoomsId}", importantNotice: "${classRoom.importantNotice}", schoolClassRoomsId: "${classRoom.schoolClassRoomsId}", schoolID: "${classRoom.schoolID}", userAssignedClassId: "${classRoom.userAssignedClassId}"}) {
    classRoomName
    assignedTeacherName
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
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createStudent(input: { classRoomStudentsId: "${student.classRoomStudentsId}", idCardPhoto: ${student.idCardPhoto}, profilePhoto: ${student.profilePhoto}, studentID: "${student.studentID}", studentName: "${student.studentName}"}) {
    studentName
    studentID
  }
}
''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    return Student.fromJson(json.decode(responseString));
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
  }
}

'''
    };

    final responseString = await uploadJsonBodyRequest(body);
    print(responseString);
    return Student.fromJson(json.decode(responseString)['data']['getStudent']);
  }

  @override
  Future<Student> updateStudent({required Student updatedStudent}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  updateStudent(input: {address: "${updatedStudent.address}", classRoomStudentsId: "${updatedStudent.classRoomStudentsId}", email: "${updatedStudent.email}", idCardPhoto: ${updatedStudent.idCardPhoto}, phoneNumber: "${updatedStudent.phoneNumber}", profilePhoto: ${updatedStudent.profilePhoto}, studentID: "${updatedStudent.studentID}", studentName: "${updatedStudent.studentName}"}) {
    classRoomStudentsId
    email
    profilePhoto
    studentID
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
}
