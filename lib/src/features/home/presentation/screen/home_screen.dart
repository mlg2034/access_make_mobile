import 'package:acces_make_mobile/src/features/home/presentation/view/camera_view.dart';
import 'package:auto_route/annotations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../ui_kit/ui_kit.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere((camera)=>camera.lensDirection==CameraLensDirection.front);

    _cameraController = CameraController(camera, ResolutionPreset.medium);
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: _initializeControllerFuture == null
            ? const Center(child: CupertinoActivityIndicator(color: Colors.grey))
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: FutureBuilder(
                  future: _initializeControllerFuture,
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.done) {
                      return CameraView(
                        cameraController: _cameraController,
                      );
                    } else {
                      return const AppLoader();
                    }
                  },
                ),
              ),
      ),
    );
  }
}