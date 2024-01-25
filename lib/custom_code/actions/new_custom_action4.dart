// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_overlay_window/flutter_overlay_window.dart' as overlay;

Future<void> newCustomAction4(BuildContext context) async {
  int height = overlay.WindowSize.fullCover;
  int width = overlay.WindowSize.matchParent;
  overlay.OverlayAlignment alignment = overlay.OverlayAlignment.center;

  await overlay.FlutterOverlayWindow.showOverlay(
    height: height,
    width: width,
    alignment: alignment,
  );
}
