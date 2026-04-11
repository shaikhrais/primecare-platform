import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import '../assembly_line/assembly_line.dart';
import 'layout/prime_responsive_grid.dart';

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
    required AutoDisposeStreamProvider<T> provider,
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
    return Scaffold(
      backgroundColor: Colors.transparent, // Assumes a background wrapper exists
      appBar: AppBar(
        title: Text(title, key: const Key('page_title')),
        actions: actionButton != null ? [actionButton!] : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Text(
                    subtitle!,
                    key: const Key('page_subtitle'),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
              if (kpiCards != null) ...[
                PrimeResponsiveGrid(
                  key: const Key('kpi_grid'),
                  desktopMainAxisExtent: 160,
                  children: kpiCards!,
                ),
                const SizedBox(height: 48),
              ],
              if (child != null) child!,
              if (bodySections != null) ...bodySections!,
              if (footer != null) ...[
                const SizedBox(height: 64),
                footer!,
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
  final AutoDisposeStreamProvider<T> provider;

  const _OrchestratedPage({
    required this.title,
    this.subtitle,
    this.icon,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);

    return asyncValue.when(
      data: (data) {
        // We expect T to have a 'blueprints' property and 'isOfflineFallback' flag.
        // This is the standard for PrimeCare ViewModels.
        final dynamic d = data;
        final blueprints = (d.blueprints as List<dynamic>?)?.cast<UIComponentBlueprint>() ?? [];
        final isOffline = (d.isOfflineFallback as bool?) ?? false;

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
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(80.0),
          child: CircularProgressIndicator(
            color: Colors.tealAccent,
            strokeWidth: 3,
          ),
        ),
      ),
      error: (err, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
              const SizedBox(height: 16),
              Text(
                'Orchestration Error: $err',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
