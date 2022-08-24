import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  String sessionToken;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize, this.sessionToken, this.region);

  factory Policy.fromS3PresignedPost(
      String key,
      String bucket,
      int expiryMinutes,
      String accessKeyId,
      int maxFileSize,
      String sessionToken,
      String region) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final p = Policy(key, bucket, datetime, expiration, cred, maxFileSize,
        sessionToken, region);
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    // Safe to remove the "acl" line if your bucket has no ACL permissions
    return '''
    { "expiration": "$expiration",
      "conditions": [
        {"bucket": "$bucket"},
        ["starts-with", "\$key", "$key"],
        {"acl": "public-read"},
        ["content-length-range", 1, $maxFileSize],
        {"x-amz-credential": "$credential"},
        {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
        {"x-amz-date": "$datetime" },
        {"x-amz-security-token": "$sessionToken" }
      ]
    }
    ''';
  }
}

Future<void> uploadFile({required File file}) async {

  const _identityPoolId = 'ap-south-1:e78b1945-7d3c-4ca7-824a-fc7f9be319cf';
  final _userPool = CognitoUserPool(
    'ap-south-1_TAqXrMNgh',
    '5r2nk0dcq5gv6813j23289n9m8',
  );
  final _cognitoUser = CognitoUser('vedantk60@gmail.com', _userPool);
  final authDetails = AuthenticationDetails(
    username: 'vedantk60@gmail.com',
    password: 'Unowho@23',
  );
  CognitoUserSession? _session;
  try {
    _session = await _cognitoUser.authenticateUser(authDetails);
  } catch (e) {
    print(e);
  }

  final _credentials = CognitoCredentials(_identityPoolId, _userPool);
  await _credentials.getAwsCredentials(_session!.getIdToken().getJwtToken());
  print("credentials : ${_credentials.accessKeyId}");

  const _region = 'ap-south-1';
  const _s3Endpoint =
      'https://grandfinale4eb33be56aa4404e8544507a94058c9f101118-staging.s3-ap-south-1.amazonaws.com';
  // const _s3Endpoint = 'https://s3.console.aws.amazon.com/s3/buckets/grandfinaleimages101118-staging?region=ap-south-1&tab=objects';

  // final file = File.fromUri(Uri.parse('https://avatars.githubusercontent.com/u/24658039?v=4'));

  final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
  final length = await file.length();

  final uri = Uri.parse(_s3Endpoint);
  final req = http.MultipartRequest("POST", uri);
  final multipartFile = http.MultipartFile('file', stream, length,
      filename: path.basename(file.path));

  const String fileName = 'vedant-dattatray-kulkarni';
  final String usrIdentityId = _credentials.userIdentityId!;
  final String bucketKey = 'test/$usrIdentityId/$fileName';
  final policy = Policy.fromS3PresignedPost(
      bucketKey,
      'grandfinale4eb33be56aa4404e8544507a94058c9f101118-staging',
      15,
      _credentials.accessKeyId!,
      length,
      _credentials.sessionToken!,
      _region);
  final key = SigV4.calculateSigningKey(
      _credentials.secretAccessKey!, policy.datetime, _region, 's3');
  final signature = SigV4.calculateSignature(key, policy.encode());

  req.files.add(multipartFile);
  req.fields['key'] = policy.key;
  // req.fields['Connection'] = 'Keep-alive';
  // req.fields['acl'] =
  //     'public-read'; // Safe to remove this if your bucket has no ACL permissions
  req.fields['X-Amz-Credential'] = policy.credential;
  req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
  req.fields['X-Amz-Date'] = policy.datetime;
  req.fields['Policy'] = policy.encode();
  req.fields['X-Amz-Signature'] = signature;
  req.fields['x-amz-security-token'] = _credentials.sessionToken!;

  try {
    var res = await req.send();

    var resp = res.stream.transform(utf8.decoder);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print("Status code: ${res.statusCode}");
      var bytes = <int>[];

      res.stream.listen((newBytes) {
        bytes.addAll(newBytes);
        print("Stream: $bytes");
      }).onDone(
        () async {
          // await fileDet.writeAsBytes(bytes);
          print("On Done: $bytes");
        },
      );
    } else {
      var response = await http.Response.fromStream(res);

      if (response.headers != null) {
        print("hello hello");
        print(response.headers);
      } else {
        print('null response');
      }
    }
  } catch (e) {
    print('inside err');
    print(e.toString());
  }
}

Future<Image> getObjectFromS3() async {
  const _identityPoolId = 'ap-south-1:e78b1945-7d3c-4ca7-824a-fc7f9be319cf';
  final _userPool = CognitoUserPool(
    'ap-south-1_TAqXrMNgh',
    '5r2nk0dcq5gv6813j23289n9m8',
  );
  final _cognitoUser = CognitoUser('vedantk60@gmail.com', _userPool);
  final authDetails = AuthenticationDetails(
    username: 'vedantk60@gmail.com',
    password: 'Unowho@23',
  );
  CognitoUserSession? _session;
  try {
    _session = await _cognitoUser.authenticateUser(authDetails);
  } catch (e) {
    print(e);
  }

  final _credentials = CognitoCredentials(_identityPoolId, _userPool);
  await _credentials.getAwsCredentials(_session!.getIdToken().getJwtToken());
  print("credentials : ${_credentials.accessKeyId}");
  const host = 's3.ap-south-1.amazonaws.com';
  const region = 'ap-south-1';
  const service = 's3';
  const key = 'grandfinaleimages101118-staging/1653508157792.jpg';
  final payload = SigV4.hashCanonicalRequest('');
  final datetime = SigV4.generateDatetime();
  final canonicalRequest = '''GET
${'/$key'.split('/').map((s) => Uri.encodeComponent(s)).join('/')}

host:$host
x-amz-content-sha256:$payload
x-amz-date:$datetime
x-amz-security-token:${_credentials.sessionToken}

host;x-amz-content-sha256;x-amz-date;x-amz-security-token
$payload''';
  final credentialScope = SigV4.buildCredentialScope(datetime, region, service);
  final stringToSign = SigV4.buildStringToSign(
      datetime, credentialScope, SigV4.hashCanonicalRequest(canonicalRequest));
  final signingKey = SigV4.calculateSigningKey(
      _credentials.secretAccessKey!, datetime, region, service);
  final signature = SigV4.calculateSignature(signingKey, stringToSign);

  final authorization = [
    'AWS4-HMAC-SHA256 Credential=${_credentials.accessKeyId}/$credentialScope',
    'SignedHeaders=host;x-amz-content-sha256;x-amz-date;x-amz-security-token',
    'Signature=$signature',
  ].join(',');

  final uri = Uri.https(host, key);
  http.Response response;
  try {
    response = await http.get(uri, headers: {
      'Authorization': authorization,
      'x-amz-content-sha256': payload,
      'x-amz-date': datetime,
      'x-amz-security-token': _credentials.sessionToken!,
    });
    print(response.bodyBytes);
    var image = Image.memory(response.bodyBytes);
    return image;
  } catch (e) {
    print(e);
  }
  return Image.network('');
  // final file = File(path.join(
  //     '/path/to/my/folder',
  //     'square-cinnamon-downloaded.jpg'));

  // try {
  //   await file.writeAsBytes(response.bodyBytes);
  // } catch (e) {
  //   print(e.toString());
  //   return;
  // }

  print('complete!');
}
