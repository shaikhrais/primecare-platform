import 'dart:io';

void main() {
  final file = File('packages/flutter_core/lib/config/navigation_registry.dart');
  final lines = file.readAsLinesSync();
  
  Map<String, int> roleItemCounts = {};
  Map<String, Set<String>> appUniqueItems = {
    'Corporate App': {},
    'Franchise App': {},
    'Clinical App': {},
    'Client App': {},
    'Support App': {}
  };
  
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
      routes.add(route);
    } else if (currentRole != null && line.contains('],')) {
      roleItemCounts[currentRole] = items.length;
      
      // Determine app based on routes
      String appName = 'Corporate App'; // Default
      int franch = 0, clin = 0, client = 0, supp = 0;
      
      for (var r in routes) {
        if (r.contains('CorporateRoutes') || r.contains('/offices/corporate')) {
          // Handled or ignored
        }
        if (r.contains('FranchiseRoutes') || r.contains('/offices/franchise')) franch++;
        if (r.contains('ClinicalRoutes') || r.contains('clinic')) clin++;
        if (r.contains('ClientRoutes')) client++;
        if (r.contains('/offices/support')) supp++;
      }
      
      if (supp > 0) appName = 'Support App';
      else if (client > 0) appName = 'Client App';
      else if (clin > 0) appName = 'Clinical App';
      else if (franch > 0) appName = 'Franchise App';
      else appName = 'Corporate App';
      
      for (var item in items) {
        appUniqueItems[appName]!.add(item);
      }
      
      currentRole = null;
    }
  }
  
  var appTable = '| App | Unique Sidebar Items Count |\n|---|---|\n';
  appUniqueItems.forEach((app, items) {
    appTable += '| **$app** | ${items.length} |\n';
  });
  
  var roleTable = '| Role | Sidebar Items Count |\n|---|---|\n';
  roleItemCounts.forEach((role, count) {
    roleTable += '| **$role** | $count |\n';
  });
  
  File('C:/Users/Admin2/.gemini/antigravity/brain/595beb29-8761-4b81-ade6-7050ab97fddc/counts.md').writeAsStringSync(appTable + '\n\n' + roleTable);
}
