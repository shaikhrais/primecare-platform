import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() => runApp(const PrimecareClinicApp());

class PrimecareClinicApp extends BasePrimecareApp {
  const PrimecareClinicApp({super.key})
    : super(appCode: 'primecare_clinic', title: 'Primecare Clinic');
}
