import 'package:acces_make_mobile/core/shared/di/di.dart';
import 'package:acces_make_mobile/src/features/app/bloc/app_bloc_observer.dart';
import 'package:acces_make_mobile/src/features/app/screen/app.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  configureDependencies();
  Bloc.observer = GlobalBlocObserver();
  await FaceCamera.initialize(); 

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AccessMakeApp());
}
