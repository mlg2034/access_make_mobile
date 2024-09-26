import 'dart:io';

import 'package:acces_make_mobile/core/shared/services/permision_service.dart';
import 'package:acces_make_mobile/src/features/home/presentation/view/face_painter.dart';
import 'package:acces_make_mobile/src/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;

class FaceDetectionView extends StatefulWidget {
  const FaceDetectionView({super.key});

  @override
  _FaceDetectionViewState createState() => _FaceDetectionViewState();
}

class _FaceDetectionViewState extends State<FaceDetectionView> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  late FaceDetector _faceDetector;
  bool _isProcessing = false;

  late ValueNotifier<List<Face>> _faceListController;

  int _cameraIndex = -1;
  static List<CameraDescription> _cameras = [];

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  @override
  void initState() {
    super.initState();
 _faceListController = ValueNotifier([]);
    _initializeFaceDetector();
    _initializeControllerFuture = _initializeCamera();
  }

  void _initializeFaceDetector() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        enableTracking: true,
      ),
    );
  }

  Future<void> _initializeCamera() async {
    final bool isPermissionGranted = await PermissionService.requestCameraPermission();
    if (!isPermissionGranted) {
      return;
    }

    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    if (_cameras.isEmpty) {
      print('No cameras available');
      return;
    }

    _cameraIndex = _cameras.indexWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    if (_cameraIndex == -1) {
      _cameraIndex = 0;
    }

    final selectedCamera = _cameras[_cameraIndex];

    _controller = CameraController(
      selectedCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );

    await _controller?.initialize();

    // Start image stream for face detection
    _controller?.startImageStream((CameraImage image) async {
      if (_isProcessing) return;
      _isProcessing = true;

      final inputImage = _inputImageFromCameraImage(image);
      print('the image $image');
      if (inputImage != null) {
        await _processFaceDetection(inputImage);
      }

      _isProcessing = false;
    });

    if (mounted) {
      setState(() {});
    }
  }

  // Convert CameraImage to InputImage for MLKit
  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;
    var rotationCompensation = _orientations[_controller!.value.deviceOrientation];
    if (rotationCompensation == null) return null;
    if (camera.lensDirection == CameraLensDirection.front) {
      rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
    } else {
      rotationCompensation = (sensorOrientation - rotationCompensation + 360) % 360;
    }
    rotation = InputImageRotationValue.fromRawValue(rotationCompensation);

    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);

    if (format == null || (Platform.isAndroid && format != InputImageFormat.nv21) || (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  // Process face detection using Google MLKit
  Future<void> _processFaceDetection(InputImage inputImage) async {
    try {
      final faces = await _faceDetector.processImage(inputImage);
      print('the face $faces');
      setState(() {
        _faceListController.value = faces;
      });
    } catch (e) {
      print('Error detecting faces: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (_controller == null || !(_controller?.value.isInitialized ?? false)) {
            return const Center(
              child: AppLoader(),
            );
          } else {
            return ValueListenableBuilder(
              valueListenable: _faceListController,
              builder: (context , faces , child) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CameraPreview (_controller!),
                    faces.isNotEmpty
                        ? CustomPaint(
                            painter: FacePainter(
                              faces: faces,
                              imageSize: Size(
                                _controller!.value.previewSize!.height,
                                _controller!.value.previewSize!.width,
                              ),
                            ),
                          )
                        : Text(
                            'Не удается определить лицо $faces',
                            style: AppFonts.displayMedium.copyWith(color: AppColors.red),
                          ),
                  ],
                );
              }
            );
          }
        },
      ),
    );
  }
}
