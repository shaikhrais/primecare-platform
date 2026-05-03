import 'dart:io';

void main() {
  var dir = Directory(
    'packages/factory_system/primecare_ui/lib/src/shared/src',
  );
  var files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('adapter.dart'));
  for (var file in files) {
    var content = file.readAsStringSync();
    if (content.contains('InsightsProvider =') ||
        content.contains('insightsProvider =')) {
      if (!content.contains('AdapterModulationGovernor.canExecute')) {
        print(file.path);
      }
    }
  }
}
