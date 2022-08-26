import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';

Future<String?> uploadImage(XFile pickedFile, String studentID) async {
  final key = '$studentID';
  final file = File(pickedFile.path);
  try {
  
    final UploadFileResult result = await Amplify.Storage.uploadFile(
      local: file,
      key: "students/$key",
      onProgress: (progress) {
        print('Fraction completed: ${progress.getFractionCompleted()}');
      },
    );
    print('Successfully uploaded image: ${result.key}');
    // var dUrl = await getDownloadUrl(result.key);
    return "students/$key";
  } on StorageException catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

Future<String> getDownloadUrl(String key) async {
  try {
    final result = await Amplify.Storage.getUrl(key:key);
    // NOTE: This code is only for demonstration
    // Your debug console may truncate the printed url string
    print('Got URL: ${result.url}');
    return result.url;
  } on StorageException catch (e) {
    print('Error getting download URL: $e');
    throw Exception();
  }
}
