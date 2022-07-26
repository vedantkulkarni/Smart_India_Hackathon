import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import '../../../models/User.dart';

abstract class AWSApiClient {
  Future<void> authenticateUser(
      {required String email, required String password});
  Future<User> uploadUser({required User user});
  Future<User> getAdminDetails();
}

class AWSApiClientImpl implements AWSApiClient {
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
    assignedClass
    createdAt
    email
    description
    gender
    id
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
      print(response.body);
      final  myJsonMap = json.decode(response.body);
      print(myJsonMap);
      final user = User.fromJson(myJsonMap['data']['getUser']);
      return user;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<User> uploadUser({required User user}) async{
   

    final _endpoint = Uri.parse(
        'https://4pz4owy3grhoxm3dfszqo2fhie.appsync-api.ap-south-1.amazonaws.com/graphql');

    final body = {  
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createUser(input: {email: "${user.email}", role: ${user.role}, name: "${user.name}", phoneNumber: "${user.phoneNumber}", shitfInfo: "${user.shitfInfo}", id: "${user.id}", gender: "${user.gender}", description: "${user.description}", assignedClass: "${user.assignedClass}", age: , ${user.age}address: "${user.address}"}) {
    id
  }
}
''',
    };
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
      print(response.body);
      final jsonMap = json.decode(response.body);
      return User.fromJson(jsonMap);
    } catch (e) {
      print(e);
      throw e;
    }
  }
  }

