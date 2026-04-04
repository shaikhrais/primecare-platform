import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class TreatmentNotesView extends ConsumerStatefulWidget {
  const TreatmentNotesView({super.key});

  @override
  ConsumerState<TreatmentNotesView> createState() => _TreatmentNotesViewState();
}

class _TreatmentNotesViewState extends ConsumerState<TreatmentNotesView> {
  final _subjectiveController = TextEditingController();
  final _objectiveController = TextEditingController();
  final _assessmentController = TextEditingController();
  final _planController = TextEditingController();
  
  bool _medsReconciled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Clinical Treatment Notes',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit',
            color: AppTheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'SYNCED',
                  style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ),
          ),
        ],
      ),
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PATIENT HEADER
              _buildPatientHeader(theme),
              const SizedBox(height: 32),

              // CLINICAL VITALS HUD
              Text('Current Patient Vitals', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Blood Pressure', value: '128/82', icon: Icons.monitor_heart, iconColor: Colors.teal, subtitle: 'Last: 09:00 AM')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Heart Rate', value: '74 bpm', icon: Icons.favorite, iconColor: Colors.red, subtitle: 'Stable')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'SpO2', value: '98%', icon: Icons.air, iconColor: Colors.blue, subtitle: 'Room Air')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Temp', value: '36.7°C', icon: Icons.thermostat, iconColor: Colors.orange, subtitle: 'Oral')),
                ],
              ),

              const SizedBox(height: 32),

              // MEDICATION RECONCILIATION
              GlassSurface(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    const Icon(Icons.medication_liquid, color: AppTheme.primary),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Medication Reconciliation', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Verify all current meds from the MAR before signing note.', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _medsReconciled, 
                      onChanged: (v) => setState(() => _medsReconciled = v),
                      activeTrackColor: Colors.teal,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // SOAP NOTE EDITOR
              Text('Progress Note (SOAP)', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildSoapField('Subjective', 'Patient reports mild discomfort in left shoulder...', _subjectiveController),
              _buildSoapField('Objective', 'Incision site is clean, dry, and intact. No redness...', _objectiveController),
              _buildSoapField('Assessment', 'Post-Op recovery proceeding as expected. Vitals stable...', _assessmentController),
              _buildSoapField('Plan', 'Continue prescribed medication cycle. Scheduled physio at 3 PM...', _planController),

              const SizedBox(height: 48),

              // ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(key: const Key('data-status-id=clinic-rn-treatment-action-1'), 
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Save Logic
                    }, 
                    icon: const Icon(Icons.draw),
                    label: const Text('Save & Sign Note'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientHeader(ThemeData theme) {
    return GlassSurface(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppTheme.primary,
            child: Text('AD', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Arthur Dent', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const Text('DOB: 12/05/1978 (45 Yrs) | MRN: #4489221', style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.teal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('ACTIVE ADMISSION', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildSoapField(String title, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 13)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: null,
            minLines: 3,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.blueGrey.withValues(alpha: 0.5)),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blueGrey.withValues(alpha: 0.1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blueGrey.withValues(alpha: 0.1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
