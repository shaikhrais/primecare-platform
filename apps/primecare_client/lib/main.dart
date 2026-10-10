import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() => runApp(const PrimecareClientApp());

class PrimecareClientApp extends BasePrimecareApp {
  const PrimecareClientApp({super.key})
    : super(appCode: 'primecare_client', title: 'Primecare Client');
}
