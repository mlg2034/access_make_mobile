import 'package:acces_make_mobile/src/features/home/presentation/view/camera_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

class DetectorView extends StatelessWidget {
  const DetectorView({
    super.key,
    this.customPaint,
    this.onCameraFeedReady,
    this.onCameraLensDirectionChanged,
    required this.initialCameraLensDirection,
    required this.onImage,
  });
  final CustomPaint? customPaint;
  final Function()? onCameraFeedReady;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;
  final Function(InputImage inputImage) onImage;

  @override
  Widget build(BuildContext context) {
    return CameraView(
      customPaint: customPaint,
      onImage: onImage,
      onCameraFeedReady: onCameraFeedReady,
      initialCameraLensDirection: initialCameraLensDirection,
      onCameraLensDirectionChanged: onCameraLensDirectionChanged,
    );
  }
}
