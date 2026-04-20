import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_core/flutter_core.dart';
import '../assembly_line/assembly_line.dart';
import 'layout/prime_responsive_grid.dart';
import '../theme/design_system.dart';

class PageTemplate extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Color>? headerGradientColors;
  final List<Widget>? kpiCards;
  final List<Widget>? bodySections;
  final Widget? child;
  final Widget? actionButton;
  final Widget? footer;

  const PageTemplate({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.headerGradientColors,
    this.kpiCards,
    this.bodySections,
    this.child,
    this.actionButton,
    this.footer,
  });

  /// The 'Zero-Code' constructor for high-fidelity dashboards.
  /// Automatically handles the provider state and injects the AssemblyLine.
  static Widget orchestrate<T>({
    required String title,
    required dynamic provider,
    String? subtitle,
    IconData? icon,
    Widget? actionButton,
  }) {
    return _OrchestratedPage<T>(
      title: title,
      subtitle: subtitle,
      icon: icon,
      provider: provider,
      actionButton: actionButton,
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

    return Scaffold(
      backgroundColor:
          Colors.transparent, // Assumes a background wrapper exists
      appBar: AppBar(
        title: Text(
          title.tr(),
          key: Key('page_title_${title.hashCode}'),
          style: TextStyle(
            fontSize: PrimeCareSpacing.scaled(20, scale),
            fontWeight: FontWeight.bold,
            color: ds.colors.textPrimary,
          ),
        ),
        actions: actionButton != null ? [actionButton!] : null,
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
                    key: Key('page_subtitle_${subtitle.hashCode}'),
                    style: GoogleFonts.inter(
                      fontSize: PrimeCareSpacing.scaled(16.0, scale),
                      color: ds.colors.textSecondary,
                      letterSpacing: 0.5,
                      height: 1.5,
                    ),
                  ),
                ),
              if (kpiCards case final List<Widget> cards) ...[
                PrimeResponsiveGrid(
                  key: Key('kpi_grid_${title.hashCode}'),
                  desktopMainAxisExtent: PrimeCareSpacing.scaled(160, scale),
                  children: cards,
                ),
                SizedBox(height: sectionSpacing),
              ],
              if (child case final Widget c) c,
              if (bodySections case final List<Widget> sections) ...sections,
              if (footer case final Widget f) ...[
                SizedBox(height: PrimeCareSpacing.scaled(64, scale)),
                f,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OrchestratedPage<T> extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final dynamic provider;
  final Widget? actionButton;

  const _OrchestratedPage({
    required this.title,
    this.subtitle,
    this.icon,
    required this.provider,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    // Resilience Block: Verify that we actually have an AsyncValue before calling .when
    if (asyncValue is! AsyncValue) {
      return Center(
        child: Text(
          'Aura Orchestration Failure: Expected AsyncValue, got ${asyncValue.runtimeType}\nProvider: ${provider.runtimeType}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: PrimeCareColors.rose),
        ),
      );
    }

    return asyncValue.when(
      data: (data) {
        // We expect T to have a 'blueprints' property and 'isOfflineFallback' flag.
        // This is the standard for PrimeCare ViewModels.
        List<UIComponentBlueprint> blueprints = [];
        bool isOffline = false;

        // UNWRAP Result if present
        dynamic unwrappedData = data;
        if (data is Result) {
          unwrappedData = data.dataOrNull;
        }

        if (unwrappedData == null) {
          debugPrint(
            '[PageTemplate] Orchestration warning: unwrappedData is null for "$title"',
          );
          if (data is Failure) {
            final failure = data;
            debugPrint(
              '[PageTemplate] Error found in Result payload: ${failure.message}',
            );
          }

          return PageTemplate(
            title: title,
            subtitle: subtitle,
            icon: icon,
            child: const AssemblyLine(blueprints: [], isOfflineFallback: true),
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
              (unwrappedData['blueprints'] as List<dynamic>?)
                  ?.cast<UIComponentBlueprint>() ??
              [];
          isOffline = (unwrappedData['isOfflineFallback'] as bool?) ?? false;
        } else {
          final dynamic d = unwrappedData;
          try {
            // Duck-typing fallback for custom ViewModels not explicitly handled
            blueprints =
                (d.blueprints as List<dynamic>?)
                    ?.cast<UIComponentBlueprint>() ??
                [];
            isOffline = (d.isOfflineFallback as bool?) ?? false;
          } catch (_) {}
        }

        return PageTemplate(
          title: title,
          subtitle: subtitle,
          icon: icon,
          actionButton: actionButton,
          child: AssemblyLine(
            blueprints: blueprints,
            isOfflineFallback: isOffline,
          ),
        );
      },
      loading: () => Center(
        child: Padding(
          padding: EdgeInsets.all(PrimeCareSpacing.scaled(80.0, scale)),
          child: CircularProgressIndicator(
            color: ds.colors.primary,
            strokeWidth: 3 * scale,
          ),
        ),
      ),
      error: (err, stack) => Center(
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
      ),
    );
  }
}
