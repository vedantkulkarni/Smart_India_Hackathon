import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:http/http.dart' as http;
import 'package:team_dart_knights_sih/core/errors/exceptions.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

abstract class AWSApiClient {
  //User
  Future<void> authenticateUser(
      {required String email, required String password});
  Future<User> uploadUser({required User user});
  Future<User> getAdminDetails();
  Future<User> updateUser({required User updatedUser});

  //School
  Future<School> createSchool({required School school});
  Future<School> getSchoolDetails({required String schoolID});

  //Class
  Future<void> createClassRoom({required ClassRoom classRoom});
  Future<void> getClassRoom({required String classRoomID});

  //Student
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
        classRoomID
        groupClassRoomsId
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
      print(myJsonMap);
      final user = User.fromJson(myJsonMap['data']['getUser']);
      return user;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<User> uploadUser({required User user}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createUser(input: {address: "${user.address}", age: 10, assignedClass: "${user.assignedClass}", description: "${user.description}", email: ${user.email}, gender: "${user.gender}", idCard: ${user.idCard}, name: "${user.name}", phoneNumber: "${user.phoneNumber}", photo: ${user.photo}, role: ${user.role}, schoolID: "${user.schoolID}", shitfInfo: "${user.shitfInfo}"}) {
    updatedAt
    shitfInfo
    schoolID
    role
    photo
    phoneNumber
    name
    idCard
    gender
    email
    description
    createdAt
    assignedClass
    age
    address
  }
}

''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    return User.fromJson(json.decode(responseString));
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
    return School.fromJson(jsonResult);
  }

  @override
  Future<ClassRoom> createClassRoom({required ClassRoom classRoom}) async {
    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createClassRoom(input: {classRoomID: "${classRoom.classRoomID}", classRoomName: "${classRoom.classRoomName}", schoolID: "${classRoom.schoolID}", assignedTeacherName: "${classRoom.assignedTeacherName}", classRoomAssignedTeacherId: "${classRoom.classRoomAssignedTeacherId}", id: "${classRoom.id}", groupClassRoomsId: "${classRoom.groupClassRoomsId}"}) {
    classRoomID
    classRoomAssignedTeacherId
    classRoomName
  }
}


''',
    };

    final responseString = await uploadJsonBodyRequest(body);
    return ClassRoom.fromJson(json.decode(responseString));
  }

  //Class Room

  @override
  Future<ClassRoom> getClassRoom({required String classRoomID}) async {
    final body = {
      'operationName': 'MyQuery',
      'query': '''
     query MyQuery {
  getClassRoom(id: "${classRoomID}") {
    assignedTeacherName
    classRoomAssignedTeacherId
    classRoomID
    classRoomName
    createdAt
    groupClassRoomsId
    id
    schoolID
    updatedAt
    students {
      items {
        profilePhoto
        studentID
        studentName
      }
    }
    assignedTeacher {
      photo
      name
      email
      phoneNumber
    }
  }
}

'''
    };

    final responseString = await uploadJsonBodyRequest(body);
    return ClassRoom.fromJson(json.decode(responseString));
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
}
