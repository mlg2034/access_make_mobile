import 'package:acces_make_mobile/core/shared/di/di.dart';
import 'package:acces_make_mobile/src/features/app/bloc/app_bloc_observer.dart';
import 'package:acces_make_mobile/src/features/app/screen/app.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = GlobalBlocObserver();
  await FaceCamera.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AccessMakeApp());
}
