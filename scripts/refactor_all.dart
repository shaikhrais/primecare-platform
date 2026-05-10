import 'dart:convert';
import 'dart:io';

// Configuration for Governance Integration
const String pageInventoryPath = '.agents/governance/page_inventory.yaml';
const String intentRegisterPath = '.agents/governance/intent_register.yaml';

// --- Governance Loader ---

class GovernanceData {
  final Map<String, String> pageToIntents = {};
  final Map<String, String> intentToGoals = {};
  final Map<String, String> routeIntents = {};

  Future<void> load() async {
    try {
      final inventoryFile = File(pageInventoryPath);
      if (await inventoryFile.exists()) {
        final content = await inventoryFile.readAsString();
        _parseInventory(content);
      }

      final registerFile = File(intentRegisterPath);
      if (await registerFile.exists()) {
        final content = await registerFile.readAsString();
        _parseRegister(content);
      }
    } catch (e) {
      print('Warning: Governance data could not be loaded: $e');
    }
  }

  void _parseInventory(String content) {
    final blocks = content.split(RegExp(r'\n\s*-\s+id:'));
    for (var block in blocks.skip(1)) {
      final idMatch = RegExp(r'^"([^"]+)"').firstMatch(block.trim()) ??
          RegExp(r'^\s*([^:\n\s]+)').firstMatch(block);
      String? id = idMatch?.group(1);

      final routeMatch = RegExp(r'route:\s*"([^"]+)"').firstMatch(block);
      final intentMatch = RegExp(
        r'linked_intent:\s*"([^"]+)"',
      ).firstMatch(block);

      if (id != null && intentMatch != null)
        pageToIntents[id] = intentMatch.group(1)!;
      if (routeMatch != null && intentMatch != null) {
        final route = routeMatch.group(1)!;
        if (route.startsWith('/offices/')) {
          final parts = route.split('/');
          if (parts.length >= 6) {
            final office = parts[2];
            final role = parts[4];
            final path = parts.sublist(5).join('.');
            routeIntents['$office.$role.$path'] = intentMatch.group(1)!;
          }
        }
      }
    }
  }

  void _parseRegister(String content) {
    final blocks = content.split(RegExp(r'\n\s*-\s+id:'));
    for (var block in blocks.skip(1)) {
      final idMatch = RegExp(r'^"([^"]+)"').firstMatch(block.trim()) ??
          RegExp(r'^\s*([^:\n\s]+)').firstMatch(block);
      String? id = idMatch?.group(1);
      final goalMatch = RegExp(r'business_goal:\s*"([^"]+)"').firstMatch(block);

      if (id != null && goalMatch != null)
        intentToGoals[id] = goalMatch.group(1)!;
    }
  }

  String? getGoalFor(String office, String role, String subKey) {
    final canonical = '$office.$role.$subKey';
    final intent = routeIntents[canonical] ?? pageToIntents[subKey];
    if (intent != null) return intentToGoals[intent];

    for (var entry in pageToIntents.entries) {
      if (subKey.contains(entry.key) || entry.key.contains(subKey)) {
        return intentToGoals[entry.value];
      }
    }
    return null;
  }
}

final governance = GovernanceData();

void main() async {
  await governance.load();
  final basePath = 'packages/flutter_core/assets/translations';

  // 1. Process EN first to get the Master Structure
  Map<String, dynamic>? masterData;
  // Load Navigation Inventory for Labels (Legacy)
  Map<String, String> navLabels = {};
  Map<String, String> navSections = {};

  final enFile = File('$basePath/en.json');
  if (await enFile.exists()) {
    final content = await enFile.readAsString();
    final Map<String, dynamic> sourceData =
        jsonDecode(content) as Map<String, dynamic>;
    masterData = refactorData(
      sourceData,
      navLabels: navLabels,
      navSections: navSections,
    );

    // Save Refactored EN
    final encoder = JsonEncoder.withIndent('  ');
    await enFile.writeAsString(encoder.convert(masterData));
    print('Refactored and saved EN as Master Structure');
  } else {
    print('Critical Error: en.json not found. Cannot proceed with parity.');
    return;
  }

  // 2. Process other locales with Parity enforcement
  for (final locale in ['es', 'fr']) {
    final filePath = '$basePath/$locale.json';
    final file = File(filePath);
    if (!await file.exists()) {
      print('File not found: $filePath');
      continue;
    }

    final content = await file.readAsString();
    Map<String, dynamic> data;
    try {
      data = jsonDecode(content) as Map<String, dynamic>;
    } catch (e) {
      print('Error decoding $filePath: $e');
      continue;
    }

    final refactoredData = refactorData(
      data,
      navLabels: navLabels,
      navSections: navSections,
    );
    final syncedData = syncParity(masterData, refactoredData);

    final encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString(encoder.convert(syncedData));
    print('Refactored and Synchronized $filePath with EN structural parity.');
  }
}

