import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class PhysioNotesView extends ConsumerStatefulWidget {
  const PhysioNotesView({super.key});

  @override
  ConsumerState<PhysioNotesView> createState() => _PhysioNotesViewState();
}

class _PhysioNotesViewState extends ConsumerState<PhysioNotesView> {
  final _subjectiveController = TextEditingController();
  final _objectiveController = TextEditingController();
  final _assessmentController = TextEditingController();
  final _planController = TextEditingController();
  
  bool _contraindicationsReconciled = false;

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
          'Physiotherapy Clinical Notes',
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
              Text('Functional Mobility Baseline', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Pain Scale', value: '6/10', icon: Icons.personal_injury, iconColor: Colors.red, subtitle: 'Lumbar Flexion')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Weight Bearing', value: 'PWB', icon: Icons.directions_walk, iconColor: Colors.indigo, subtitle: 'Right Lower Extremity')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Berg Balance Scale', value: '42/56', icon: Icons.monitor_weight, iconColor: Colors.orange, subtitle: 'Low Fall Risk')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'O2 Saturation', value: '97%', icon: Icons.air, iconColor: Colors.blue, subtitle: 'Post-Activity')),
                ],
              ),

              const SizedBox(height: 32),

              // SAFETY RECONCILIATION
              GlassSurface(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppTheme.primary),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Post-Op Contraindications Verification', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Verify that specific surgical movement restrictions (e.g., hip precautions) are maintained during session.', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _contraindicationsReconciled, 
                      onChanged: (v) => setState(() => _contraindicationsReconciled = v),
                      activeTrackColor: Colors.teal,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // SOAP NOTE EDITOR
              Text('Physiotherapy Note (SOAP)', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildSoapField('Subjective', 'Patient reports increased mobility but sharp pain when ascending stairs...', _subjectiveController),
              _buildSoapField('Objective', 'Active knee flexion measured at 95° via goniometer. Quad strength 3+/5...', _objectiveController),
              _buildSoapField('Assessment', 'Progressing well through Phase 2 rehab protocol. Mild patellar tracking deviation noted...', _assessmentController),
              _buildSoapField('Plan', 'Introduce closed-chain kinetic exercises. Recommend icing post-activity. Next session Friday...', _planController),

              const SizedBox(height: 48),

              // ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(key: const Key('data-status-id=clinic-physio-physio-action-1'), 
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {}, 
                    icon: const Icon(Icons.draw),
                    label: const Text('Save & Sign Physio Note'),
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
            child: const Text('ACTIVE REHAB', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)),
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
