import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  ScreenRegistry.bootstrap();
  
  final Map<String, dynamic> output = {};
  
  // We want to map role name (e.g. 'ceo', 'cfo', 'clinicalDirector') to its route and labels.
  for (final role in PlatformRole.values) {
    if (role == PlatformRole.unknown) continue;
    
    final intent = GovernanceRegistry.getIntentByRole(role.nameSnake);
    if (intent != null) {
      // Find matching screen in ScreenRegistry by role
      final screenRoute = ScreenRegistry.registryJson.values.firstWhere(
        (json) => json['path'].toString().contains('/roles/${role.nameSnake}/dashboard') || json['path'].toString().contains('/roles/${role.nameSnake}'),
        orElse: () => <String, dynamic>{},
      );
      
      String route = '';
      List<String> labels = [];
      
      if (screenRoute.isNotEmpty) {
        route = screenRoute['path'] as String;
        // The components might not be in registryJson. Let's get them from getScreen
        final screen = ScreenRegistry.getScreen(route);
        if (screen != null) {
          labels = screen.componentLabels;
        }
      }
      
      if (route.isNotEmpty || labels.isNotEmpty) {
        output[role.nameSnake] = {
          'intentClass': intent.runtimeType.toString(),
          'route': route,
          'labels': labels,
          'title': intent.title,
        };
      }
    }
  }
  
  File('scratch/intent_mappings.json').writeAsStringSync(jsonEncode(output));
  print('Wrote mappings to scratch/intent_mappings.json');
}
