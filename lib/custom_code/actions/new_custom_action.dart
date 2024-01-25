// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future newCustomAction() async {
  @pragma("vm:entry-point")
  void overlayPopUp() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Text('Hello Pub.dev!'),
    ));
  }
}
