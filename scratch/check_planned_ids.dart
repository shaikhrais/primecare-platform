import 'dart:io';

void main() {
  final uiRegistryPath = 'packages/primecare_ui/lib/src/registry/screen_registry.dart';
  final file = File(uiRegistryPath);
  
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

          if (!implementation.startsWith('CommonUiError404PageViewScreen')) {
            registryImplemented.add(screenId);
          }
        }
      }
    }
  }

  final Map<String, List<String>> rolesByOffice = {
    'Corporate': [
      'ceo', 'coo', 'cfo', 'cto', 'complianceManager', 'headOfBusDev', 'headOfMarketing',
      'trainingDirector', 'financeDirector', 'scrumMaster', 'hrDirector', 'cxDirector', 'shareholder',
    ],
    'Business Development': [
      'regionalManagerOntario', 'regionalManagerUsa', 'regionalBdm', 'franchiseSalesManager',
      'partnershipManager', 'territoryExpansionManager', 'territorySalesManager', 'generalManager',
      'localMarketingManager', 'communityOutreach',
    ],
    'Franchise': [
      'franchiseOwner', 'operationsManager', 'scheduler', 'billingAdmin', 'hrHiring', 'hrManager', 'owner',
    ],
    'Clinical': [
      'clinicalDirector', 'intakeCoordinator', 'qualityAssurance', 'trainingCoordinator',
      'volunteerCoordinator', 'receptionist', 'psw', 'rn', 'rpn', 'rmt', 'chiropractor',
      'physiotherapist', 'socialWorker', 'clinic', 'patient', 'customerSupport', 'intake', 'qa', 'support',
    ],
    'Training & Architecture': [
      'trainingDirectorCertificate', 'trainingHub', 'courseArchitect', 'architecturePlanning',
      'systemVerification', 'dynamicScreen',
    ],
    'Client Portal': ['client', 'familyMember', 'guest'],
  };

  final charters = ['Dashboard', 'Forms', 'Directory', 'Reports', 'Settings'];

  String buildScreenId(String role, String charter) {
    final rolePart = role
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toUpperCase();
    final charterPart = charter.toUpperCase().replaceAll(' ', '_');
    return 'SCREEN_${rolePart}_$charterPart';
  }

  print('Matching generated IDs against registry implemented:');
  int matchCount = 0;
  int missCount = 0;
  
  for (final office in rolesByOffice.keys) {
    for (final role in rolesByOffice[office]!) {
      for (final charter in charters) {
        final screenId = buildScreenId(role, charter);
        final inRegistry = registryImplemented.contains(screenId);
        
        if (inRegistry) {
          matchCount++;
          if (matchCount <= 20) {
            print('  [MATCH] $screenId is in registry');
          }
        } else {
          missCount++;
          if (missCount <= 10) {
            print('  [MISS]  $screenId is NOT in registry');
          }
        }
      }
    }
  }

  print('\nSummary:');
  print('  Matches (Implemented): $matchCount');
  print('  Misses (Pending):      $missCount');
  print('  Total Checked:         ${matchCount + missCount}');
  print('  Registry Implemented Count: ${registryImplemented.length}');
}
