import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// The high-fidelity rendering engine for data-driven screens.
/// It interprets the [PrimeCareScreen] and assembles the UI components.
class UniversalScreenEngine extends ConsumerWidget {
  final PrimeCareScreen screen;
  final bool useShell;

  const UniversalScreenEngine({
    super.key,
    required this.screen,
    this.useShell = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telemetry = ref.read(executionGateProvider);
    final selfHealing = ref.watch(selfHealingProvider);
    final selfHealingNotifier = ref.read(selfHealingProvider.notifier);

    // 0. Handle Safety Lockout
    if (selfHealing.isLockoutActive &&
        selfHealing.failingRouteId == screen.route) {
      if (screen.resiliencePolicy.fallbackRoute != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(screen.resiliencePolicy.fallbackRoute!);
        });
      }
    }

    telemetry.passGate(
      ExecutionGateCategory.navigationLayer,
      'UniversalScreenEngine: Hydrating ${screen.title} (${screen.route})',
    );

    // ✅ GOVERNANCE: Update institutional context so Aura knows where we are.
    // Use a microtask to avoid building during build phase.
    Future.microtask(() {
      if (ref.read(auraContextProvider) != screen.route) {
        ref.read(auraContextProvider.notifier).update(screen.route);
      }
    });

    // 1. Resolve RnData
    final data = screen.provider != null
        // ignore: argument_type_not_assignable, inference_failure_on_function_invocation
        ? ref.watch(screen.provider as dynamic)
        : null;

    // 2. Failure Reporting Hook
    if (screen.provider != null) {
      // ignore: argument_type_not_assignable
      ref.listen(screen.provider as dynamic, (previous, next) {
        if (next is AsyncValue) {
          next.when(
            data: (result) {
              if (result is Result) {
                if (result.isSuccess) {
                  selfHealingNotifier.resetRetryCount(screen.route);
                } else {
                  selfHealingNotifier.recordFailure(
                    screen.route,
                    isCritical:
                        screen.resiliencePolicy.strategy ==
                        ScreenRecoveryStrategy.globalEscalation,
                  );
                }
              }
            },
            error: (e, st) => selfHealingNotifier.recordFailure(
              screen.route,
              isCritical:
                  screen.resiliencePolicy.strategy ==
                  ScreenRecoveryStrategy.globalEscalation,
            ),
            loading: () {},
          );
        }
      });
    }

    // 3. Build Content
    Widget body;
    if (data is AsyncValue) {
      body = data.when(
        data: (resolvedData) => _buildBody(context, ref, resolvedData),
        loading: () =>
            const Center(child: PrimeCareSkeleton(width: 300, height: 200)),
        error: (err, stack) =>
            _buildResilientFallback(context, ref, err.toString()),
      );
    } else {
      body = _buildBody(context, ref, data);
    }

    // 4. Wrap in RefreshIndicator if provider exists
    if (screen.provider != null) {
      body = RefreshIndicator(
        onRefresh: () async {
          // ignore: argument_type_not_assignable
          ref.invalidate(screen.provider as dynamic);
        },
        child: body,
      );
    }

    // 5. Wrap in AuthLayout Shell (only if explicitly requested, as MasterLayout usually handles this)
    if (useShell) {
      body = BaseLayoutShell(currentPath: screen.route, child: body);
    }

    // 6. GOVERNANCE: Apply Global Modulation
    // This automatically dims/disables the screen or shows a fallback if the underlying subsystem is degraded.
    if (screen.primarySubsystem != null) {
      return WidgetModulationGovernor(
        subsystem: screen.primarySubsystem!,
        child: body,
      );
    }

