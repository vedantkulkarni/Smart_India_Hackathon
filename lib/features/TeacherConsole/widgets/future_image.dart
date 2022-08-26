import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/amplify_storage_s3_service.dart';

import '../../../core/constants.dart';

class FutureImage extends StatefulWidget {
  String? imageKey;
  FutureImage({key, required this.imageKey});

  @override
  State<FutureImage> createState() => _FutureImageState();
}

class _FutureImageState extends State<FutureImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageKey == null) {
      return Container(
        // height: 40.h,
        // width: 40.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: const Icon(
          FontAwesomeIcons.user,
          color: whiteColor,
        ),
        alignment: Alignment.center,
      );
    }
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
