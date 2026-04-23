// Layer: 01_INFRASTRUCTURE
import 'dart:io';

/// CLI Tool to perform a filesystem-based Governance Audit.
/// This tool identifies gaps between Adapters and UI Intents.
void main() {
  print('🛡️ PrimeCare Platform Governance Audit');
  print('=======================================');

  final projectRoot = Directory.current.path;
  final adaptersPath = '$projectRoot/packages/primecare_adapters/lib/src/models/roles';
  final intentsPath = '$projectRoot/packages/flutter_core/lib/features';

  final adapterFiles = Directory(adaptersPath)
      .listSync(recursive: true)
      .where((f) => f.path.endsWith('_view_model.dart'))
      .map((f) => f.path.split('\\').last.replaceAll('03_V_', '').replaceAll('_view_model.dart', '').replaceAll('_dashboard', ''))
      .toSet();

  final intentFiles = Directory(intentsPath)
      .listSync(recursive: true)
      .where((f) => f.path.endsWith('_intent.dart'))
      .map((f) => f.path.split('\\').last.replaceAll('_intent.dart', '').replaceAll('_dashboard', ''))
      .toSet();

  print('Domain Inventory: ${adapterFiles.length} roles found.');
  print('Governance Realization: ${intentFiles.length} intents found.');

  final realized = adapterFiles.intersection(intentFiles);
  final gaps = adapterFiles.difference(intentFiles);

  print('\n✅ Realized Roles (${realized.length}):');
  for (final role in realized) {
    print('  - $role');
  }

  print('\n⚠️ Governance Gaps (${gaps.length}):');
  for (final role in gaps) {
    print('  - $role');
  }

  final score = (realized.length / adapterFiles.length) * 100;
  print('\n=======================================');
  print('Platform Realization Score: ${score.toStringAsFixed(1)}%');
  print('=======================================');
}
