import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- Clinical Atelier Aesthetic Tokens ---
const Color _bg = Color(0xFF0B1326);
const Color _surfaceVariant = Color(0xFF2D3449);
const Color _primary = Color(0xFFBCC2FF);
const Color _primaryContainer = Color(0xFF142283);
const Color _secondary = Color(0xFF70D8C8);
const Color _secondaryContainer = Color(0xFF32A192);
const Color _onSurface = Color(0xFFDAE2FD);
const Color _onSurfaceVariant = Color(0xFFC6C5D4);
const Color _outlineVariant = Color(0xFF454652);
const Color _error = Color(0xFFFFB4AB);

class CfoTaxAndRemittanceScreen extends ConsumerWidget {
  const CfoTaxAndRemittanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(cfoDashboardDataProvider('cfo_tax_and_remittance'));

    return ProviderLayout(
      child: Container(
        color: _bg,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 48),
              metricsAsyncValue.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(64.0),
                    child: CircularProgressIndicator(color: _secondary),
                  ),
                ),
                error: (error, stackTrace) => _buildErrorState(error.toString()),
                data: (CfoDashboardViewModel liveData) {
                return AssemblyLine(
                  blueprints: liveData.blueprints,
                  isOfflineFallback: liveData.isOfflineFallback,
                );
              },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TAX_HUB_TITLE'.tr(),
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 42,
                fontWeight: FontWeight.w700,
                color: _onSurface,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'TAX_HUB_SUBTITLE'.tr(),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: _onSurfaceVariant,
              ),
            ),
          ],
        ),
        _buildGradientCTA(),
      ],
    );
  }

  Widget _buildGradientCTA() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const RadialGradient(
          colors: [_primary, _primaryContainer],
          center: Alignment.topLeft,
          radius: 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryContainer.withAlpha(100),
            blurRadius: 20,
            spreadRadius: -2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.fileText, color: Color(0xFF000C62), size: 18),
                const SizedBox(width: 8),
                Text(
                  'GENERATE_REPORT'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000C62),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isHeader ? _onSurface.withAlpha(50) : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            cell,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: isHeader ? 12 : 14,
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
              color: isHeader ? _onSurfaceVariant : _onSurface,
              letterSpacing: isHeader ? 0.5 : 0,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMetricBlock(String label, String value, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: accentColor,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF93000A).withAlpha(50),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.alertTriangle, color: _error),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Failed to load live metrics: \n$error',
              style: const TextStyle(color: _error, fontFamily: 'Inter'),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: _surfaceVariant.withAlpha(153), // 60% opacity
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _outlineVariant.withAlpha(38), // 15% Ghost Border
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
