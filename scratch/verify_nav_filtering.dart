import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_corporate/core/routing/corporate_routes.dart';

void main() {
  final app = CorporateApplication();
  final roles = [PlatformRole.ceo, PlatformRole.coo, PlatformRole.cfo, PlatformRole.cto];
  
  for (final role in roles) {
    print('Checking role: ${role.name}');
    final authorizedModules = app.getAuthorizedModules(role);
    for (final module in authorizedModules) {
      print('  Module: ${module.name}');
      final authorizedScreens = module.screens.where((s) => s.requiredRole == null || s.requiredRole == role).toList();
      for (final screen in authorizedScreens) {
        print('    Screen: ${screen.title}');
      }
    }
    print('---');
  }
}
