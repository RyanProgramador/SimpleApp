// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_overlay_apps/flutter_overlay_apps.dart' as fftest;

Future<bool?> newCustomAction3Copy(BuildContext context) async {
  int height = fftest.overlaySizeFill;
  int width = fftest.overlaySizeFill;
  bool closeOnBackButton = true;
  fftest.OverlayAlignment alignment = fftest.OverlayAlignment.center;

  final bool? _res = await fftest.FlutterOverlayApps.showOverlay(
    height: height,
    width: width,
    closeOnBackButton: closeOnBackButton,
    alignment: alignment,
  );

  return _res;
}
