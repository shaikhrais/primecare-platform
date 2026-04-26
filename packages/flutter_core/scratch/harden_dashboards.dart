import 'dart:io';

void main() {
  final rootDir = Directory(
    'c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/flutter_core/lib/features',
  );
  final files = rootDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('_dashboard_screen.dart'));

  int cleanedCount = 0;

  for (final file in files) {
    String content = file.readAsStringSync();

    // Pattern to remove "as YYYViewModel" from result.fold
    final castPattern = RegExp(
      r'\(viewModel\) => _buildContent\(context, theme, viewModel as [^)]+\),',
    );

    bool changed = false;

    if (castPattern.hasMatch(content)) {
      content = content.replaceAllMapped(castPattern, (match) {
        return '(viewModel) => _buildContent(context, theme, viewModel),';
      });
      changed = true;
    }

    if (changed) {
      file.writeAsStringSync(content);
      cleanedCount++;
    }
  }

  print('Cleaned $cleanedCount unnecessary casts in dashboards.');
}
