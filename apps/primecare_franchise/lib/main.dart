import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() => runApp(const PrimecareFranchiseApp());

class PrimecareFranchiseApp extends BasePrimecareApp {
  const PrimecareFranchiseApp({super.key})
    : super(appCode: 'primecare_franchise', title: 'Primecare Franchise');
}
