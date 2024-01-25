// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:face_camera/face_camera.dart';

class ReconhecimentoFacial extends StatefulWidget {
  const ReconhecimentoFacial({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _ReconhecimentoFacialState createState() => _ReconhecimentoFacialState();
}

class _ReconhecimentoFacialState extends State<ReconhecimentoFacial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartFaceCamera(
        autoCapture:
            false, // Defina como true para captura automática quando um rosto for detectado
        defaultCameraLens: CameraLens.front, // Use a câmera frontal
        message: 'Centralize seu rosto no quadrado', // Mensagem de instrução
        onCapture: (File? image) {
          // Este callback é chamado quando uma foto é capturada
          if (image != null) {
            // Aqui você pode manipular a imagem capturada
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Image.file(image),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Fechar'),
                  ),
                ],
              ),
            );
          }
        },
        onFaceDetected: (DetectedFace? face) {
          // Este callback é chamado quando um rosto é detectado
          // Você pode usar este callback para personalizar ações baseadas na detecção de rosto
        },
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Adicione isso
  await FaceCamera.initialize(); // E isso para inicializar a face_camera

  runApp(MaterialApp(home: ReconhecimentoFacial()));
}
