import 'dart:io';

void main() {
  var dir = Directory('packages/primecare_adapters/lib/src');
  var files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('adapter.dart'));
  for (var file in files) {
    var content = file.readAsStringSync();
    if (content.contains('MetricsProvider =') ||
        content.contains('metricsProvider =')) {
      if (!content.contains('PlatformSubsystem.metrics')) {
        print(file.path);
      }
    }
  }
}
