import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/foundation.dart';

/// Standard loading state for high-fidelity dashboards.
class DashboardLoadingWidget extends StatelessWidget {
  const DashboardLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        children: [
          _buildSkeletonHeader(theme),
          SizedBox(height: theme.spacing.xl),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.5,
              ),
              itemCount: 6,
              itemBuilder: (_, __) => const PrimeCareSkeleton(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonHeader(PrimeCareThemeData theme) {
    return Row(
      children: [
        const PrimeCareSkeleton(width: 300, height: 40, borderRadius: 8),
        const Spacer(),
        const PrimeCareSkeleton(width: 120, height: 40, borderRadius: 12),
      ],
    );
  }
}

/// Standard error state for high-fidelity dashboards.
class DashboardErrorWidget extends StatefulWidget {
  final String message;
  final VoidCallback? onRetry;
  final Object? error;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? metadata;

  const DashboardErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.error,
    this.stackTrace,
    this.metadata,
  });

  @override
  State<DashboardErrorWidget> createState() => _DashboardErrorWidgetState();
}

class _DashboardErrorWidgetState extends State<DashboardErrorWidget> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Container(
            padding: EdgeInsets.all(theme.spacing.xl),
            decoration: BoxDecoration(
              color: theme.colors.error.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.colors.error.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.shieldAlert,
                  size: 48,
                  color: theme.colors.error,
                ),
                SizedBox(height: theme.spacing.lg),
                Text(
                  'Dashboard Sync Failure',
                  style: theme.typography.h3.copyWith(
                    color: theme.colors.error,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.error,
                  ),
                ),
                if (kDebugMode &&
                    (widget.error != null || widget.metadata != null)) ...[
                  SizedBox(height: theme.spacing.lg),
                  TextButton.icon(
                    onPressed: () =>
                        setState(() => _showDetails = !_showDetails),
                    icon: Icon(
                      _showDetails
                          ? LucideIcons.chevronUp
                          : LucideIcons.chevronDown,
                      size: 16,
                    ),
                    label: Text(LocaleKeys.dashboards_common_labels_developer_diagnostics
                          .tr(),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colors.error,
                    ),
                  ),
                  if (_showDetails) ...[
                    SizedBox(height: theme.spacing.md),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colors.error.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.metadata != null) ...[
                            Text(
                              'METADATA',
                              style: theme.typography.labelSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ...widget.metadata!.entries.map(
                              (e) => Text(
                                '${e.key}: ${e.value}',
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          if (widget.error != null) ...[
                            Text(
                              'ERROR',
                              style: theme.typography.labelSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SelectableText(
                              widget.error.toString(),
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: Colors.redAccent,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          if (widget.stackTrace != null) ...[
                            Text(
                              'STACK TRACE',
                              style: theme.typography.labelSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 200),
                              child: SingleChildScrollView(
                                child: SelectableText(
                                  widget.stackTrace.toString(),
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
                if (widget.onRetry != null) ...[
                  SizedBox(height: theme.spacing.xl),
                  ElevatedButton.icon(
                    onPressed: widget.onRetry,
                    icon: Icon(LucideIcons.refreshCw, size: 18),
                    label: Text(LocaleKeys.dashboards_common_labels_retry_synchronization
                          .tr(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colors.error,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A premium placeholder widget for dashboards when the Aura pulse is stable and no anomalies are present.
class AuraEventStableWidget extends StatelessWidget {
  const AuraEventStableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(theme.spacing.xl),
      decoration: BoxDecoration(
        color: theme.colors.primary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(theme.radii.lg),
        border: Border.all(color: theme.colors.primary.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.shieldCheck,
            color: theme.colors.primary.withValues(alpha: 0.4),
            size: 32,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            'SYSTEM STABLE',
            style: theme.typography.labelMedium.copyWith(
              color: theme.colors.primary.withValues(alpha: 0.6),
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: theme.spacing.xs),
          Text(
            'Aura Pulse monitoring active • No critical anomalies detected',
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.slateGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
