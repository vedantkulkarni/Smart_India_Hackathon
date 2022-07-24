import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../models/Role.dart';

class AddUserForm extends StatefulWidget {
  final Role role;
  const AddUserForm({Key? key, required this.role}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        hintText: 'Enter Your Name',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        hintText: 'Enter Your Phone Number',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                  hintText: 'Enter Your Address',
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                        hintText: 'Enter Your Age',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Assigned Class',
                        hintText: 'Enter Your Assigned Class',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  submitForm(
                      name: 'name',
                      phno: '',
                      address: '',
                      role: widget.role,
                      age: '');
                },
              ),
            )
          ],
        )),
      ),
    );
  }

  Future<void> submitForm(
      {required String name,
      required String phno,
      required String address,
      required Role role,
      required String age}) async {
    const _awsUserPoolId = 'ap-south-1_TAqXrMNgh';
    const _awsClientId = '5r2nk0dcq5gv6813j23289n9m8';

    final _userPool = CognitoUserPool(
      _awsUserPoolId,
      _awsClientId,
    );

    final _cognitoUser = CognitoUser('vedantk60@gmail.com', _userPool);
    final authDetails = AuthenticationDetails(
        username: 'vedantk60@gmail.com', password: 'Unowho@23');

    CognitoUserSession? _session;
    try {
      _session = await _cognitoUser.authenticateUser(authDetails);
    } catch (e) {
      print(e);
      return;
    }

    List<CognitoUserAttribute>? attributes;
try {
  attributes = await _cognitoUser.getUserAttributes()!;
} catch (e) {
  print(e);
}
attributes!.forEach((attribute) {
  print('attribute ${attribute.getName()} has value ${attribute.getValue()}');
});

    var _identityPoolId = 'ap-south-1:e78b1945-7d3c-4ca7-824a-fc7f9be319cf';
    final _credentials = CognitoCredentials(_identityPoolId, _userPool);
    await _credentials.getAwsCredentials(_session!.getIdToken().getJwtToken());

    final _endpoint = Uri.parse(
        'https://4pz4owy3grhoxm3dfszqo2fhie.appsync-api.ap-south-1.amazonaws.com/graphql');

    final body = {
      'operationName': 'MyMutation',
      'query': '''mutation MyMutation {
  createUser(input: {email: "vedantk60@gmail.com", role: SuperAdmin, name: "Vedant Kulkarni", phoneNumber: "+91 9623026654", shitfInfo: "Morning", id: "'hh'", gender: "h", description: "h", assignedClass: "h", age: 10, address: "h"}) {
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
          'x-api-key':'da2-vkgvsw6ydjblzbglkioacaaqy4'
        },
        body: json.encode(body),
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
