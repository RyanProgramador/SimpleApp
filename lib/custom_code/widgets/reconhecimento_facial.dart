// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:camera_process/camera_process.dart' as camera_proc;

class ReconhecimentoFacial extends StatefulWidget {
  const ReconhecimentoFacial({Key? key, this.width, this.height})
      : super(key: key);

  final double? width;
  final double? height;

  @override
  _ReconhecimentoFacialState createState() => _ReconhecimentoFacialState();
}

class _ReconhecimentoFacialState extends State<ReconhecimentoFacial> {
  late camera_proc.CameraProcessController _cameraProcessController;

  @override
  void initState() {
    super.initState();
    _initializeCameraProcess();
  }

  void _initializeCameraProcess() {
    _cameraProcessController = camera_proc.CameraProcessController(
      options: camera_proc.CameraProcessOptions(
        detectionTypes: {camera_proc.DetectionType.faces},
        enableAudio: false,
      ),
    );

    _cameraProcessController.initialize().then((_) {
      if (mounted) {
        setState(() {
          // O controlador está pronto para ser usado
        });
      }
    });
  }

  @override
  void dispose() {
    _cameraProcessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reconhecimento Facial'),
      ),
      body: _cameraProcessController.value.isInitialized
          ? camera_proc.CameraProcessPreview(
              controller: _cameraProcessController,
              onFaceDetected: (faces) {
                // Este callback é chamado quando um ou mais rostos são detectados
                // Você pode usar os dados dos rostos aqui
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
