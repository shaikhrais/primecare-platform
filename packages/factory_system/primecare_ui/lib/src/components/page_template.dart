import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_core/flutter_core.dart';
import '../assembly_line/assembly_line.dart';
import 'layout/prime_responsive_grid.dart';
import '../theme/design_system.dart';
import '../theme/theme_tokens.dart';

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
  }) {
    return _OrchestratedPage<T>(
      title: title,
      subtitle: subtitle,
      icon: icon,
      provider: provider,
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
          title,
          key: const Key('page_title'),
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
                    subtitle!,
                    key: const Key('page_subtitle'),
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
                  key: const Key('kpi_grid'),
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

  const _OrchestratedPage({
    required this.title,
    this.subtitle,
    this.icon,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    return asyncValue.when(
      data: (data) {
        // We expect T to have a 'blueprints' property and 'isOfflineFallback' flag.
        // This is the standard for PrimeCare ViewModels.
        List<UIComponentBlueprint> blueprints = [];
        bool isOffline = false;

        if (data is Map) {
          blueprints =
              (data['blueprints'] as List<dynamic>?)
                  ?.cast<UIComponentBlueprint>() ??
              [];
          isOffline = (data['isOfflineFallback'] as bool?) ?? false;
        } else {
          final dynamic d = data;
          try {
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
