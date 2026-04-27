import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/governance/route_registry.dart';

import 'dart:ui';
import 'dart:developer' as dev;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Handle Flutter-level errors
  FlutterError.onError = (details) {
    dev.log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Handle platform-level/async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    dev.log(error.toString(), stackTrace: stack);
    return true;
  };

  runApp(
    const ProviderScope(
      child: PrimeCareApp(),
    ),
  );
}

class PrimeCareApp extends StatelessWidget {
  const PrimeCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PrimeCare Enterprise',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: RouteRegistry.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
