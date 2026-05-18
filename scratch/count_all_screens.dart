import 'dart:io';

void main() {
  final dir = Directory('packages/flutter_core/lib/routes/groups');
  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  int totalRoutes = 0;
  for (final file in files) {
    final content = file.readAsStringSync();
    final routeRegex = RegExp(r"static const String \w+\s*=\s*'(/[^']+)'");
    final routes = routeRegex.allMatches(content);
    print('${file.path.split('/').last}: ${routes.length} routes');
    totalRoutes += routes.length;
  }
  print('Total screens: $totalRoutes');
}
