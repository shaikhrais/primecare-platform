// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_core/registry/intents/app_screen_intent.dart';
import 'package:primecare_ui/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

/// A subtle, "hidden" Architectural HUD that reveals the screen's structural plan.
/// This allows developers and auditors to verify the intended vs actual
/// component layout directly on the running application.
class GovernanceBlueprintHUD extends StatefulWidget {
  final AppScreenIntent intent;
  final Widget child;

  const GovernanceBlueprintHUD({
    super.key,
    required this.intent,
    required this.child,
  });

  @override
  State<GovernanceBlueprintHUD> createState() => _GovernanceBlueprintHUDState();
}

class _GovernanceBlueprintHUDState extends State<GovernanceBlueprintHUD> {
  bool _isVisible = false;

  void _showHUD(BuildContext context) {
    final ds = PrimeCareDesignSystem.of(context);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: ds.colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Handle
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: ds.colors.textTertiary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ds.colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      LucideIcons.layout,
                      color: ds.colors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Architectural Intent',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ds.colors.textPrimary,
                          ),
                        ),
                        Text(
                          widget.intent.route,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: ds.colors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Structural Plan
                  _buildSectionTitle(ds, 'Structural Plan'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ds.colors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ds.colors.borderSubtle),
                    ),
                    child: Text(
                      widget.intent.structuralPlan,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        height: 1.5,
                        color: ds.colors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Component Registry
                  _buildSectionTitle(ds, 'Registered Components'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.intent.componentLabels.map((label) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ds.colors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ds.colors.success.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.checkCircle,
                              size: 14,
                              color: ds.colors.success,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              label,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: ds.colors.success,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 32),

                  // Verification Meta
                  _buildSectionTitle(ds, 'Governance Metadata'),
                  const SizedBox(height: 12),
                  _buildMetaRow(
                    ds,
                    'Role Requirement',
                    widget.intent.requiredRole?.toString() ?? 'Public',
                  ),
                  _buildMetaRow(
                    ds,
                    'Resilience Policy',
                    widget.intent.resiliencePolicy.strategy.name,
                  ),
                  _buildMetaRow(
                    ds,
                    'Dependencies',
                    '${widget.intent.dependencies.length} Providers',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(PrimeCareDesignSystem ds, String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.outfit(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: ds.colors.textTertiary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildMetaRow(PrimeCareDesignSystem ds, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: ds.colors.textSecondary,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: ds.colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ds = PrimeCareDesignSystem.of(context);

    // Safety Check: HUD is only for local development/auditing
    final bool isLocal =
        Uri.base.host == 'localhost' ||
        Uri.base.host == '127.0.0.1' ||
        const bool.fromEnvironment('dart.vm.product') == false;

    return Stack(
      children: [
        widget.child,

        // Hidden HUD Trigger (Subtle floating button in bottom right)
        if (isLocal)
          Positioned(
            bottom: 24,
            right: 24,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isVisible = true),
              onExit: (_) => setState(() => _isVisible = false),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isVisible
                    ? 0.8
                    : 0.05, // Very subtle when not hovering
                child: GestureDetector(
                  onTap: () => _showHUD(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: ds.colors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: ds.colors.primary.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      LucideIcons.searchCode,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
