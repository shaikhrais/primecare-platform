// Governance - Category: service | Purpose: Core implementation file for the Primecare Realize All platform logic.
import 'dart:io';

void main() {
  final packageRoot = Directory.current.path;
  final projectRoot = Directory(packageRoot).parent.parent.path;
  final adaptersLib = '$projectRoot/packages/primecare_adapters/lib';
  final adaptersSrc = '$adaptersLib/src';
  final generatedAdaptersDir = '$adaptersSrc/governance_generated';
  final coreRoot = '$packageRoot/lib';
  final featuresRoot = '$coreRoot/features';

  final roles = [
    'ceo',
    'coo',
    'cfo',
    'cto',
    'compliance_manager',
    'head_of_bus_dev',
    'head_of_marketing',
    'training_director',
    'finance_director',
    'scrum_master',
    'hr_director',
    'cx_director',
    'regional_manager_ontario',
    'regional_manager_usa',
    'franchise_sales_manager',
    'partnership_manager',
    'territory_expansion_manager',
    'general_manager',
    'franchise_owner',
    'operations_manager',
    'scheduler',
    'billing_admin',
    'hr_hiring',
    'owner',
    'clinical_director',
    'intake_coordinator',
    'quality_assurance',
    'training_coordinator',
    'volunteer_coordinator',
    'receptionist',
    'psw',
    'rn',
    'rmt',
    'client',
    'family_member',
    'guest',
  ];

  print('Starting PrimeCare Ultimate Realization for ${roles.length} roles...');

  // 1. Ensure Generated Adapters directory exists
  Directory('$generatedAdaptersDir/adapters').createSync(recursive: true);
  Directory('$generatedAdaptersDir/models').createSync(recursive: true);

  for (final role in roles) {
    final rolePascal = _toPascal(role);
    final roleCamel = _toCamel(role);

    // Check if adapter exists anywhere in primecare_adapters
    bool exists = false;
    final results = Directory(adaptersSrc).listSync(recursive: true);
    for (final item in results) {
      if (item.path.endsWith('04_A_${role}_dashboard_adapter.dart') ||
          item.path.endsWith('04_A_${role}_adapter.dart')) {
        exists = true;
        break;
      }
    }

    String providerName = '${roleCamel}DashboardAdapterProvider';
    String viewModelName = '${rolePascal}DashboardViewModel';

    if (!exists) {
      print('Generating placeholder adapter for $role...');

      // Generate ViewModel
      final vmFile =
          '$generatedAdaptersDir/models/03_V_${role}_dashboard_view_model.dart';
      final vmContent =
          '''
import 'package:primecare_domain/primecare_domain.dart';

class $viewModelName extends ViewModel {
  final List<KpiMetric> metrics;
  
  const $viewModelName({
    required this.metrics,
  });
}
''';
      File(vmFile).writeAsStringSync(vmContent);

      // Generate Adapter
      final adapterFile =
          '$generatedAdaptersDir/adapters/04_A_${role}_dashboard_adapter.dart';
      final adapterContent =
          '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_domain/primecare_domain.dart';
import '03_V_${role}_dashboard_view_model.dart';

final $providerName = StateProvider<AsyncValue<Either<String, $viewModelName>>>((ref) {
  return AsyncValue.data(Right($viewModelName(
    metrics: [
      KpiMetric(label: 'Governance Status', value: 'Operational', trend: 0),
      KpiMetric(label: 'Realization Score', value: '100%', trend: 5),
    ],
  )));
});
''';
      File(adapterFile).writeAsStringSync(adapterContent);

      // Add to primecare_adapters.dart exports if not there
      final exportLine =
          "export 'src/governance_generated/adapters/04_A_${role}_dashboard_adapter.dart';";
      final exportVmLine =
          "export 'src/governance_generated/models/03_V_${role}_dashboard_view_model.dart';";
      final masterExportFile = File('$adaptersLib/primecare_adapters.dart');
      String masterContent = masterExportFile.readAsStringSync();
      if (!masterContent.contains(exportLine)) {
        masterContent += '\n$exportLine';
      }
      if (!masterContent.contains(exportVmLine)) {
        masterContent += '\n$exportVmLine';
      }
      masterExportFile.writeAsStringSync(masterContent);
    } else {
      // Try to find the provider name from existing adapter
      for (final item in results) {
        if (item.path.endsWith('04_A_${role}_dashboard_adapter.dart') ||
            item.path.endsWith('04_A_${role}_adapter.dart')) {
          final content = File(item.path).readAsStringSync();
          final match = RegExp(
            r'final\s+(\w+Provider)\s*=',
          ).firstMatch(content);
          if (match != null) providerName = match.group(1)!;

          final vmMatch = RegExp(r'class\s+(\w+ViewModel)').firstMatch(content);
          if (vmMatch != null) viewModelName = vmMatch.group(1)!;
          break;
        }
      }
    }

    // 2. Realize Feature (Intent + Screen)
    final featureDir = '$featuresRoot/${role}_dashboard';
    final registryDir = '$featureDir/registry';
    final intentFile = '$registryDir/04_I_${role}_dashboard_intent.dart';
    final screenDir = '$featureDir/presentation/widgets';
    final screenFile = '$screenDir/05_U_${role}_dashboard_screen.dart';

    // Cleanup legacy
    _deleteIfExists('$featureDir/data');
    _deleteIfExists('$featureDir/domain');
    _deleteIfExists('$featureDir/registry'); // Will be recreated

    Directory(registryDir).createSync(recursive: true);
    Directory(screenDir).createSync(recursive: true);

    String route = '/offices/corporate/roles/$role/dashboard';
    if (role == 'client' || role == 'family_member' || role == 'guest') {
      route = '/portals/$role/dashboard';
    } else if (role == 'clinical_director' ||
        role == 'rn' ||
        role == 'psw' ||
        role == 'rmt' ||
        role == 'patient') {
      route = '/offices/clinical/roles/$role/dashboard';
    }

    String roleEnum = 'PlatformRole.${_toCamel(role)}';
    if (role == 'family_member') roleEnum = 'PlatformRole.familyMember';
    if (role == 'head_of_bus_dev') roleEnum = 'PlatformRole.headOfBusDev';
    if (role == 'head_of_marketing') roleEnum = 'PlatformRole.headOfMarketing';
    if (role == 'compliance_manager')
      roleEnum = 'PlatformRole.complianceManager';
    if (role == 'training_director') roleEnum = 'PlatformRole.trainingDirector';
    if (role == 'finance_director') roleEnum = 'PlatformRole.financeDirector';
    if (role == 'scrum_master') roleEnum = 'PlatformRole.scrumMaster';
    if (role == 'hr_director') roleEnum = 'PlatformRole.hrDirector';
    if (role == 'cx_director') roleEnum = 'PlatformRole.cxDirector';
    if (role == 'regional_manager_ontario')
      roleEnum = 'PlatformRole.regionalManagerOntario';
    if (role == 'regional_manager_usa')
      roleEnum = 'PlatformRole.regionalManagerUsa';
    if (role == 'franchise_sales_manager')
      roleEnum = 'PlatformRole.franchiseSalesManager';
    if (role == 'partnership_manager')
      roleEnum = 'PlatformRole.partnershipManager';
    if (role == 'territory_expansion_manager')
      roleEnum = 'PlatformRole.territoryExpansionManager';
    if (role == 'general_manager') roleEnum = 'PlatformRole.generalManager';
    if (role == 'franchise_owner') roleEnum = 'PlatformRole.franchiseOwner';
    if (role == 'operations_manager')
      roleEnum = 'PlatformRole.operationsManager';
    if (role == 'billing_admin') roleEnum = 'PlatformRole.billingAdmin';
    if (role == 'hr_hiring') roleEnum = 'PlatformRole.hrHiring';
    if (role == 'clinical_director') roleEnum = 'PlatformRole.clinicalDirector';
    if (role == 'intake_coordinator')
      roleEnum = 'PlatformRole.intakeCoordinator';
    if (role == 'quality_assurance') roleEnum = 'PlatformRole.qualityAssurance';
    if (role == 'training_coordinator')
      roleEnum = 'PlatformRole.trainingCoordinator';
    if (role == 'volunteer_coordinator')
      roleEnum = 'PlatformRole.volunteerCoordinator';

    final intentContent =
        '''
// Layer: 04_REGISTRY_INTENT
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../../registry/platform_role.dart';
import '../../../registry/intents/app_screen_intent.dart';
import '../presentation/widgets/05_U_${role}_dashboard_screen.dart';

class ${rolePascal}DashboardIntent extends AppScreenIntent {
  const ${rolePascal}DashboardIntent();

  @override
  String get name => '${role}_dashboard';

  @override
  String get route => '$route';

  @override
  String get title => '${rolePascal.replaceAll(RegExp(r'(?=[A-Z])'), ' ').trim()} Dashboard';

  @override
  PlatformRole get requiredRole => $roleEnum;

  @override
  dynamic get provider => $providerName;

  @override
  Widget build(BuildContext context) => const ${rolePascal}DashboardScreen();

  @override
  Widget buildScreen(BuildContext context, ViewModel data) {
    return const ${rolePascal}DashboardScreen();
  }
}
''';
    File(intentFile).writeAsStringSync(intentContent);

    final screenContent =
        '''
// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ${rolePascal}DashboardScreen extends ConsumerWidget {
  const ${rolePascal}DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch($providerName);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (success) {
            final vm = success as $viewModelName;
            return _buildContent(context, theme, vm);
          },
          (err) => DashboardErrorWidget(
            message: 'Domain Logistics Failure: \$err',
            onRetry: () => ref.refresh($providerName),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Governance Exception: \$e',
          onRetry: () => ref.refresh($providerName),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PrimeCareThemeData theme, $viewModelName vm) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${rolePascal.replaceAll(RegExp(r'(?=[A-Z])'), ' ').trim()} Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: const Center(child: Text('Operational Insights Unified')),
          ),
        ],
      ),
    );
  }
}
''';
    File(screenFile).writeAsStringSync(screenContent);
  }

  print('Realization logic finished. Running Rebuilders...');
}

void _deleteIfExists(String path) {
  final dir = Directory(path);
  if (dir.existsSync()) {
    try {
      dir.deleteSync(recursive: true);
    } catch (e) {
      print('Warning: Could not delete \$path: \$e');
    }
  }
}

String _toPascal(String s) {
  final parts = s.split('_');
  return parts.map((p) => p[0].toUpperCase() + p.substring(1)).join('');
}

String _toCamel(String s) {
  final pascal = _toPascal(s);
  return pascal[0].toLowerCase() + pascal.substring(1);
}
