// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:permission_handler/permission_handler.dart' as permiss;
import 'package:flutter_overlay_window/flutter_overlay_window.dart' as overlay;

Future<bool> newCustomAction2Copy() async {
  // Verify if the permission is granted
  final bool? isPermissionGranted =
      await overlay.FlutterOverlayWindow.requestPermission();

  // Return the result based on the permission grant
  // Assuming that null means permission denied
  return isPermissionGranted ?? false;
}
