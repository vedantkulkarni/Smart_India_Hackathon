import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

class PlatformChecker
{


  bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}
}