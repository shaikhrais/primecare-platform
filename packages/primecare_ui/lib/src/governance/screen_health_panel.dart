import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// A wrapper widget that overlays the "Screen Health" floating button and diagnostic panel
/// on top of the child screen content.
class ScreenHealthOverlayWrapper extends ConsumerStatefulWidget {
  final String routePath;
  final Widget child;

  const ScreenHealthOverlayWrapper({
    super.key,
    required this.routePath,
    required this.child,
  });

  @override
  ConsumerState<ScreenHealthOverlayWrapper> createState() => _ScreenHealthOverlayWrapperState();
}

class _LocaleRebuildWrapperState {}

class _ScreenHealthOverlayWrapperState extends ConsumerState<ScreenHealthOverlayWrapper> {
  bool _isPanelOpen = false;

  final Map<int, String> _stageNames = const {
    0: 'Stage 0: File Exists',
    1: 'Stage 1: Route Connected',
    2: 'Stage 2: HTML Structure',
    3: 'Stage 3: Real UI Elements',
    4: 'Stage 4: Components Wired',
    5: 'Stage 5: Business Logic',
    6: 'Stage 6: API Connected',
    7: 'Stage 7: DB Connected',
    8: 'Stage 8: Validation Implemented',
    9: 'Stage 9: User Interactions',
    10: 'Stage 10: QA Test Passed',
    11: 'Stage 11: Production Ready',
  };

  @override
  Widget build(BuildContext context) {
    // 1. Fetch current user role and verify if we are in dev/admin mode
    final auth = ref.watch(authProvider);
    final role = PlatformRole.fromName(auth.role);
    
    // Dev/admin mode logic:
    // User is IT admin, system, or admin role, OR we are in a non-release build.
    final bool isDevOrAdmin = role == PlatformRole.admin || 
                              role == PlatformRole.system || 
                              role == PlatformRole.itAdmin || 
                              kDebugMode;

    if (!isDevOrAdmin) {
      return widget.child;
    }

    final health = getScreenHealth(widget.routePath);
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The original screen widget
        Positioned.fill(child: widget.child),

        // Semi-transparent overlay backdrop behind the slide-out panel when open
        if (_isPanelOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => _isPanelOpen = false),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isPanelOpen ? 1.0 : 0.0,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),

        // Slide-out Diagnostics Panel (Glassmorphism design)
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          top: 0,
          bottom: 0,
          right: _isPanelOpen ? 0.0 : -(isMobile ? mediaQuery.size.width * 0.85 : 380.0),
          width: isMobile ? mediaQuery.size.width * 0.85 : 380.0,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 25,
                    offset: const Offset(-5, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: _buildPanelContent(context, health),
                ),
              ),
            ),
          ),
        ),

        // Floating Action Trigger Button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            mini: isMobile,
            backgroundColor: _isPanelOpen ? theme.colorScheme.error : theme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: () {
              setState(() {
                _isPanelOpen = !_isPanelOpen;
              });
            },
            child: Icon(
              _isPanelOpen ? LucideIcons.x : LucideIcons.activity,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPanelContent(BuildContext context, ScreenHealthStatus health) {
    final theme = Theme.of(context);
    final stageName = _stageNames[health.currentStage] ?? 'Unknown Stage';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Panel Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: theme.dividerColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Screen Health',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  _buildStatusPill(health.isProductionReady),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                health.screenName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                health.routePath,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),

        // Scrollable Metric Content
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Progress Section
              Text(
                'IMPLEMENTATION PROGRESS',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: health.progressPercent / 100.0,
                        minHeight: 10,
                        backgroundColor: theme.dividerColor.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getProgressColor(health.progressPercent, theme),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${health.progressPercent}%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getProgressColor(health.progressPercent, theme),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                stageName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              // Component file path
              _buildMetaField(context, 'COMPONENT FILE', health.componentFile),
              const SizedBox(height: 24),

              // Missing Items Section
              Text(
                'MISSING ITEMS',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 10),
              if (health.missingItems.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Icon(LucideIcons.checkCircle2, color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'All features fully verified and complete.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...health.missingItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(LucideIcons.minusCircle, color: Colors.amber.shade700, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // Flags Checklist
              Text(
                'FEATURE CHECKLIST',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 12),
              _buildChecklistItem(context, 'Real UI Rendered', health.hasRealUi),
              _buildChecklistItem(context, 'Active Buttons', health.hasButtons),
              _buildChecklistItem(context, 'Interactive Forms', health.hasForms),
              _buildChecklistItem(context, 'Structured Tables', health.hasTables),
              _buildChecklistItem(context, 'API Network Calls', health.hasApiCalls),
              _buildChecklistItem(context, 'DB Connectivity', health.hasDbConnection),
              _buildChecklistItem(context, 'Form Validation', health.hasValidation),
              _buildChecklistItem(context, 'Error Handling', health.hasErrorHandling),
              _buildChecklistItem(context, 'Loading States', health.hasLoadingState),
              _buildChecklistItem(context, 'Empty States', health.hasEmptyState),
            ],
          ),
        ),

        // Panel Footer
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.dividerColor.withValues(alpha: 0.03),
            border: Border(
              top: BorderSide(
                color: theme.dividerColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'NEXT ACTION REQUIRED',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.primaryColor.withValues(alpha: 0.15),
                  ),
                ),
                child: Text(
                  health.nextAction.isEmpty ? 'No action pending.' : health.nextAction,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusPill(bool isReady) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isReady ? Colors.green.withValues(alpha: 0.15) : Colors.amber.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isReady ? Colors.green.withValues(alpha: 0.3) : Colors.amber.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        isReady ? 'PRODUCTION' : 'DEVELOPMENT',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isReady ? Colors.green.shade800 : Colors.amber.shade800,
        ),
      ),
    );
  }

  Widget _buildMetaField(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: theme.hintColor,
          ),
        ),
        const SizedBox(height: 6),
        SelectableText(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontFamily: 'monospace',
            color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildChecklistItem(BuildContext context, String title, bool checked) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            checked ? LucideIcons.check : LucideIcons.x,
            color: checked ? Colors.green : Colors.red,
            size: 14,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: checked ? theme.textTheme.bodyLarge?.color : theme.hintColor,
              fontWeight: checked ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(int percent, ThemeData theme) {
    if (percent >= 100) return Colors.green;
    if (percent >= 60) return theme.primaryColor;
    if (percent >= 30) return Colors.amber;
    return Colors.red;
  }
}
