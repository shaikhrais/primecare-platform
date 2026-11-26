// Generated directly from SQLite Database (.agents/governance/governance.db)
// Screen Code: theme_fixture | Screen Name: ThemeFixtureScreen
// Target Role: Test (test) | Application: Test (test)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

final theme_fixtureDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  try {
    // API Endpoint: GET /v1/test
    final response = await api.get('/v1/test');
    if (response.data is! Map) throw const FormatException('Expected an object response');
    return Map<String, dynamic>.from(response.data as Map);
  } catch (_) {
    rethrow; // Preserve transport failures; never synthesize successful data.
  }
});

/// ThemeFixtureScreen - Governed screen implementation for Test (Test).
/// Business Purpose: Test governed data
class ThemeFixtureScreen extends GovernedConsumerWidget {
  const ThemeFixtureScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(theme_fixtureDataProvider);

    return ScreenScaffold(
      screenCode: 'theme_fixture',
      title: 'ThemeFixtureScreen',
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SPECIFIC BUSINESS PURPOSE & USER STORY HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusDefault),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimeText(
                        'Target Role: Test',
                        style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurface, fontSize: theme.scaleFont(14)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: theme.colors.success.withValues(alpha: .1), borderRadius: BorderRadius.circular(theme.radiusDefault)),
                        child: PrimeText('NOT VERIFIED', style: theme.typography.bodyMedium.copyWith(color: readableThemeForeground(Color.alphaBlend(theme.colors.success.withValues(alpha: .1), theme.colors.surface), theme.colors.success), fontSize: theme.scaleFont(10), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  PrimeText('Test governed data', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(13), height: 1.5)),
                  const SizedBox(height: 8),
                  PrimeText('User Story: Review data', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(12), fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. SPECIFIC SECTIONS RENDERED FROM DATABASE RECORDS
            
    Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusDefault),
        border: Border.all(color: theme.colors.border),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PrimeIcon(Icons.dashboard_customize_outlined, color: theme.colors.primary, size: 20),
                  const SizedBox(width: 8),
                  PrimeText(
                    "Data",
                    style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold, fontSize: theme.scaleFont(15), color: theme.colors.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(theme.radiusDefault),
                ),
                child: PrimeText(
                  'GENERAL',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.primary, fontSize: theme.scaleFont(10), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          PrimeText(
            "Review data",
            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(12)),
          ),
          const SizedBox(height: 16),
          
          ...["Review"].map((lbl) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PrimeText(
                    lbl,
                    style: theme.typography.bodyMedium.copyWith(fontSize: theme.scaleFont(13), color: theme.colors.onSurface, fontWeight: FontWeight.w500),
                  ),
                ),
                Semantics(
                  label: lbl.toLowerCase().replaceAll(' ', '_'),
                  child: PrimeButton.secondary(
                    key: Key('btn_${lbl.toLowerCase().replaceAll(' ', '_')}'),
                    label: 'Execute Action',
                    onPressed: null, // No governed action handler is implemented.
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    ),
            const SizedBox(height: 24),

            // 3. GOVERNANCE AUDIT LOG & ALL MAPPED API ENDPOINTS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colors.surfaceContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimeText('GOVERNANCE SPECIFICATIONS & ALL API ENDPOINTS', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold, fontSize: theme.scaleFont(13))),
                  const SizedBox(height: 8),
                  ...["\u2022 Mapped API: GET /v1/test"].map((apiStr) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: PrimeText(apiStr, style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(11), fontFamily: 'monospace')),
                  )),
                  const SizedBox(height: 4),
                  PrimeText('• Cypress Selector: data-cy="screen-theme-fixture"', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontSize: theme.scaleFont(12), fontFamily: 'monospace')),
                  const SizedBox(height: 4),
                  PrimeText('• Accessibility: NOT VERIFIED', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(12))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
