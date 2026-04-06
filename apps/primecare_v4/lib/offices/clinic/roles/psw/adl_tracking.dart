import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class AdlTrackingScreen extends ConsumerStatefulWidget {
  const AdlTrackingScreen({super.key});

  @override
  ConsumerState<AdlTrackingScreen> createState() => _AdlTrackingScreenState();
}

class _AdlTrackingScreenState extends ConsumerState<AdlTrackingScreen> {
  final Map<String, double> _adlScores = {
    'Bathing & Hygiene': 2.0,
    'Dressing': 3.0,
    'Feeding': 1.0,
    'Mobility': 2.0,
    'Toileting': 1.0,
  };

  @override
  Widget build(BuildContext context) {
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
                      'ADL Tracking',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Log Activities of Daily Living score out of 5 based on independence.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.save,
                  label: 'Save Scores',
                ),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: _adlScores.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key,
                              style: PrimeCareTheme.typography.h3,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: PrimeCareTheme.colors.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${entry.value.toInt()} / 5',
                                style: PrimeCareTheme.typography.label.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: PrimeCareTheme.colors.navyIndigo,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: PrimeCareTheme.colors.emeraldTeal,
                            inactiveTrackColor: PrimeCareTheme.colors.surfaceContainerHighest,
                            thumbColor: PrimeCareTheme.colors.emeraldTeal,
                            overlayColor: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.2),
                            trackHeight: 8.0,
                          ),
                          child: Slider(
                            value: entry.value,
                            min: 1,
                            max: 5,
                            divisions: 4,
                            onChanged: (value) {
                              setState(() {
                                _adlScores[entry.key] = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Dependent', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontSize: 11)),
                              Text('Independent', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
