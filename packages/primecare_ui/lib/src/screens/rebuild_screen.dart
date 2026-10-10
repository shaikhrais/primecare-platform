import 'package:flutter/material.dart';
import 'base_primecare_screen.dart';

class RebuildScreen extends BasePrimecareScreen {
  @override
  final String title;
  const RebuildScreen({super.key, required this.title});
  @override
  Widget buildContent(BuildContext context) => const Center(
    child: Text(
      'UI rebuild in progress. Business workflows are not connected yet.',
    ),
  );
}
