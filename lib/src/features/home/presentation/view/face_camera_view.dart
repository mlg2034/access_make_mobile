import 'dart:io';
import 'package:acces_make_mobile/src/ui_kit/ui_kit.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

class FaceCameraView extends StatefulWidget {
  const FaceCameraView({super.key});

  @override
  State<FaceCameraView> createState() => _FaceCameraViewState();
}

class _FaceCameraViewState extends State<FaceCameraView> {
  FaceCameraController? _faceCameraController;
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _faceCameraController = FaceCameraController(
      autoCapture: true,
      defaultCameraLens: CameraLens.front,
      onCapture: (File? image) {
        setState(() => _capturedImage = image);
      },
      onFaceDetected: (Face? face) {
        print('face detected $face');
      },
    );
  }

  @override
  void dispose() {
    _faceCameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_faceCameraController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SmartFaceCamera(
      showCaptureControl: false,
      showControls: false,
      
      controller: _faceCameraController!,
      message: 'Center your face in the square',
      messageBuilder: (context, face) {
        if (face == null) {
          return Text(
            'Не удается распознать лицо',
            style: AppFonts.displayLarge.copyWith(
              color: AppColors.red.withOpacity(0.5),
            ),
          );
        } else if (!face.wellPositioned) {
          return Text(
            'Лицо не по центру',
            style: AppFonts.displayLarge.copyWith(
              color: AppColors.green.withOpacity(0.5),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
