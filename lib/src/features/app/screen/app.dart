import 'package:acces_make_mobile/core/router/app_router.dart';
import 'package:acces_make_mobile/core/shared/services/permision_service.dart';
import 'package:acces_make_mobile/src/features/app/bloc/multi_bloc_wrapper.dart';
import 'package:flutter/material.dart';

class AccessMakeApp extends StatefulWidget {
  const AccessMakeApp({super.key});

  @override
  State<AccessMakeApp> createState() => _AccessMakeAppState();
}

class _AccessMakeAppState extends State<AccessMakeApp> {
  @override
  void initState() {
    PermisionService.requestPermissions();
    super.initState();
  }

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocWrapper(
      child: MaterialApp.router(
        routerConfig: _router.config(),
      ),
    );
  }
}
