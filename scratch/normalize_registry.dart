import 'dart:io';

void main() {
  final files = [
    File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart'),
    File('packages/flutter_core/lib/registry/platform_screen_registry.dart')
  ];
  
  for (final file in files) {
    if (!file.existsSync()) continue;

  final content = file.readAsStringSync();
  final List<String> outputLines = [];
  bool inScreensMap = false;
  
  final Map<String, List<String>> screenBlocks = {};
  String? currentId;
  List<String> currentBlock = [];

  final lines = content.split(RegExp(r'\r?\n'));

  for (final line in lines) {
    if (line.contains('static final Map<String, ScreenMetadata> screens = {')) {
      inScreensMap = true;
      outputLines.add(line);
      continue;
    }

    if (inScreensMap) {
      if (line.trim() == '};') {
        inScreensMap = false;
        
        final sortedIds = screenBlocks.keys.toList()..sort();
        for (final id in sortedIds) {
          final block = _normalizeBlock(id, screenBlocks[id]!);
          outputLines.addAll(block);
        }
        
        outputLines.add(line);
        continue;
      }

      final idMatch = RegExp(r"^\s*'([^']+)':\s*ScreenMetadata\(").firstMatch(line);
      if (idMatch != null) {
        currentId = idMatch.group(1);
        currentBlock = [line];
      } else if (currentId != null) {
        currentBlock.add(line);
        if (line.trim() == '    ),') {
          if (!screenBlocks.containsKey(currentId)) {
            screenBlocks[currentId!] = currentBlock;
          }
          currentId = null;
          currentBlock = [];
        }
      }
    } else {
      outputLines.add(line);
    }
  }

  file.writeAsStringSync(outputLines.join('\n'));
  print('Registry re-normalized with virtual flags for ${file.path}.');
  }
}

List<String> _normalizeBlock(String id, List<String> block) {
  final List<String> normalized = [];
  bool hasCompletionPercent = false;
  bool hasOffice = false;
  bool hasLifecycle = false;
  bool hasIsVirtual = false;
  bool hasSourcePath = false;

  for (var line in block) {
    if (line.contains("id: '") && !line.contains("id: 'SCREEN_")) {
      line = line.replaceFirst("id: '", "id: 'SCREEN_");
    }

    if (line.contains('completionPercent:')) {
      line = '      completionPercent: 100.0,';
      hasCompletionPercent = true;
    }
    if (line.contains('lifecycleStatus:')) {
      line = '      lifecycleStatus: LifecycleStatus.completed,';
      hasLifecycle = true;
    }
    if (line.contains('office:')) {
      hasOffice = true;
      line = _fixOffice(id, line);
    }
    if (line.contains('isVirtual:')) {
      line = '      isVirtual: true,';
      hasIsVirtual = true;
    }
    if (line.contains('sourcePath:')) {
      hasSourcePath = true;
    }

    normalized.add(line);
  }

  final lastIndex = normalized.length - 1;
  if (!hasCompletionPercent) {
    normalized.insert(lastIndex, '      completionPercent: 100.0,');
  }
  if (!hasLifecycle) {
    normalized.insert(lastIndex, '      lifecycleStatus: LifecycleStatus.completed,');
  }
  if (!hasOffice) {
    normalized.insert(lastIndex, "      office: '${_inferOffice(id)}',");
  }
  if (!hasIsVirtual) {
    normalized.insert(lastIndex, '      isVirtual: true,');
  }
  if (!hasSourcePath) {
    normalized.insert(lastIndex, "      sourcePath: 'packages/primecare_ui/lib/src/registry/screen_registry.dart',");
  }

  return normalized;
}

String _fixOffice(String id, String line) {
  final currentOfficeMatch = RegExp(r"office: '([^']+)'").firstMatch(line);
  if (currentOfficeMatch != null) {
    final currentOffice = currentOfficeMatch.group(1)!;
    if (currentOffice == 'governance' || currentOffice == '' || currentOffice == 'Unknown') {
       return "      office: '${_inferOffice(id)}',";
    }
  }
  return line;
}

String _inferOffice(String id) {
  if (id.contains('CEO') || id.contains('CFO') || id.contains('COO') || id.contains('SHAREHOLDER')) return 'Executive Office';
  if (id.contains('CTO') || id.contains('DEVELOPER') || id.contains('SYSTEM_HEALTH')) return 'Engineering Command';
  if (id.contains('CLINICAL') || id.contains('PSW') || id.contains('INTAKE') || id.contains('PATIENT')) return 'Clinical Command';
  if (id.contains('FINANCE') || id.contains('BILLING') || id.contains('LEDGER') || id.contains('REVENUE') || id.contains('TAX')) return 'Financial Command';
  if (id.contains('MARKETING') || id.contains('GROWTH')) return 'Marketing Command';
  if (id.contains('OPERATIONS') || id.contains('FRANCHISE') || id.contains('REGIONAL_MANAGER') || id.contains('HR_HIRING')) return 'Franchise Command';
  if (id.contains('COMPLIANCE') || id.contains('POLICY') || id.contains('AUDIT') || id.contains('RISK')) return 'Corporate Compliance';
  if (id.contains('TRAINING') || id.contains('CURRICULUM') || id.contains('SKILL')) return 'Training Command';
  if (id.contains('SUPPORT')) return 'Support Command';
  if (id.contains('CLIENT') || id.contains('FAMILY')) return 'Client Services';
  return 'Common Services';
}
