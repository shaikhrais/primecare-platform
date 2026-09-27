// Governance - Category: test | Purpose: Try to inject a test screen
import 'dart:io';
import 'package:primecare_governance/governance/services/ast_patch_engine.dart';

void main() async {
  print('--- AST Patch Engine Verification ---');

  final projectRoot = Directory.current.path;
  final engine = ASTPatchEngine(projectRoot);

  final registryPath = '$projectRoot/lib/core/governance/screen_registry.dart';
  final file = File(registryPath);

  if (!file.existsSync()) {
    print('Error: Registry file not found at $registryPath');
    return;
  }

  final originalContent = file.readAsStringSync();
  print('Original length: ${originalContent.length}');

  // Try to inject a test screen
  print('Injecting test screen: screen_test_remediation...');

  try {
    await engine.injectScreenConstant(
      'SCREEN_TEST_REMEDIATION',
      'screenTestRemediation',
    );

    final updatedContent = file.readAsStringSync();
    print('Updated length: ${updatedContent.length}');

    if (updatedContent.contains('screenTestRemediation')) {
      print('SUCCESS: Constant injected.');
    } else {
      print('FAILURE: Constant not found in file.');
    }

    if (updatedContent.contains(
      "'SCREEN_TEST_REMEDIATION': const ScreenMetadata(",
    )) {
      print('SUCCESS: Map entry injected.');
    } else {
      print('FAILURE: Map entry not found in file.');
    }

    // Test Update Metadata
    print('Testing metadata update for SCREEN_13...');
    final updateSuccess = await engine.updateScreenMetadata(
      'SCREEN_13',
      isRenderOk: false,
      lifecycleStatus: 'inProgress',
      storyPoints: 13,
    );

    if (updateSuccess) {
      final patchedContent = file.readAsStringSync();
      if (patchedContent.contains('isRenderOk: false') &&
          patchedContent.contains('LifecycleStatus.inProgress')) {
        print('SUCCESS: Metadata updated successfully.');
      } else {
        print('FAILURE: Metadata update succeeded but content mismatch.');
      }
    } else {
      print('FAILURE: Metadata update failed.');
    }

    // Cleanup: Restore original content
    print('Restoring original content...');
    file.writeAsStringSync(originalContent);
    print('Verification complete.');
  } catch (e) {
    print('Error during injection: $e');
  }
}
