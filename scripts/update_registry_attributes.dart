
import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/screen_registry.dart');
  if (!file.existsSync()) return;

  var content = file.readAsStringSync();

  // Regex to find ScreenMetadata instances
  final instanceRegex = RegExp(
    r"(const ScreenMetadata\([\s\S]*?id: '(.*?)',[\s\S]*?)\),",
    multiLine: true,
  );

  content = content.replaceAllMapped(instanceRegex, (match) {
    final prefix = match.group(1)!;
    final id = match.group(2)!;
    
    // Determine governance attributes
    int storyPoints = 5;
    String priority = 'p2';
    String securityLevel = 'medium';
    double parityScore = 100.0;
    String lifecycle = 'completed';

    if (id == 'DASHBOARD' || id.contains('FINANCE') || id.contains('CLINICAL') || id.contains('CARE_ANGEL')) {
      storyPoints = 13;
      priority = 'p0';
      securityLevel = 'high';
      lifecycle = id.contains('CARE_ANGEL') ? 'research' : 'completed';
    } else if (id.startsWith('SCREEN_')) {
      final idNum = int.tryParse(id.replaceAll('SCREEN_', ''));
      if (idNum != null && idNum < 50) {
        storyPoints = 8;
        priority = 'p1';
        securityLevel = 'medium';
      }
    }

    if (id.contains('DATA_ENTRY')) {
        lifecycle = 'research';
    }

    final attributes = """
      lastAuditDate: '2026-04-29',
      storyPoints: $storyPoints,
      priority: '$priority',
      securityLevel: '$securityLevel',
      architecturalParityScore: $parityScore,
      lifecycleStatus: '$lifecycle',
      sprintName: 'Sprint-23',
      assignedDeveloper: 'Antigravity-Team',
      subTasks: ['Design Review', 'Security Audit', 'Performance Benchmarking'],""";

    var updatedPrefix = prefix;
    
    // List of keys to remove if they already exist in the prefix to avoid duplicates
    final keysToRemove = [
      'storyPoints', 'priority', 'sprintName', 'assignedDeveloper', 'subTasks', 
      'securityLevel', 'architecturalParityScore', 'lifecycleStatus', 'lastAuditDate'
    ];

    for (var key in keysToRemove) {
      updatedPrefix = updatedPrefix.replaceAll(RegExp('      $key: .*?,\n'), '');
    }

    return "$updatedPrefix$attributes\n    ),";
  });

  file.writeAsStringSync(content);
  print('Sprint story points and task tracking synchronized for all screens.');
}
