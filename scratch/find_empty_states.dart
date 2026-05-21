import 'dart:io';

void main() {
  final dir = Directory('packages/primecare_ui/lib/src/features/generated_screens');
  if (!dir.existsSync()) {
    print('Directory not found');
    return;
  }

  final files = dir.listSync().whereType<File>().toList();
  print('Total files in generated_screens: ${files.length}');

  final List<String> emptyStateFiles = [];
  final List<String> premiumFeatureFiles = [];

  for (final file in files) {
    final content = file.readAsStringSync();
    if (content.contains('EmptyState(')) {
      emptyStateFiles.add(file.path.split('/').last.split('\\').last);
    } else {
      premiumFeatureFiles.add(file.path.split('/').last.split('\\').last);
    }
  }

  print('\n--- EmptyState Placeholder Screens (${emptyStateFiles.length}) ---');
  emptyStateFiles.sort();
  for (final name in emptyStateFiles) {
    print(' - $name');
  }

  print('\n--- Fully Functional Premium/Custom Screens (${premiumFeatureFiles.length}) ---');
  premiumFeatureFiles.sort();
  print('Total premium/custom screens: ${premiumFeatureFiles.length}');
}
