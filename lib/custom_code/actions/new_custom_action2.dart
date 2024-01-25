// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:permission_handler/permission_handler.dart' as permiss;

Future<bool> newCustomAction2() async {
  // Solicitar permissão
  var status = await permiss.Permission.systemAlertWindow.request();

  // Verificar se a permissão foi concedida
  bool isPermissionGranted = status == permiss.PermissionStatus.granted;

  // Retornar o resultado com base na concessão de permissão
  return isPermissionGranted;
}
