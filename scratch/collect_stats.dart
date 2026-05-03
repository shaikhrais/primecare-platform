import 'dart:io';

void main() async {
  final registryDir = Directory('apps/primecare_governance/lib/core/governance/registries');
  final files = registryDir.listSync().whereType<File>().where((f) => f.path.endsWith('_registry.dart'));

  int total = 0;
  int completed = 0;
  int partDone = 0;
  int pending = 0;

  Map<String, int> statusCounts = {};
  Map<String, int> officeCounts = {};

  for (var file in files) {
    final content = file.readAsStringSync();
    
    // Simple regex parsing for lifecycleStatus and office
    final screenMatches = RegExp(r"ScreenMetadata\(([\s\S]*?)\),").allMatches(content);
    
    for (var match in screenMatches) {
      total++;
      final metaBody = match.group(1)!;
      
      // Extract lifecycleStatus
      final statusMatch = RegExp(r"lifecycleStatus:\s*LifecycleStatus\.(\w+)").firstMatch(metaBody);
      final status = statusMatch?.group(1) ?? 'backlog';
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;

      // Extract implemented vs pending components to determine "Part Done"
      final implementedMatch = RegExp(r"implementedComponents:\s*\[([\s\S]*?)\]").firstMatch(metaBody);
      final implementedStr = implementedMatch?.group(1) ?? "";
      final implementedCount = implementedStr.split(',').where((s) => s.trim().isNotEmpty).length;

      final pendingCompMatch = RegExp(r"pendingComponents:\s*\[([\s\S]*?)\]").firstMatch(metaBody);
      final pendingCompStr = pendingCompMatch?.group(1) ?? "";
      final pendingCompCount = pendingCompStr.split(',').where((s) => s.trim().isNotEmpty).length;

      // Extract office
      final officeMatch = RegExp(r"office:\s*'([^']+)'").firstMatch(metaBody);
      final office = officeMatch?.group(1) ?? 'Unknown';
      officeCounts[office] = (officeCounts[office] ?? 0) + 1;

      if (status == 'completed') {
        completed++;
      } else if (implementedCount > 0) {
        partDone++;
      } else {
        pending++;
      }
    }
  }

  print('--- Platform Governance Statistics ---');
  print('Total Screens: $total');
  print('Done (Completed): $completed');
  print('Part Done (Generation/Testing): $partDone');
  print('Pending (Backlog/Design): $pending');
  print('\n--- Breakdown by Lifecycle Status ---');
  statusCounts.forEach((k, v) => print('$k: $v'));
  print('\n--- Breakdown by Office ---');
  officeCounts.forEach((k, v) => print('$k: $v'));
}
