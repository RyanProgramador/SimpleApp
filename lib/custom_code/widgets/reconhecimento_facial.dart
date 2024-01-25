// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as mlkit;

class ReconhecimentoFacial extends StatefulWidget {
  final double? width;
  final double? height;

  const ReconhecimentoFacial({Key? key, this.width, this.height})
      : super(key: key);

  @override
  _ReconhecimentoFacialState createState() => _ReconhecimentoFacialState();
}

class _ReconhecimentoFacialState extends State<ReconhecimentoFacial> {
  late final mlkit.CameraController _cameraController;
  late final mlkit.FaceDetector _faceDetector;
  bool _isDetecting = false;
  String _resultado = '';

  @override
  void initState() {
    super.initState();
    _inicializarCamera();
    _faceDetector = mlkit.GoogleMlKit.vision.faceDetector(
      mlkit.FaceDetectorOptions(
          enableContours: false, enableClassification: false),
    );
  }

  void _inicializarCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(camera, ResolutionPreset.medium);
    await _cameraController.initialize();
    setState(() {});

    _cameraController.startImageStream((image) async {
      if (_isDetecting) return;
      _isDetecting = true;
      try {
        // Implemente a lógica de verificação do rosto aqui
        // Por exemplo, compare o rosto detectado com os rostos permitidos
        // e atualize o estado com "Acesso Concedido" ou "Acesso Negado"
        _resultado = "Acesso Negado"; // Placeholder para o resultado
      } finally {
        _isDetecting = false;
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Container();
    }
    return Column(
      children: [
        AspectRatio(
          aspectRatio: _cameraController.value.aspectRatio,
          child: CameraPreview(_cameraController),
        ),
        Text(_resultado),
      ],
    );
  }
}
