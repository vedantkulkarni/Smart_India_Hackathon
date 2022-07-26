import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class PageContent extends StatefulWidget {
  PageContent({Key? key}) : super(key: key);

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(child: Text("Page Content")),
    );
  }
}