import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'TAX_HUB_TITLE',
        subtitle: 'TAX_HUB_SUBTITLE',
        provider: cfoDashboardDataProvider('cfo_tax_and_remittance'),
      );
}
