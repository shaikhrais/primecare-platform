import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart' show AuthTransport;
import '../screens/auth_screen.dart';

/// All application shells inherit the same theme and initial screen.
abstract class BasePrimecareApp extends StatelessWidget {
  final String appCode;
  final String title;
  final AuthTransport? authTransport;
  const BasePrimecareApp({
    super.key,
    required this.appCode,
    required this.title,
    this.authTransport,
  });
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: title,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF00695C),
    ),
    home: AuthScreen(title: title, transport: authTransport),
  );
}
