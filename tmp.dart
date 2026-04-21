import 'dart:io';

void main() {
  final dir = Directory('packages/flutter_core/lib/features');
  final list = dir.listSync(recursive: true);
  for (var e in list) {
    if (e is File &&
        (e.path.endsWith('_data.dart') ||
            e.path.endsWith('_state.dart') ||
            e.path.endsWith('_notifier.dart') ||
            e.path.endsWith('01_I_dashboard_providers.dart') ||
            e.path.endsWith('03_D_providers.dart'))) {
      print(e.path.replaceAll('\\', '/'));
    }
  }
}
