import 'dart:io';

void main() async {
  final auditFile = File('scratch/audit_full.txt');
  if (!auditFile.existsSync()) {
    print('Error: scratch/audit_full.txt not found. Run audit first.');
    return;
  }
  final auditLines = auditFile.readAsLinesSync();

  // Extract screens with drift from audit log
  Set<String> driftScreens = {};
  for (var line in auditLines) {
    if (line.contains('AUDIT WARNING [Component Drift]')) {
      final match = RegExp(r'Component Drift\]: (\w+)').firstMatch(line);
      if (match != null) {
        driftScreens.add(match.group(1)!);
      }
    }
  }

  final registryDir = Directory('apps/primecare_governance/lib/core/governance/registries');
  final files = registryDir.listSync().whereType<File>().where((f) => f.path.endsWith('_registry.dart'));

  int total = 0;
  List<String> doneList = [];
  List<String> partDoneList = [];
  List<String> pendingList = [];

  for (var file in files) {
    final content = file.readAsStringSync();
    final screenMatches = RegExp(r"ScreenMetadata\(([\s\S]*?)\),").allMatches(content);
    
    for (var match in screenMatches) {
      total++;
      final metaBody = match.group(1)!;
      
      final idMatch = RegExp(r"id:\s*'([^']+)'").firstMatch(metaBody);
      final id = idMatch?.group(1) ?? 'Unknown';

      final statusMatch = RegExp(r"lifecycleStatus:\s*LifecycleStatus\.(\w+)").firstMatch(metaBody);
      final status = statusMatch?.group(1) ?? 'backlog';

      final hasDrift = driftScreens.contains(id);

      if (status == 'completed' && !hasDrift) {
        doneList.add(id);
      } else if (status == 'completed' && hasDrift) {
        partDoneList.add(id + ' (Component Drift)');
      } else if (status == 'generation' || status == 'testing' || hasDrift) {
        partDoneList.add(id + ' (Lifecycle: $status)');
      } else {
        pendingList.add(id + ' (Lifecycle: $status)');
      }
    }
  }

  print('# Governance Parity Inventory Report');
  print('\n## Executive Summary');
  print('- **Total Registered Screens:** $total');
  print('- **Done (Absolute Parity):** ${doneList.length}');
  print('- **Part-Done (Architectural Drift):** ${partDoneList.length}');
  print('- **Pending (In-Progress/Backlog):** ${pendingList.length}');

  print('\n## Done (Absolute Parity)');
  doneList.forEach((s) => print('- [x] $s'));

  print('\n## Part-Done (Requires Remediation)');
  partDoneList.forEach((s) => print('- [ ] $s'));

  print('\n## Pending (Scheduled)');
  pendingList.forEach((s) => print('- [ ] $s'));
}
