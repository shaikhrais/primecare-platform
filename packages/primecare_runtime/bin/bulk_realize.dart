// Governance - Category: service | Purpose: 1. Find all adapters to determine possible roles Pre-scan adapters to find provider names
import 'dart:io';

void main() {
  final packageRoot = Directory.current.path;
  final projectRoot = Directory(packageRoot).parent.parent.path;
  final adaptersLib = '$projectRoot/packages/primecare_adapters/lib';
  final adaptersSrc = '$adaptersLib/src';
  final coreRoot = '$packageRoot/lib';
  final featuresRoot = '$coreRoot/features';

  // 1. Find all adapters to determine possible roles
  final adapterFiles = Directory(adaptersSrc)
      .listSync(recursive: true)
      .where((f) => f.path.endsWith('_adapter.dart'))
      .toList();

  print('Found ${adapterFiles.length} domain adapters.');

  // Pre-scan adapters to find provider names
  final Map<String, String> roleToProvider = {};
  for (final file in adapterFiles) {
    final content = File(file.path).readAsStringSync();
    final match = RegExp(r'final\s+(\w+Provider)\s*=').firstMatch(content);
    if (match != null) {
      final fileName = file.path.split(Platform.pathSeparator).last;
      final role = fileName
          .replaceAll('04_A_', '')
          .replaceAll('_dashboard_adapter.dart', '')
          .replaceAll('_adapter.dart', '');
      roleToProvider[role] = match.group(1)!;
    }
  }

  // Pre-scan primecare_adapters.dart for ViewModel names
  final adaptersExportFile = File(
    '$adaptersLib/primecare_adapters.dart',
  ).readAsStringSync();
  final Map<String, String> roleToViewModel = {};

  final vmMatches = RegExp(
    r"export '.*?/03_V_(.*?)_view_model\.dart';",
  ).allMatches(adaptersExportFile);
  for (final m in vmMatches) {
    final vmFileBase = m.group(1)!;
    final role = vmFileBase.replaceAll('_dashboard', '');
    final pascalRole = _toPascal(role);

    if (role == 'training_hub')
      roleToViewModel[role] = 'TrainingHubViewModel';
    else if (role == 'course_architect')
      roleToViewModel[role] = 'CourseArchitectViewModel';
    else if (role == 'system_verification')
      roleToViewModel[role] = 'SystemVerificationViewModel';
    else if (role == 'architecture_planning')
      roleToViewModel[role] = 'ArchitecturePlanningViewModel';
    else if (role == 'cx_director')
      roleToViewModel[role] = 'CxDirectorDashboardViewModel';
    else
      roleToViewModel[role] = '${pascalRole}DashboardViewModel';
  }

  for (final file in adapterFiles) {
    final fileName = file.path.split(Platform.pathSeparator).last;
    final role = fileName
        .replaceAll('04_A_', '')
        .replaceAll('_dashboard_adapter.dart', '')
        .replaceAll('_adapter.dart', '');

    if (role == 'dynamic' ||
        role == 'primecare_form' ||
        role == 'auth_layout' ||
        role == 'auth_split_layout')
      continue;

    final rolePascal = _toPascal(role);
    final providerName =
        roleToProvider[role] ?? '${_toCamel(role)}DashboardAdapterProvider';
    final viewModelName =
        roleToViewModel[role] ??
        (role == 'architecture_planning'
            ? 'ArchitecturePlanningViewModel'
            : '${rolePascal}DashboardViewModel');

    // Path definitions
    final featureDir = '$featuresRoot/${role}_dashboard';
    print('Processing role: $role -> $featureDir');
    final registryDir = '$featureDir/registry';
    final intentFile = '$registryDir/04_I_${role}_dashboard_intent.dart';
    final screenDir = '$featureDir/presentation/widgets';
    final screenFile = '$screenDir/05_U_${role}_dashboard_screen.dart';

    // 1. CLEANUP: Delete legacy data/domain/registry folders
    final legacyData = Directory('$featureDir/data');
    if (legacyData.existsSync()) legacyData.deleteSync(recursive: true);
    final legacyDomain = Directory('$featureDir/domain');
    if (legacyDomain.existsSync()) legacyDomain.deleteSync(recursive: true);

    // 2. Create Feature Structure
    Directory(registryDir).createSync(recursive: true);
    Directory(screenDir).createSync(recursive: true);

    // Role-specific route mapping
    String route = '/offices/corporate/roles/$role/dashboard';
    if (role == 'client' || role == 'family_member') {
      route = '/portals/$role/dashboard';
    } else if (role == 'clinical_director' || role == 'rn' || role == 'psw') {
      route = '/offices/clinical/roles/$role/dashboard';
    }

    // Role mapping
    String roleEnum = 'PlatformRole.${_toCamel(role)}';
    if (role == 'client') roleEnum = 'PlatformRole.client';
    if (role == 'family_member') roleEnum = 'PlatformRole.familyMember';

    // 3. Generate Intent
    final intentContent =
        '''
// Layer: 04_REGISTRY_INTENT
import 'package:flutter/material.dart';
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

    // 4. Generate Screen
    if (!File(screenFile).existsSync() ||
        File(
          screenFile,
        ).readAsStringSync().contains('Operational Insights Unified')) {
      final screenContent =
          '''
// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ${rolePascal}DashboardScreen extends ConsumerWidget {
  const ${rolePascal}DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    // ignore: inference_failure_on_function_invocation
    final state = ref.watch<dynamic>($providerName);

    return MasterLayout(
      // ignore: avoid_dynamic_calls
      child: state.when(
        // ignore: avoid_dynamic_calls
        data: (dynamic result) => result.fold(
          (dynamic success) {
            // Hardened Type Casting for Governance Compliance
            final vm = success as $viewModelName;
            return _buildContent(context, theme, vm);
          },
          (dynamic err) => DashboardErrorWidget(
            message: 'Domain Logistics Failure: \$err',
            onRetry: () => ref.refresh($providerName),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (Object e, StackTrace st) => DashboardErrorWidget(
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
  }

  print('Bulk realization completed for ${adapterFiles.length} roles.');
}

String _toPascal(String s) {
  final parts = s.split('_');
  return parts.map((p) => p[0].toUpperCase() + p.substring(1)).join('');
}

String _toCamel(String s) {
  final pascal = _toPascal(s);
  return pascal[0].toLowerCase() + pascal.substring(1);
}
