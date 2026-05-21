import 'dart:io';

void main() {
  final dir = Directory('packages/primecare_ui/lib/src/features/generated_screens');
  if (!dir.existsSync()) return;

  final files = dir.listSync()
      .whereType<File>()
      .where((f) => f.path.contains('premium_feature_'))
      .toList();

  // Sort files numerically by the number in their name
  files.sort((a, b) {
    final numA = int.parse(RegExp(r'\d+').firstMatch(a.path)!.group(0)!);
    final numB = int.parse(RegExp(r'\d+').firstMatch(b.path)!.group(0)!);
    return numA.compareTo(numB);
  });

  print('Total premium_feature_ files: ${files.length}');
  print('First file: ${files.first.path}');
  print('Last file: ${files.last.path}');
}
