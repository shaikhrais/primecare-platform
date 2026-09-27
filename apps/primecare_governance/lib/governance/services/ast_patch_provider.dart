// Governance - Category: controller | Purpose: In a real scenario, we might detect the project root or use a config. For this environment, we know the path.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'ast_patch_engine.dart';

final astPatchEngineProvider = Provider<ASTPatchEngine>((ref) {
  // In a real scenario, we might detect the project root or use a config.
  // For this environment, we know the path.
  final projectRoot = Directory.current.path;
  return ASTPatchEngine(projectRoot);
});
