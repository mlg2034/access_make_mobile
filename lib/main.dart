import 'package:acces_make_mobile/core/shared/di/di.dart';
import 'package:acces_make_mobile/src/features/app/screen/app.dart';
import 'package:flutter/material.dart';

 void main() async {
    configureDependencies();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AccessMakeApp());
}
