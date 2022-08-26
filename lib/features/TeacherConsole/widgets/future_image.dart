import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/amplify_storage_s3_service.dart';

class FutureImage extends StatefulWidget {
  String? imageKey;
  FutureImage({key, required this.imageKey});

  @override
  State<FutureImage> createState() => _FutureImageState();
}

class _FutureImageState extends State<FutureImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getDownloadUrl(widget.imageKey!),
      builder: (context, snapshot) {
      
          return CircleAvatar(
            child: CachedNetworkImage(
              imageUrl: snapshot.data!,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const Icon(FontAwesomeIcons.user),
            ),
          );
          // return Image.network(snapshot.data!);
        } else if (snapshot.hasError) {
          return const Text("Error");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
