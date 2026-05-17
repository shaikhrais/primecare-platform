import 'dart:io';

void main() {
  final file = File('packages/flutter_core/lib/config/navigation_registry.dart');
  final lines = file.readAsLinesSync();
  
  var markdown = '| Role | Total Items | Items | Routes |\n';
  markdown += '|---|---|---|---|\n';
  
  String? currentRole;
  List<String> items = [];
  List<String> routes = [];
  
  for (var line in lines) {
    if (line.contains(''': [''') && !line.contains('_roleMenus')) {
      currentRole = line.split(''': [''')[0].replaceAll('"', '').trim();
      currentRole = currentRole.replaceAll("'", '');
      items = [];
      routes = [];
    } else if (currentRole != null && line.contains('label:')) {
      var label = line.split('label: ')[1].replaceAll('"', '').replaceAll(',', '').replaceAll("'", '').trim();
      label = label.replaceAll('navigation.items.navigation.items.', '').replaceAll('navigation.items.', '');
      items.add(label);
    } else if (currentRole != null && line.contains('route:')) {
      var route = line.split('route: ')[1].replaceAll(',', '').replaceAll("'", '').trim();
      routes.add('`' + route + '`');
    } else if (currentRole != null && line.contains('],')) {
      var itemsStr = items.join(', ');
      var routesStr = routes.join('<br>');
      markdown += '| **$currentRole** | ${items.length} | $itemsStr | $routesStr |\n';
      currentRole = null;
    }
  }
  
  File('C:/Users/Admin2/.gemini/antigravity/brain/595beb29-8761-4b81-ade6-7050ab97fddc/primecare_role_sidebar_table.md').writeAsStringSync(markdown);
  print('Done generating table');
}
