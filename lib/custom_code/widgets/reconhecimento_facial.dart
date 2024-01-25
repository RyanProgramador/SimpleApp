// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:path_provider/path_provider.dart';

class ReconhecimentoFacial extends StatefulWidget {
  const ReconhecimentoFacial({Key? key, this.width, this.height})
      : super(key: key);

  final double? width;
  final double? height;

  @override
  _ReconhecimentoFacialState createState() => _ReconhecimentoFacialState();
}

class _ReconhecimentoFacialState extends State<ReconhecimentoFacial> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  XFile? _imageFile;
  List<Face> _faces = [];
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _cameraController =
          CameraController(cameras![0], ResolutionPreset.medium);
      await _cameraController!.initialize();
      if (!mounted) return;
      setState(() {});
    } else {
      print("Nenhuma câmera encontrada");
    }
  }

  Future<void> _detectFaces(XFile file) async {
    final inputImage = InputImage.fromFilePath(file.path);
    final faceDetector = FaceDetector(options: FaceDetectorOptions());
    final faces = await faceDetector.processImage(inputImage);
    setState(() {
      _faces = faces;
    });
    await _loadImage(file);
    faceDetector.close();
  }

  Future<void> _loadImage(XFile file) async {
    final data = await file.readAsBytes();
    final image = await decodeImageFromList(data);
    setState(() {
      _image = image;
    });
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      print('Erro: selecione uma câmera primeiro.');
      return;
    }

    if (_cameraController!.value.isTakingPicture) {
      // Uma captura está em progresso; não faça nada.
      return;
    }

    try {
      final XFile file = await _cameraController!.takePicture();
      _detectFaces(file);
      setState(() {
        _imageFile = file;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: _cameraController != null &&
                    _cameraController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController!),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          _image != null && _faces.isNotEmpty
              ? FittedBox(
                  child: SizedBox(
                    width: _image!.width.toDouble(),
                    height: _image!.height.toDouble(),
                    child: CustomPaint(
                      painter: FacePainter(_image!, _faces),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Detectar',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;

  FacePainter(this.image, this.faces);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, Paint());
    for (var face in faces) {
      final rect = face.boundingBox;
      canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
