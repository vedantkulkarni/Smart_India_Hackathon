import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/amplify_storage_s3_service.dart';

class FutureImage extends StatefulWidget {
  String imageKey;
  FutureImage({key, required this.imageKey});

  @override
  State<FutureImage> createState() => _FutureImageState();
}

class _FutureImageState extends State<FutureImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getDownloadUrl(widget.imageKey),
      builder: (context, snapshot) => CachedNetworkImage(imageUrl: snapshot.data!),
    );
  }
}
