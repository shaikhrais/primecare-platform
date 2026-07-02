import 'dart:io';
import 'dart:convert';

/// Script to generate a comprehensive screen status JSON
/// Groups screens by Office, Role, and Charter.
/// Analyzes ScreenRegistry for current implementation status.

void main() {
  final uiRegistryPath =
      'packages/primecare_ui/lib/src/registry/screen_registry.dart';
  final file = File(uiRegistryPath);

  // 1. Define the platform roles grouped by office
  final Map<String, List<String>> rolesByOffice = {
    'Corporate': [
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
      'shareholder',
    ],
    'Business Development': [
      'regionalManagerOntario',
      'regionalManagerUsa',
      'regionalBdm',
      'franchiseSalesManager',
      'partnershipManager',
      'territoryExpansionManager',
      'territorySalesManager',
      'generalManager',
      'localMarketingManager',
      'communityOutreach',
    ],
    'Franchise': [
      'franchiseOwner',
      'operationsManager',
      'scheduler',
      'billingAdmin',
      'hrHiring',
      'hrManager',
      'owner',
    ],
    'Clinical': [
      'clinicalDirector',
      'intakeCoordinator',
      'qualityAssurance',
      'trainingCoordinator',
      'volunteerCoordinator',
      'receptionist',
      'psw',
      'rn',
      'rpn',
      'rmt',
      'chiropractor',
      'physiotherapist',
      'socialWorker',
      'clinic',
      'patient',
      'customerSupport',
      'intake',
      'qa',
      'support',
    ],
    'Training & Architecture': [
      'trainingDirectorCertificate',
      'trainingHub',
      'courseArchitect',
      'architecturePlanning',
      'systemVerification',
      'dynamicScreen',
    ],
    'Client Portal': ['client', 'familyMember', 'guest'],
  };

  // 2. Define standard charters for each role
  final charters = ['Dashboard', 'Forms', 'Directory', 'Reports', 'Settings'];

  // 2b. Map Offices to Apps
  final Map<String, String> appByOffice = {
    'Corporate': 'primecare_corporate',
    'Business Development': 'primecare_business_development',
    'Franchise': 'primecare_franchise',
    'Clinical': 'primecare_clinic',
    'Training & Architecture': 'primecare_governance',
    'Client Portal': 'primecare_client',
  };

  // 3. Read current implemented/pending from ScreenRegistry
  final Set<String> registryPending = {};
  final Set<String> registryImplemented = {};

  if (file.existsSync()) {
    final lines = file.readAsLinesSync();
    for (final line in lines) {
      if (line.trim().startsWith("'") &&
          (line.contains("': ") || line.contains("':\t"))) {
        final parts = line.split("':");
        if (parts.length >= 2) {
          final screenIdStr = parts[0].trim();
          final screenId = screenIdStr.replaceAll('\'', '').replaceAll('"', '');
          final implementation = parts.sublist(1).join("':").trim();

          if (implementation.startsWith('CommonUiError404PageViewScreen')) {
            registryPending.add(screenId);
          } else {
            registryImplemented.add(screenId);
          }
        }
      }
    }
  } else {
    print('Warning: ScreenRegistry not found at $uiRegistryPath');
  }

  // Helper to construct a Screen ID based on convention, e.g., SCREEN_RN_DASHBOARD
  String buildScreenId(String role, String charter) {
    final rolePart = role
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase();
    final charterPart = charter.toUpperCase().replaceAll(' ', '_');
    return 'SCREEN_${rolePart}_$charterPart';
  }

  int totalScreens = 0;
  int totalImplemented = 0;
  int totalPending = 0;

  final Map<String, dynamic> summaryMap = {};
  final Map<String, Map<String, dynamic>> byAppMap = {};
  final Map<String, Map<String, dynamic>> byOfficeMap = {};
  final Map<String, Map<String, dynamic>> byRoleMap = {};
  final Map<String, Map<String, dynamic>> byCharterMap = {
    for (var c in charters) c: {'total': 0, 'implemented': 0, 'pending': 0},
  };
  final List<Map<String, dynamic>> screensList = [];

  for (final office in rolesByOffice.keys) {
    byOfficeMap[office] = {'total': 0, 'implemented': 0, 'pending': 0};

    final appName = appByOffice[office] ?? 'unknown_app';
    if (!byAppMap.containsKey(appName)) {
      byAppMap[appName] = {'total': 0, 'implemented': 0, 'pending': 0};
    }

    for (final role in rolesByOffice[office]!) {
      byRoleMap[role] = {
        'office': office,
        'app': appName,
        'total': 0,
        'implemented': 0,
        'pending': 0,
      };

      for (final charter in charters) {
        final screenId = buildScreenId(role, charter);
        totalScreens++;

        bool isImplemented = registryImplemented.contains(screenId);
        bool isPendingPlaceholder = registryPending.contains(screenId);

        if (isImplemented) {
          totalImplemented++;
          byAppMap[appName]!['implemented'] =
              (byAppMap[appName]!['implemented'] as int) + 1;
          byOfficeMap[office]!['implemented'] =
              (byOfficeMap[office]!['implemented'] as int) + 1;
          byRoleMap[role]!['implemented'] =
              (byRoleMap[role]!['implemented'] as int) + 1;
          byCharterMap[charter]!['implemented'] =
              (byCharterMap[charter]!['implemented'] as int) + 1;
        } else {
          totalPending++;
          byAppMap[appName]!['pending'] =
              (byAppMap[appName]!['pending'] as int) + 1;
          byOfficeMap[office]!['pending'] =
              (byOfficeMap[office]!['pending'] as int) + 1;
          byRoleMap[role]!['pending'] =
              (byRoleMap[role]!['pending'] as int) + 1;
          byCharterMap[charter]!['pending'] =
              (byCharterMap[charter]!['pending'] as int) + 1;
        }

        byAppMap[appName]!['total'] = (byAppMap[appName]!['total'] as int) + 1;
        byOfficeMap[office]!['total'] =
            (byOfficeMap[office]!['total'] as int) + 1;
        byRoleMap[role]!['total'] = (byRoleMap[role]!['total'] as int) + 1;
        byCharterMap[charter]!['total'] =
            (byCharterMap[charter]!['total'] as int) + 1;

        screensList.add({
          'id': screenId,
          'app': appName,
          'office': office,
          'role': role,
          'charter': charter,
          'status': isImplemented
              ? 'implemented'
              : (isPendingPlaceholder ? 'placeholder' : 'missing'),
        });
      }
    }
  }

  summaryMap['total'] = totalScreens;
  summaryMap['implemented'] = totalImplemented;
  summaryMap['pending'] = totalPending;
  summaryMap['implementedPercentage'] = totalScreens == 0
      ? 0
      : (totalImplemented / totalScreens * 100).round();

  final Map<String, dynamic> output = {
    'summary': summaryMap,
    'byApp': byAppMap,
    'byOffice': byOfficeMap,
    'byRole': byRoleMap,
    'byCharter': byCharterMap,
    'screens': screensList,
    'lastUpdated': DateTime.now().toIso8601String(),
  };

  final jsonString = JsonEncoder.withIndent('  ').convert(output);

  final outDir = Directory('apps/primecare_governance/assets');
  if (!outDir.existsSync()) outDir.createSync(recursive: true);

  final outPath = 'apps/primecare_governance/assets/screen_status.json';
  File(outPath).writeAsStringSync(jsonString);

  print('✅ Successfully generated planned screen status.');
  print('Total Planned Screens: $totalScreens');
  print('Implemented: $totalImplemented');
  print('Pending:     $totalPending');
  print('Output saved to: $outPath');
}