Map<String, dynamic> syncParity(
  Map<String, dynamic> master,
  Map<String, dynamic> target,
) {
  final Map<String, dynamic> synced = {};
  master.forEach((key, masterVal) {
    final targetVal = target[key];
    if (masterVal is Map<String, dynamic>) {
      synced[key] = syncParity(
        masterVal,
        (targetVal is Map<String, dynamic>) ? targetVal : {},
      );
    } else {
      synced[key] = targetVal ?? masterVal;
    }
  });
  return synced;
}

Map<String, dynamic> refactorData(
  Map<String, dynamic> data, {
  Map<String, String>? navLabels,
  Map<String, String>? navSections,
}) {
  final Map<String, dynamic> result = {
    'clinical': <String, dynamic>{},
    'corporate': <String, dynamic>{},
    'franchise': <String, dynamic>{},
    'marketing': <String, dynamic>{},
    'business_development': <String, dynamic>{},
    'support': <String, dynamic>{},
    'admin_infrastructure': <String, dynamic>{},
    'client_portal': <String, dynamic>{},
    'common': <String, dynamic>{},
  };

  String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  final officeRoles = {
    'corporate': [
      'ceo',
      'coo',
      'cfo',
      'cto',
      'complianceManager',
      'headOfBusDev',
      'headOfMarketing',
      'trainingDirector',
      'financeDirector',
      'scrumMaster',
      'hrDirector',
      'cxDirector',
    ],
    'business_development': [
      'regionalManagerOntario',
      'regionalManagerUsa',
      'regionalBdm',
      'franchiseSalesManager',
      'partnershipManager',
      'territoryExpansionManager',
      'generalManager',
    ],
    'marketing': [
      'localMarketingManager',
      'communityOutreach',
      'territorySalesManager',
    ],
    'franchise': [
      'franchiseOwner',
      'operationsManager',
      'scheduler',
      'billingAdmin',
      'hrHiring',
      'owner',
    ],
    'clinical': [
      'clinicalDirector',
      'intakeCoordinator',
      'qualityAssurance',
      'trainingCoordinator',
      'volunteerCoordinator',
      'receptionist',
      'psw',
      'rn',
      'rmt',
      'clinic',
      'patient',
      'intake',
    ],
    'support': ['customerSupport', 'qa', 'support'],
    'client_portal': ['client', 'familyMember', 'guest'],
    'admin_infrastructure': ['admin', 'system', 'global_admin', 'sys_admin'],
  };

  final fuzzyRoleMatches = {
    'local_marketing_manager': ['localMarketing', 'local_marketing', 'local'],
    'territory_sales_manager': [
      'territorySales',
      'territory_sales',
      'territory',
    ],
    'operations_manager': ['opsManager', 'ops_manager'],
    'billing_admin': ['billing'],
    'scheduler': ['scheduling', 'schedule'],
    'hr_hiring': ['hr'],
    'customer_support': ['customer_support', 'support_dashboard'],
  };

  String toSnakeCase(String text) {
    if (text.isEmpty) return text;
    return text.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (m) => '_${m[1]!.toLowerCase()}',
    );
  }

  Map<String, String>? findRoleMatch(String key) {
    for (final office in officeRoles.keys) {
      for (final role in officeRoles[office]!) {
        final snakeRole = toSnakeCase(role);
        final dotPrefix = '$snakeRole.';
        final underscorePrefix = '${snakeRole}_';
        final altDotPrefix = '$role.';
        final altUnderscorePrefix = '${role}_';

        if (key == role ||
            key == snakeRole ||
            key.startsWith(dotPrefix) ||
            key.startsWith(underscorePrefix) ||
            key.startsWith(altDotPrefix) ||
            key.startsWith(altUnderscorePrefix) ||
            key == '${role}_dashboard' ||
            key == '${snakeRole}_dashboard' ||
            key == '${role}.dashboard' ||
            key == '${snakeRole}.dashboard') {
          print('Match Found: $key -> $office/$snakeRole');
          return {'office': office, 'role': snakeRole};
        }

        if (fuzzyRoleMatches.containsKey(snakeRole)) {
          for (final fuzzy in fuzzyRoleMatches[snakeRole]!) {
            if (key.startsWith('${fuzzy}_') ||
                key.startsWith('${fuzzy}.') ||
                key == '${fuzzy}_dashboard' ||
                key == '${fuzzy}.dashboard' ||
                key == fuzzy) {
              print('Match Found: $key -> $office/$snakeRole');
              return {'office': office, 'role': snakeRole};
            }
          }
        }
      }
    }
    return null;
  }

  final flatData = <String, dynamic>{};

  void doFlatten(dynamic val, [String path = '']) {
    if (val is Map) {
      val.forEach(
        (dynamic k, dynamic v) =>
            doFlatten(v, path.isEmpty ? (k as String) : '$path.$k'),
      );
    } else {
      flatData[path] = val;
    }
  }

  doFlatten(data);
  print('First 10 flatData keys: ${flatData.keys.take(10).toList()}');

  // Inject Navigation
  navLabels?.forEach((id, label) => flatData['navigation.items.$id'] = label);
  navSections?.forEach(
    (id, label) => flatData['navigation.sections.$id'] = label,
  );

  // 2. Hierarchical Distribution
  flatData.forEach((key, value) {
    final common = result['common'] as Map<String, dynamic>;
    // Auth handling
    if (key == 'auth' ||
        key == 'common.auth' ||
        key.endsWith('.auth') ||
        key.startsWith('auth.')) {
      common['auth'] ??= <String, dynamic>{};
      String subKey = key.replaceFirst('auth.', '').replaceFirst('common.', '');
      if (subKey.isEmpty) subKey = 'general';
      (common['auth'] as Map<String, dynamic>)[subKey] = value;
      return;
    }

    if (key.startsWith('navigation.')) {
      common['navigation'] ??= <String, dynamic>{};
      String subKey = key.replaceFirst('navigation.', '');
      var parts = subKey.split('.');
      Map<String, dynamic> curr = common['navigation'] as Map<String, dynamic>;
      for (int i = 0; i < parts.length - 1; i++) {
        curr[parts[i]] ??= <String, dynamic>{};
        curr = curr[parts[i]] as Map<String, dynamic>;
      }
      curr[parts.last] = value;
      return;
    }

    // Try to find role match in ANY segment
    final allSegments = key.split('.');
    String? matchedOffice;
    String? matchedRole;
    int roleSegmentIndex = -1;

    for (int i = 0; i < allSegments.length; i++) {
      var match = findRoleMatch(allSegments[i]);
      if (match != null) {
        matchedOffice = match['office'];
        matchedRole = match['role'];
        roleSegmentIndex = i;
        break;
      }
    }

    if (matchedOffice != null && matchedRole != null) {
      final officeMap = result[matchedOffice] as Map<String, dynamic>;
      officeMap[matchedRole] ??= <String, dynamic>{};

      // SubKey is everything AFTER the role segment
      var subSegments = allSegments.sublist(roleSegmentIndex + 1);
      if (subSegments.isEmpty) subSegments = [allSegments.last];

      // Deduplicate segments (e.g. title.title -> title)
      List<String> cleanSegments = [];
      for (var seg in subSegments) {
        if (cleanSegments.isNotEmpty &&
            cleanSegments.last == seg &&
            (seg == 'title' || seg == 'subtitle' || seg == 'description')) {
          continue;
        }
        cleanSegments.add(seg);
      }

      final subKey = cleanSegments.join('.');
      final leafKey = cleanSegments.last;
      final isMetadataKey = leafKey == 'title' ||
          leafKey == 'subtitle' ||
          leafKey == 'description';
      final screenKey = isMetadataKey
          ? cleanSegments.sublist(0, cleanSegments.length - 1).join('.')
          : subKey;

      final goal = governance.getGoalFor(matchedOffice, matchedRole, screenKey);

      Map<String, dynamic> current =
          officeMap[matchedRole] as Map<String, dynamic>;
      for (int i = 0; i < cleanSegments.length - 1; i++) {
        String seg = cleanSegments[i];
        current[seg] ??= <String, dynamic>{};
        if (current[seg] is! Map) current[seg] = {'value': current[seg]};
        current = current[seg] as Map<String, dynamic>;
      }

      if (isMetadataKey) {
        current[leafKey] = value;
        if (goal != null) current['description'] = goal;
      } else if (subKey.contains('dashboard') ||
          subKey.contains('screen') ||
          subKey.contains('view') ||
          subKey.contains('section')) {
        current[leafKey] = {
          'title': toTitleCase(leafKey.replaceAll('_', ' ')),
          'subtitle': value is String ? value : 'Operational view.',
          if (goal != null) 'description': goal,
        };
      } else {
        current[leafKey] = value;
      }
    } else {
      String finalKey = key.replaceFirst('common.', '');
      common[finalKey] = value;
    }
  });

  result.removeWhere((key, value) => value is Map && value.isEmpty);
  return result;
}
