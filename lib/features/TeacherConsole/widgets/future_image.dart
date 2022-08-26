import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

        child: const Icon(
          FontAwesomeIcons.user,
        ),
        alignment: Alignment.center,
      );
    }
    return CachedNetworkImage(
      imageUrl: widget.imageKey!,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(FontAwesomeIcons.user),
      imageBuilder: (context, imageProvider) => Container(
        // width: 40.0,
        // height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
    // return Image.network(snapshot.data!);

    //  else if (snapshot.hasError) {
    //   return const Text("Error");
    // }
    // retur const CircularProgressIndicator();
  }
}
