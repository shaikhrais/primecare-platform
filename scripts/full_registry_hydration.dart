
import 'dart:io';

void main() {
  final roleFile = File('packages/flutter_core/lib/registry/platform_role.dart');
  final roleContent = roleFile.readAsStringSync();
  
  // Extract enum values
  final enumMatch = RegExp(r'enum PlatformRole \{(.*?)\}', dotAll: true).firstMatch(roleContent);
  if (enumMatch == null) {
    print('Could not find PlatformRole enum');
    return;
  }
  
  final enumSection = enumMatch.group(1)!.split(';').first;
  final enumValues = enumSection
    .split(',')
    .map((s) => s.trim())
    .where((s) => s.isNotEmpty && !s.startsWith('//') && s != 'unknown')
    .toList();

  print('Total Roles to process: ${enumValues.length}');

  final registryFile = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  final registryContent = registryFile.readAsStringSync();
  
  final buffer = StringBuffer();
  int addedCount = 0;
  
  for (final role in enumValues) {
    final roleId = role.toUpperCase();
    final dashboardId = '${roleId}_DASHBOARD';
    final complianceId = '${roleId}_COMPLIANCE';
    
    // Check if dashboard already exists
    if (!registryContent.contains("'$dashboardId'")) {
      buffer.writeln("    '$dashboardId': ScreenMetadata(");
      buffer.writeln("      id: '$dashboardId',");
      buffer.writeln("      featureName: '${_toDisplayName(role)} Dashboard',");
      buffer.writeln("      title: '${_toDisplayName(role)} Control Center',");
      buffer.writeln("      routePath: '/roles/${_toSnakeCase(role)}/dashboard',");
      buffer.writeln('      icon: Icons.dashboard_customize_outlined,');
      buffer.writeln("      allowedRoles: ['$roleId'],");
      buffer.writeln('      lifecycleStatus: LifecycleStatus.design,');
      buffer.writeln("      sourcePath: 'packages/primecare_ui/lib/src/registry/screen_registry.dart',");
      buffer.writeln('      isVirtual: true,');
      buffer.writeln('    ),');
      addedCount++;
    }
    
    if (!registryContent.contains("'$complianceId'")) {
      buffer.writeln("    '$complianceId': ScreenMetadata(");
      buffer.writeln("      id: '$complianceId',");
      buffer.writeln("      featureName: '${_toDisplayName(role)} Compliance',");
      buffer.writeln("      title: '${_toDisplayName(role)} Governance Portal',");
      buffer.writeln("      routePath: '/roles/${_toSnakeCase(role)}/compliance',");
      buffer.writeln('      icon: Icons.gavel_outlined,');
      buffer.writeln("      allowedRoles: ['$roleId'],");
      buffer.writeln('      lifecycleStatus: LifecycleStatus.design,');
      buffer.writeln("      sourcePath: 'packages/primecare_ui/lib/src/registry/screen_registry.dart',");
      buffer.writeln('      isVirtual: true,');
      buffer.writeln('    ),');
      addedCount++;
    }
  }
  
  if (addedCount > 0) {
    final updatedContent = registryContent.replaceFirst('  };', buffer.toString() + '  };');
    registryFile.writeAsStringSync(updatedContent);
    print('Successfully added $addedCount virtual screens to the registry.');
  } else {
    print('No missing role screens found.');
  }
}

String _toDisplayName(String name) {
  final result = name.replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m[0]}');
  return result[0].toUpperCase() + result.substring(1).trim();
}

String _toSnakeCase(String name) {
  return name.replaceAllMapped(RegExp(r'([A-Z])'), (m) => '_${m[0]!.toLowerCase()}');
}
