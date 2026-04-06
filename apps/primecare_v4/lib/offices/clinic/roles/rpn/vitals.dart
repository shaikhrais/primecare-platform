import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class VitalsScreen extends ConsumerWidget {
  const VitalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vital Signs',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Log and review ongoing patient telemetry.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.plus,
                  label: 'Record New Vitals',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recent Logs', style: PrimeCareTheme.typography.h2),
                        const SizedBox(height: 24),
                        _buildRecentLog('John Carmichael', 'BP: 140/90, HR: 88, Temp: 37.1', '10 mins ago', true),
                        const SizedBox(height: 16),
                        _buildRecentLog('Eleanor Vance', 'BP: 110/70, HR: 72, Temp: 36.8', '2 hours ago', false),
                        const SizedBox(height: 16),
                        _buildRecentLog('Sylvia Plath', 'BP: 95/60, HR: 65, Temp: 36.5', 'Yesterday', false),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 3,
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quick Entry - Patient Context', style: PrimeCareTheme.typography.h2),
                        const SizedBox(height: 24),
                        ClinicalSearchTextField(hintText: 'Select patient by name or ID...'),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(child: _buildInput('Blood Pressure', 'mmHg')),
                            const SizedBox(width: 16),
                            Expanded(child: _buildInput('Heart Rate', 'bpm')),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: _buildInput('SpO2', '%')),
                            const SizedBox(width: 16),
                            Expanded(child: _buildInput('Temperature', '°C')),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ClinicalGlassButton(
                          onPressed: () {},
                          label: 'Save Vitals',
                          isFullWidth: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLog(String patient, String summary, String time, bool abnormal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: abnormal ? PrimeCareTheme.colors.coralRed.withOpacity(0.05) : PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: abnormal ? PrimeCareTheme.colors.coralRed.withOpacity(0.3) : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                patient,
                style: PrimeCareTheme.typography.h3,
              ),
              Text(
                time,
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: PrimeCareTheme.typography.body.copyWith(
              color: abnormal ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.navyIndigo,
              fontWeight: abnormal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String label, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              Text(
                unit,
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
