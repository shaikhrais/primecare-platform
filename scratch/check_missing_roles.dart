import 'dart:convert';
import 'dart:io';

void main() async {
  final enFile = File('packages/flutter_core/assets/translations/en.json');
  final enContent = await enFile.readAsString();
  final enData = jsonDecode(enContent) as Map<String, dynamic>;

  final roles = [
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
    'franchiseOwner',
    'operationsManager',
    'scheduler',
    'billingAdmin',
    'hrHiring',
    'owner',
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
    'customerSupport',
    'intake',
    'qa',
    'support',
    'client',
    'familyMember',
    'guest',
    'admin',
    'system',
  ];

  String toSnakeCase(String text) {
    return text.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (m) => '_${m[1]!.toLowerCase()}',
    );
  }

  final missing = <String>[];
  for (final role in roles) {
    final snakeRole = toSnakeCase(role);
    bool found = false;
    for (final office in enData.values) {
      if (office is Map && office.containsKey(snakeRole)) {
        found = true;
        break;
      }
    }
    if (!found) missing.add(role);
  }

  print('Missing roles: ' + missing.join(', '));
}
