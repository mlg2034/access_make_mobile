import 'package:acces_make_mobile/src/features/home/presentation/view/detector_view.dart';
import 'package:acces_make_mobile/src/features/home/presentation/widget/face_mesh_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';

class FeshMeshDetectorView extends StatefulWidget {
  const FeshMeshDetectorView({super.key});

  @override
  State<FeshMeshDetectorView> createState() => _FeshMeshDetectorViewState();
}

class _FeshMeshDetectorViewState extends State<FeshMeshDetectorView> {
  late FaceMeshDetector _meshDetector;

  bool _canProcess = true;
  bool _isBusy = false;

  CustomPaint? _customPaint;

  String? _text;
  var _cameralensDirection = CameraLensDirection.front;

  @override
  void initState() {
    _meshDetector = FaceMeshDetector(
      option: FaceMeshDetectorOptions.faceMesh,
    );
    super.initState();
  }

  @override
  void dispose() {
    _canProcess = false;

    _meshDetector.close();
    super.dispose();
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final meshes = await _meshDetector.processImage(inputImage);
     setState(() {
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceMeshDetectorPainter(
        meshes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameralensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }
  });
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      customPaint: _customPaint,
      onImage: _processImage,
      initialCameraLensDirection: _cameralensDirection,
      onCameraLensDirectionChanged: (value) => _cameralensDirection = value,
    );
  }
}
