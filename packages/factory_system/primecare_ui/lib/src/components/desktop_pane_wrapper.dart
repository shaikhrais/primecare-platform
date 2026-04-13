import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
import '../theme/design_system.dart';
import '../theme/theme_tokens.dart';
import 'responsive_layout_manager.dart';

class DesktopPaneWrapper extends ConsumerWidget {
  final Widget child;

  const DesktopPaneWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(layoutProvider).scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);
    return ResponsiveLayoutManager(
      mob: child,
      oneK: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1400 * scale),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: PrimeCareSpacing.scaled(40, scale),
              vertical: PrimeCareSpacing.scaled(24, scale),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ds.colors.surface,
                      borderRadius: BorderRadius.circular(
                        PrimeCareSpacing.scaled(24, scale),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ds.colors.shadow,
                          blurRadius: PrimeCareSpacing.scaled(24, scale),
                          offset: Offset(0, PrimeCareSpacing.scaled(8, scale)),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: child,
                  ),
                ),
                SizedBox(width: PrimeCareSpacing.scaled(40, scale)),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(PrimeCareSpacing.scaled(40, scale)),
                    decoration: BoxDecoration(
                      color: ds.colors.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(
                        PrimeCareSpacing.scaled(24, scale),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.shield_rounded,
                          color: ds.colors.primary,
                          size: PrimeCareSpacing.scaled(40, scale),
                        ),
                        SizedBox(height: PrimeCareSpacing.scaled(24, scale)),
                        Text(
                          'Enterprise Operation Protocol',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: ds.colors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: PrimeCareSpacing.scaled(24, scale),
                          ),
                        ),
                        SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
                        Text(
                          'Ensure all patient records, communications, and clinical inputs are verified precisely before physical transmission. All payload data is instantly encrypted locally utilizing local AES-256 blocks before transmitting securely into the PrimeCare Cloudflare node matrix.',
                          style: TextStyle(
                            height: 1.6,
                            color: ds.colors.textSecondary,
                            fontSize: PrimeCareSpacing.scaled(16, scale),
                          ),
                        ),
                        SizedBox(height: PrimeCareSpacing.scaled(32, scale)),
                        Divider(color: ds.colors.borderSubtle),
                        SizedBox(height: PrimeCareSpacing.scaled(32, scale)),
                        Row(
                          children: [
                            Icon(
                              Icons.verified_user,
                              color: ds.colors.success,
                              size: PrimeCareSpacing.scaled(24, scale),
                            ),
                            SizedBox(width: PrimeCareSpacing.scaled(16, scale)),
                            Text(
                              'End-To-End Encrypted Link',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: ds.colors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: PrimeCareSpacing.scaled(14, scale),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
