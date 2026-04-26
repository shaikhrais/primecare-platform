// Layer: 01_INFRASTRUCTURE

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

// Internal granular imports
import 'package:flutter_core/providers/03_D_portal_providers.dart';
import 'package:primecare_ui/src/theme/01_I_design_system.dart';
import 'package:primecare_ui/src/components/layout/01_I_prime_responsive_grid.dart';
import 'package:primecare_ui/src/assembly_line/01_I_assembly_line.dart';

// Adapters - Granular Imports
import 'package:primecare_adapters/src/models/02_M_dashboard_view_model.dart';
import 'package:primecare_adapters/src/models/core/02_M_dashboard_models.dart';
import 'package:primecare_adapters/src/models/core/02_M_ui_blueprint.dart';
import 'package:primecare_adapters/src/infrastructure/01_I_result.dart';
import 'package:primecare_adapters/src/infrastructure/01_I_telemetry_service.dart';

class PageTemplate extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Color>? headerGradientColors;
  final List<Widget>? kpiCards;
  final List<Widget>? kpis; // Alias for kpiCards
  final List<Widget>? bodySections;
  final List<Widget>? sections; // Alias for bodySections
  final Widget? child;
  final Widget? body; // Alias for child
  final List<Widget>? actions;
  final Widget? actionButton; // Legacy support
  final Widget? footer;

  const PageTemplate({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.headerGradientColors,
    this.kpiCards,
    this.kpis,
    this.bodySections,
    this.sections,
    this.child,
    this.body,
    this.actions,
    this.actionButton,
    this.footer,
  });

  /// The 'Zero-Code' constructor for high-fidelity dashboards.
  /// Automatically handles the provider state and injects the AssemblyLine.
  static Widget orchestrate({
    required String title,
    required dynamic provider,
    String? subtitle,
    IconData? icon,
    Widget? actionButton,
    List<Widget>? actions,
  }) {
    return _OrchestratedPage(
      title: title,
      subtitle: subtitle,
      icon: icon,
      provider: provider,
      actions: actions ?? (actionButton != null ? [actionButton] : null),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    // Dynamic institutional spacing
    final screenPadding = PrimeCareSpacing.scaledEdgeScreen(scale);
    final sectionSpacing = PrimeCareSpacing.scaled(48.0, scale);

    // Resolve effective parameters from aliases
    final effectiveKpis = kpiCards ?? kpis;
    final effectiveBody = child ?? body;
    final effectiveSections = bodySections ?? sections;
    final button = actionButton;
    final effectiveActions = actions ?? (button != null ? [button] : null);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          title.tr(),
          key: const Key('page_title'),
          style: TextStyle(
            fontSize: PrimeCareSpacing.scaled(20, scale),
            fontWeight: FontWeight.bold,
            color: ds.colors.textPrimary,
          ),
        ),
        actions: effectiveActions,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          size: PrimeCareSpacing.scaled(24, scale),
          color: ds.colors.textPrimary,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (subtitle != null)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: PrimeCareSpacing.scaled(32.0, scale),
                  ),
                  child: Text(
                    subtitle!.tr(),
                    key: const Key('page_subtitle'),
                    style: GoogleFonts.inter(
                      fontSize: PrimeCareSpacing.scaled(16.0, scale),
                      color: ds.colors.textSecondary,
                      letterSpacing: 0.5,
                      height: 1.5,
                    ),
                  ),
                ),
              if (effectiveKpis != null && effectiveKpis.isNotEmpty) ...[
                PrimeResponsiveGrid(
                  key: const Key('kpi_grid'),
                  desktopMainAxisExtent: PrimeCareSpacing.scaled(160, scale),
                  children: effectiveKpis,
                ),
                SizedBox(height: sectionSpacing),
              ],
              if (effectiveBody != null) effectiveBody,
              if (effectiveSections != null) ...effectiveSections,
              if (footer != null) ...[
                SizedBox(height: PrimeCareSpacing.scaled(64, scale)),
                footer!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OrchestratedPage extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final dynamic provider;
  final List<Widget>? actions;

  const _OrchestratedPage({
    required this.title,
    this.subtitle,
    this.icon,
    required this.provider,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: argument_type_not_assignable
    final asyncValue = ref.watch<AsyncValue<dynamic>>(provider as dynamic);
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);
    final telemetry = ref.read(executionGateProvider);

    // Telemetry and validation of orchestrated state
    if (asyncValue.hasError && !asyncValue.isLoading) {
      debugPrint('[PageTemplate] Orchestration Error: ${asyncValue.error}');
    }

    return asyncValue.when(
      data: (data) {
        List<UIComponentBlueprint> blueprints = [];
        bool isOffline = false;

        dynamic unwrappedData = data;
        if (data is Result) {
          unwrappedData = data.dataOrNull;
        }

        if (unwrappedData == null) {
          if (data is Failure) {
            debugPrint('[PageTemplate] Error in Result: ${data.error}');
            telemetry.failGate(
              ExecutionGateCategory.ui,
              'Dashboard Null Data Failure: $title',
              error: data.error,
              silent: true,
            );
          }

          return PageTemplate(
            title: title,
            subtitle: subtitle,
            icon: icon,
            body: const AssemblyLine(blueprints: [], isOfflineFallback: true),
          );
        }

        if (unwrappedData is PrimeCareDashboardViewModel) {
          blueprints = unwrappedData.blueprints;
          isOffline = unwrappedData.isOfflineFallback;
        } else if (unwrappedData is DashboardMetrics) {
          final vm = PrimeCareDashboardViewModel.fromDashboardMetrics(
            unwrappedData,
          );
          blueprints = vm.blueprints;
          isOffline = vm.isOfflineFallback;
        } else if (unwrappedData is ClinicalIntelligenceViewModel) {
          blueprints = unwrappedData.blueprints;
          isOffline = unwrappedData.isOfflineFallback;
        } else if (unwrappedData is Map) {
          blueprints =
              (unwrappedData['blueprints'] as List?)
                  ?.cast<UIComponentBlueprint>() ??
              [];
          isOffline = (unwrappedData['isOfflineFallback'] as bool?) ?? false;
        } else {
          debugPrint(
            '[PageTemplate] Unrecognized data type: ${unwrappedData.runtimeType}',
          );
        }

        telemetry.passGate(
          ExecutionGateCategory.ui,
          'Dashboard Hydration Successful: $title',
          metadata: {
            'isOffline': isOffline,
            'blueprintCount': blueprints.length,
            'dataType': unwrappedData.runtimeType.toString(),
          },
          silent: true,
        );

        return PageTemplate(
          title: title,
          subtitle: subtitle,
          icon: icon,
          actions: actions,
          body: AssemblyLine(
            blueprints: blueprints,
            isOfflineFallback: isOffline,
          ),
        );
      },
      loading: () {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(PrimeCareSpacing.scaled(80.0, scale)),
            child: CircularProgressIndicator(
              color: ds.colors.primary,
              strokeWidth: 3 * scale,
            ),
          ),
        );
      },
      error: (err, stack) {
        telemetry.failGate(
          ExecutionGateCategory.ui,
          'Dashboard Orchestration Error: $title',
          error: err,
          stackTrace: stack,
          silent: true,
        );
        return Center(
          child: Padding(
            padding: EdgeInsets.all(PrimeCareSpacing.scaled(40.0, scale)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: ds.colors.error,
                  size: PrimeCareSpacing.scaled(48, scale),
                ),
                SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
                Text(
                  'Orchestration Error: $err',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: ds.colors.textSecondary,
                    fontSize: PrimeCareSpacing.scaled(14, scale),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
