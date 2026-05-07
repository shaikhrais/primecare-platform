import 'dart:convert';
import 'package:primecare_governance/core/governance/screen_registry.dart';

void main() {
  final registry = ScreenRegistry();
  final screens = registry.allScreens;

  print('--- Governance Registry Verification ---');
  print('Total Hydrated Screens: ${screens.length}');

  // Verify Admin Infrastructure (The 100-293 range)
  final adminScreens = screens.values
      .where((s) => s.path.contains('infrastructure'))
      .toList();
  print('Admin Infrastructure Screens: ${adminScreens.length}');

  if (adminScreens.length > 50) {
    print('SUCCESS: Admin Infrastructure auxiliary views are hydrated.');
  } else {
    print('WARNING: Admin Infrastructure hydration count seems low.');
  }

  // Verify core domains
  final domains = [
    'clinical',
    'operational',
    'corporate',
    'marketing',
    'franchise',
    'workflow',
    'admin',
    'portal',
  ];
  for (final domain in domains) {
    final count = screens.values
        .where((s) => s.id.toLowerCase().contains(domain))
        .length;
    print(' - Domain [$domain]: $count screens');
  }

  print('---------------------------------------');
}
