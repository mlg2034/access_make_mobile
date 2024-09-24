import 'dart:io';

import 'package:acces_make_mobile/src/ui_kit/ui_kit.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/cupertino.dart';

class FaceCameraView extends StatefulWidget {
  const FaceCameraView({super.key});

  @override
  State<FaceCameraView> createState() => _FaceCameraViewState();
}

class _FaceCameraViewState extends State<FaceCameraView> {
  late FaceCameraController _faceCameraController;
  File? _capturedImage;

  @override
  void initState() {
    _faceCameraController = FaceCameraController(
      defaultCameraLens: CameraLens.front,
      autoCapture: true,
      onCapture: (File? image) {
        setState(() => _capturedImage = image);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _faceCameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SmartFaceCamera(
          controller: _faceCameraController,
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
            return SizedBox.fromSize();
          },
        ),
      ],
    );
  }
}
