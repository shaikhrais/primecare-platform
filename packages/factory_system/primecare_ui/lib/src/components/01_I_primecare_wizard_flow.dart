// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

import 'package:primecare_ui/src/theme/01_I_design_system.dart';
import 'package:primecare_ui/src/components/01_I_primecare_card.dart';
import 'package:primecare_ui/src/components/01_I_primecare_button.dart';

class PrimeCareWizardStep {
  final String title;
  final String description;
  final IconData? icon;

  const PrimeCareWizardStep({
    required this.title,
    required this.description,
    this.icon,
  });
}

/// A standardized generic Workflow architecture mapping sequential logic directly onto the SDK grid.
/// Eliminates hardcoded list structures mapping explicit Steps identically across all physical platforms.
class PrimeCareWizardFlow extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<PrimeCareWizardStep> steps;
  final String actionLabel;
  final VoidCallback? onAction;
  final Widget? headerWidget;
  final Widget? footerWidget;

  const PrimeCareWizardFlow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.steps,
    required this.actionLabel,
    this.onAction,
    this.headerWidget,
    this.footerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PrimeCareSpacing.xl),
      children: [
        if (headerWidget != null) ...[
          headerWidget!,
          SizedBox(height: PrimeCareSpacing.xl),
        ],
        Text(
          subtitle.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: PrimeCareDesignSystem.textMuted,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: PrimeCareSpacing.xl),

        ...steps.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final step = entry.value;
          return PrimeCareCard(
            margin: const EdgeInsets.only(bottom: PrimeCareSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareCard(
                  padding: const EdgeInsets.all(PrimeCareSpacing.md),
                  child: Text(
                    '$index',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: PrimeCareSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (step.icon != null) ...[
                            Icon(
                              step.icon,
                              color: Theme.of(context).primaryColor,
                              size: 18,
                            ),
                            const SizedBox(width: PrimeCareSpacing.sm),
                          ],
                          Expanded(
                            child: Text(
                              step.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: PrimeCareSpacing.sm),
                      Text(
                        step.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: PrimeCareDesignSystem.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: PrimeCareSpacing.xxl),

        if (footerWidget != null) ...[
          footerWidget!,
          const SizedBox(height: PrimeCareSpacing.xl),
        ],

        PrimeCareButton(
          type: PrimeCareButtonType.primary,
          onPressed: onAction,
          child: Text(
            actionLabel,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
