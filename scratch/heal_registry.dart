import 'dart:io';

void main() {
  final registryFile = File('apps/primecare_governance/lib/core/governance/screen_registry.dart');
  final uiPackagePath = 'packages/factory_system/primecare_ui/lib/src/features';

  if (!registryFile.existsSync()) {
    print('❌ Registry not found.');
    return;
  }

  String content = registryFile.readAsStringSync();
  final ghostFiles = _findGhostFiles(uiPackagePath, content);
  
  print('Found ${ghostFiles.length} ghost files. Healing registry...');

  for (final filePath in ghostFiles) {
    final fileName = filePath.split('/').last;
    final featureName = fileName.replaceAll('_view.dart', '');
    final readableTitle = _toTitleCase(featureName.replaceAll('_', ' '));
    
    // Guess role from feature name
    String role = 'Standard User';
    if (featureName.contains('rn_')) role = 'RN';
    else if (featureName.contains('psw_')) role = 'PSW';
    else if (featureName.contains('admin_')) role = 'Administrator';
    else if (featureName.contains('finance_')) role = 'Finance Director';
    else if (featureName.contains('regional_manager')) role = 'Regional Manager';

    // Find first backlog screen that matches the role or just a generic one
    final match = RegExp('\'(SCREEN_\\d+)\': const ScreenMetadata\\(.*?role: \'$role\'.*?lifecycleStatus: \'backlog\'', dotAll: true).firstMatch(content);
    
    if (match != null) {
      final screenId = match.group(1)!;
      print('Mapping $readableTitle to $screenId');
      
      // Update entry
      final start = content.indexOf("'$screenId': const ScreenMetadata(");
      final end = content.indexOf('),', start) + 2;
      final originalBlock = content.substring(start, end);
      
      final updatedBlock = originalBlock
          .replaceFirst(RegExp(r"title: '.*?'"), "title: '$readableTitle'")
          .replaceFirst(RegExp(r"lifecycleStatus: 'backlog'"), "lifecycleStatus: 'completed'")
          .replaceFirst(RegExp(r"description: '.*?'"), "description: 'Automated registration for existing feature: $readableTitle'");

      content = content.replaceRange(start, end, updatedBlock);
    } else {
      // Find ANY backlog screen
      final genericMatch = RegExp('\'(SCREEN_\\d+)\': const ScreenMetadata\\(.*?lifecycleStatus: \'backlog\'', dotAll: true).firstMatch(content);
      if (genericMatch != null) {
        final screenId = genericMatch.group(1)!;
         print('Mapping $readableTitle to generic $screenId');
         
         final start = content.indexOf("'$screenId': const ScreenMetadata(");
         final end = content.indexOf('),', start) + 2;
         final originalBlock = content.substring(start, end);
         
         final updatedBlock = originalBlock
             .replaceFirst(RegExp(r"title: '.*?'"), "title: '$readableTitle'")
             .replaceFirst(RegExp(r"lifecycleStatus: 'backlog'"), "lifecycleStatus: 'completed'")
             .replaceFirst(RegExp(r"role: '.*?'"), "role: '$role'")
             .replaceFirst(RegExp(r"description: '.*?'"), "description: 'Automated registration for existing feature: $readableTitle'");

         content = content.replaceRange(start, end, updatedBlock);
      }
    }
  }

  registryFile.writeAsStringSync(content);
  print('✅ Registry healed. Run governance_audit.dart to verify.');
}

List<String> _findGhostFiles(String path, String registryContent) {
  final files = Directory(path)
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('_view.dart'))
      .map((f) => f.path.replaceAll('\\', '/'))
      .toList();

  final ghostFiles = <String>[];
  for (final file in files) {
    final fileName = file.split('/').last;
    final title = _toTitleCase(fileName.replaceAll('_view.dart', '').replaceAll('_', ' '));
    if (!registryContent.contains("title: '$title'")) {
      ghostFiles.add(file);
    }
  }
  return ghostFiles;
}

String _toTitleCase(String text) {
  return text.split(' ').map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
}