    return body;
  }

  Widget _buildResilientFallback(
    BuildContext context,
    WidgetRef ref,
    String error,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.shieldAlert, size: 48, color: Colors.orange),
          const SizedBox(height: 16),
          Text(
            'Institutional Resilience Active',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(error, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          PrimeCareButton(
            // ignore: argument_type_not_assignable
            onPressed: () => ref.invalidate(screen.provider as dynamic),
            text: 'Retry Hydration',
            icon: LucideIcons.refreshCw,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, dynamic data) {
    final theme = PrimeCareTheme.of(context);

    DashboardMetrics? metrics;
    dynamic unwrappedData = data;

    // Handle Result pattern
    if (unwrappedData is Result) {
      if (unwrappedData is Success) {
        unwrappedData = unwrappedData.data;
      } else if (unwrappedData is Failure) {
        return _buildResilientFallback(
          context,
          ref,
          unwrappedData.error.toString(),
        );
      }
    }

    if (unwrappedData is DashboardMetrics) {
      metrics = unwrappedData;
    } else if (unwrappedData is FranchiseOwnerViewModel) {
      try {
        metrics = (unwrappedData as dynamic).metrics as DashboardMetrics?;
      } catch (_) {}
    }

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(), // Required for RefreshIndicator
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, theme),
          SizedBox(height: 32),
          ..._renderBlueprints(context, ref, metrics),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PrimeThemeData theme) {
    final String localizedTitle = screen.title.tr();
    final String localizedSubtitle = screen.subtitle.tr();

    // GOVERNANCE CHECK: Detect "Loose Text" bypasses in debug mode
    bool isGovernanceViolation = false;
    assert(() {
      if (screen.title.contains(' ') && !screen.title.contains('.')) {
        isGovernanceViolation = true;
      }
      return true;
    }());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              isGovernanceViolation
                  ? '⚠️ GOVERNANCE VIOLATION: ${screen.title}'
                  : localizedTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isGovernanceViolation ? Colors.red : null,
              ),
            ),
          ],
        ),
        if (screen.subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            localizedSubtitle,
            style: theme.typography.bodyLarge.copyWith(
              color: theme.colors.slateGray,
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _renderBlueprints(
    BuildContext context,
    WidgetRef ref,
    DashboardMetrics? metrics,
  ) {
    if (screen.blueprints.isEmpty && metrics != null) {
      return [
        _mapBlueprintToWidget(
          context,
          ref,
          const StatGridBlueprint(dataPayload: <Object?>[]),
          metrics,
        ),
      ];
    }

    return screen.blueprints
        .map(
          (bp) => Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _mapBlueprintToWidget(context, ref, bp, metrics),
          ),
        )
        .toList();
  }

  Widget _mapBlueprintToWidget(
    BuildContext context,
    WidgetRef ref,
    UIComponentBlueprint blueprint,
    DashboardMetrics? metrics,
  ) {
    final prefService = ref.watch(preferenceServiceProvider);

    switch (blueprint.componentType) {
      case 'aura_dashboard_hud':
        return const AuraDashboardHud();
      case 'stat_card_grid':
        List<KpiMetric> kpis = blueprint.dataPayload is List
            ? (blueprint.dataPayload as List).cast<KpiMetric>()
            : metrics?.kpis ?? <KpiMetric>[];

        // Apply Pinning Logic
        final sortedKpis = List<KpiMetric>.from(kpis)
          ..sort((a, b) {
            final aPinned =
                prefService?.isPinned(screen.name, a.title) ?? false;
            final bPinned =
                prefService?.isPinned(screen.name, b.title) ?? false;
            if (aPinned && !bPinned) return -1;
            if (!aPinned && bPinned) return 1;
            return 0;
          });

        return PrimeCareResponsiveKpiGrid(
          children: sortedKpis.map((kpi) {
            final isPinned =
                prefService?.isPinned(screen.name, kpi.title) ?? false;
            return PrimeCareKpiCard(
              title: kpi.title,
              value: kpi.value,
              subtitle: kpi.subtitle ?? '',
              isPinned: isPinned,
              onPinToggle: () async {
                await prefService?.setPinned(screen.name, kpi.title, !isPinned);
                ref.invalidate(preferenceServiceProvider);
              },
            );
          }).toList(),
        );
      case 'stitch_screen':
        final stitch = blueprint as StitchBlueprint;
        return StitchEngineRenderer(
          featureId: stitch.screenId,
          items: const [],
        );
      case 'high_fidelity_dashboard':
        final hf = blueprint as HighFidelityScreenBlueprint;
        final builder = ComponentWarehouse.getBuilder(hf.viewId);
        return builder?.call(context, blueprint.dataPayload) ??
            Center(
              child: Text(
                LocaleKeys
                    .dashboards_common_labels_high_fidelity_component_not_found____hf_viewid
                    .tr(),
              ),
            );
      case 'analytics_chart':
        final builder = ComponentWarehouse.getBuilder('primeCareLineChart');
        return builder?.call(context, blueprint.dataPayload) ??
            Center(
              child: Text(
                LocaleKeys
                    .dashboards_common_labels_line_chart_component_not_found
                    .tr(),
              ),
            );
      case 'ai_forecasting':
        final builder = ComponentWarehouse.getBuilder('aiForecastingDashlet');
        return builder?.call(context, blueprint.dataPayload) ??
            Center(
              child: Text(
                LocaleKeys
                    .dashboards_common_labels_ai_forecasting_component_not_found
                    .tr(),
              ),
            );
      default:
        // Try to find a builder matching the componentType directly in the warehouse
        final builder = ComponentWarehouse.getBuilder(blueprint.componentType);
        if (builder != null) {
          return builder(context, blueprint.dataPayload);
        }
        return Center(
          child: Text(
            LocaleKeys
                .dashboards_common_labels_unknown_component____blueprint_componenttype
                .tr(),
          ),
        );
    }
  }
}
