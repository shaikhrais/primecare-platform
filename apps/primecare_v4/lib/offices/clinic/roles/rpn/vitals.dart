import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnVitalsScreen extends ConsumerStatefulWidget {
  const RpnVitalsScreen({super.key});

  @override
  ConsumerState<RpnVitalsScreen> createState() => _RpnVitalsScreenState();
}

class _RpnVitalsScreenState extends ConsumerState<RpnVitalsScreen> {
  final TextEditingController _bpSysController = TextEditingController();
  final TextEditingController _bpDiaController = TextEditingController();
  final TextEditingController _hrController = TextEditingController();
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _o2Controller = TextEditingController();
  final TextEditingController _respController = TextEditingController();

  @override
  void dispose() {
    _bpSysController.dispose();
    _bpDiaController.dispose();
    _hrController.dispose();
    _tempController.dispose();
    _o2Controller.dispose();
    _respController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Patient Vitals',
      subtitle: 'Monitor trends and record new vital sign metrics',
      icon: LucideIcons.activity,
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.history),
          onPressed: () {},
          tooltip: 'Full History Log',
        ),
      ],
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Vitals Trends & Recent Recordings
          Expanded(
            flex: 5,
            child: ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Trends',
                        style: PrimeCareTheme.titleLarge,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: PrimeCareTheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(PrimeCareTheme.radiusFull),
                        ),
                        child: Text(
                          'Last 24 Hours',
                          style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing5),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildVitalTrendCard(
                          title: 'Blood Pressure',
                          value: '118/76',
                          unit: 'mmHg',
                          status: 'Normal',
                          icon: LucideIcons.heart,
                          isAlert: false,
                        ),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        _buildVitalTrendCard(
                          title: 'Heart Rate',
                          value: '88',
                          unit: 'bpm',
                          status: 'Elevated Baseline',
                          icon: LucideIcons.activity,
                          isAlert: false,
                        ),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        _buildVitalTrendCard(
                          title: 'Temperature',
                          value: '38.2',
                          unit: '°C',
                          status: 'Low Grade Fever',
                          icon: LucideIcons.thermometer,
                          isAlert: true,
                        ),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        _buildVitalTrendCard(
                          title: 'SpO2',
                          value: '98',
                          unit: '%',
                          status: 'Optimal',
                          icon: LucideIcons.wind,
                          isAlert: false,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: PrimeCareTheme.spacing5),
          // Right Side: Input Form
          Expanded(
            flex: 4,
            child: ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Record Vitals', style: PrimeCareTheme.titleLarge),
                    const SizedBox(height: PrimeCareTheme.spacing2),
                    Text(
                      'Log current metrics for patient record',
                      style: PrimeCareTheme.bodyMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: PrimeCareTheme.spacing5),
                    
                    Row(
                      children: [
                        Expanded(child: _buildInputBox('Blood Pressure (Sys)', '120', _bpSysController, LucideIcons.arrowUpFromLine)),
                        const SizedBox(width: PrimeCareTheme.spacing3),
                        Expanded(child: _buildInputBox('BP (Dia)', '80', _bpDiaController, LucideIcons.arrowDownToLine)),
                      ],
                    ),
                    const SizedBox(height: PrimeCareTheme.spacing4),
                    _buildInputBox('Heart Rate', 'bpm', _hrController, LucideIcons.activity),
                    const SizedBox(height: PrimeCareTheme.spacing4),
                    _buildInputBox('Temperature', '°C', _tempController, LucideIcons.thermometer),
                    const SizedBox(height: PrimeCareTheme.spacing4),
                    Row(
                      children: [
                        Expanded(child: _buildInputBox('SpO2', '%', _o2Controller, LucideIcons.wind)),
                        const SizedBox(width: PrimeCareTheme.spacing3),
                        Expanded(child: _buildInputBox('Respiration', 'rpm', _respController, LucideIcons.lungs)),
                      ],
                    ),
                    
                    const SizedBox(height: PrimeCareTheme.spacing6),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [PrimeCareTheme.primary, PrimeCareTheme.primaryContainer],
                          ),
                          borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: PrimeCareTheme.spacing4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl)),
                          ),
                          child: Text(
                            'Save to Patient Record',
                            style: PrimeCareTheme.titleMedium.copyWith(color: PrimeCareTheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildVitalTrendCard({
    required String title,
    required String value,
    required String unit,
    required String status,
    required IconData icon,
    required bool isAlert,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
        boxShadow: [
          if (isAlert)
            BoxShadow(
              color: PrimeCareTheme.error.withOpacity(0.08),
              blurRadius: 24,
              spreadRadius: 2,
            )
        ],
      ),
      child: Stack(
        children: [
          if (isAlert)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
                  gradient: RadialGradient(
                    center: const Alignment(0.8, -0.8),
                    radius: 1.5,
                    colors: [
                      PrimeCareTheme.errorContainer.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAlert ? PrimeCareTheme.errorContainer : PrimeCareTheme.primaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isAlert ? PrimeCareTheme.onErrorContainer : PrimeCareTheme.onPrimaryFixed,
                    size: 24,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(value, style: PrimeCareTheme.displaySmall),
                          const SizedBox(width: 4),
                          Text(unit, style: PrimeCareTheme.bodyMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isAlert ? PrimeCareTheme.errorContainer : PrimeCareTheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(PrimeCareTheme.radiusSm),
                  ),
                  child: Text(
                    status,
                    style: PrimeCareTheme.labelSmall.copyWith(
                      color: isAlert ? PrimeCareTheme.onErrorContainer : PrimeCareTheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputBox(String label, String hint, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PrimeCareTheme.labelMedium),
        const SizedBox(height: PrimeCareTheme.spacing2),
        ClipRRect(
          borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd),
          child: ColoredBox(
            color: PrimeCareTheme.surfaceContainerLow,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: PrimeCareTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: PrimeCareTheme.bodyLarge.copyWith(color: PrimeCareTheme.outlineVariant),
                prefixIcon: Icon(icon, color: PrimeCareTheme.primaryFixedDim, size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
