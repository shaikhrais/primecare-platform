import 'dart:io';

void main() async {
  final pendingFilePath = r'C:\Users\Admin2\.gemini\antigravity\brain\70a810e6-ca4a-4160-9177-5b90c9067836\pending_stitch_screens.md';
  final pendingContent = await File(pendingFilePath).readAsString();
  
  final Map<String, String> appRouteToStitchClass = {};
  
  // Parse AppRoutes -> Stitch Class
  // Format: - [ ] BDV-601 : `AppRoutes.regionalManagerOntarioDashboard` -> **`RegionalManagerOntarioDashboardScreenStitch`**
  final exp1 = RegExp(r'- \[ \] [A-Z]{3}-\d{3} : `AppRoutes\.([^`]+)` -> \*\*`([^`]+)`\*\*');
  for (var match in exp1.allMatches(pendingContent)) {
    appRouteToStitchClass['AppRoutes.' + match.group(1)!] = match.group(2)!;
  }
  
  // Parse regular Classes -> Stitch Class (for GLB and others)
  // Format: - [ ] GLB-101 : `SplashScreen` -> **`SplashScreenStitch`**
  final exp2 = RegExp(r'- \[ \] [A-Z]{3}-\d{3} : `([^`]+)` -> \*\*`([^`]+)`\*\*');
  for (var match in exp2.allMatches(pendingContent)) {
    if (!match.group(1)!.startsWith('AppRoutes.')) {
      appRouteToStitchClass[match.group(1)!] = match.group(2)!;
    }
  }

  // Iterate over all routing files in apps
  final appsDir = Directory('apps');
  int replacedCount = 0;
  
  await for (var entity in appsDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('_routes.dart')) {
      var content = await entity.readAsString();
      bool modified = false;

      // Replace path: AppRoutes.X followed by builder
      // Use regex to capture the full block and replace the class
      final builderExp = RegExp(r'(path:\s*(AppRoutes\.[a-zA-Z0-9_]+),\s*builder:\s*\(.*?\)\s*=>\s*const\s*)([a-zA-Z0-9_]+)(\(.*?\))');
      
      content = content.replaceAllMapped(builderExp, (match) {
        final prefix = match.group(1)!;
        final appRouteName = match.group(2)!;
        final oldClassName = match.group(3)!;
        final suffix = match.group(4)!;
        
        final newClassName = appRouteToStitchClass[appRouteName];
        if (newClassName != null && newClassName != oldClassName) {
          modified = true;
          replacedCount++;
          return '$prefix$newClassName$suffix';
        }
        return match.group(0)!;
      });

      // Also replace non-AppRoutes cases if needed 
      // For instance: builder: (context, state) => const SupportDashboard(),
      // Let's do a more generic replacement just in case
      final genericExp = RegExp(r'(builder:\s*\(.*?\)\s*=>\s*const\s*)([a-zA-Z0-9_]+)(\(.*?\))');
      content = content.replaceAllMapped(genericExp, (match) {
        final prefix = match.group(1)!;
        final oldClassName = match.group(2)!;
        final suffix = match.group(3)!;
        
        // This is safe if oldClassName exists in pending (e.g. `SupportDashboard` -> `SupportDashboardScreenStitch`)
        final newClassName = appRouteToStitchClass[oldClassName];
        if (newClassName != null && newClassName != oldClassName) {
          modified = true;
          replacedCount++;
          return '$prefix$newClassName$suffix';
        }
        return match.group(0)!;
      });

      if (modified) {
        await entity.writeAsString(content);
        print('Updated ${entity.path}');
      }
    }
  }
  
  print('Total route builders updated: $replacedCount');
}
