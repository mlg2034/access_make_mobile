import 'dart:io';

import 'package:acces_make_mobile/src/features/home/presentation/view/face_painter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_mesh_detection/google_mlkit_face_mesh_detection.dart';

import 'detector_view.dart';

class FaceMeshDetectorView extends StatefulWidget {
  const FaceMeshDetectorView({super.key});

  @override
  State<FaceMeshDetectorView> createState() => _FaceMeshDetectorViewState();
}

class _FaceMeshDetectorViewState extends State<FaceMeshDetectorView> {
  final FaceMeshDetector _meshDetector =
      FaceMeshDetector(option: FaceMeshDetectorOptions.faceMesh);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  @override
  void dispose() {
    _canProcess = false;
    _meshDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return DetectorView(
      title: 'Face Mesh Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
   
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = 'proces image $inputImage';
    });
    final meshes = await _meshDetector.processImage(inputImage);
    print('meshes $meshes');
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceMeshDetectorPainter(
        meshes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      print('Face meshes not found: ${meshes.length}\n\n');

      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Face meshes found: ${meshes.length}\n\n';
      for (final mesh in meshes) {
        text += 'face: ${mesh.boundingBox}\n\n';
      }
      _text = text;
      _customPaint = null;
      print('Face meshes found: ${meshes.length}\n\n');

    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}