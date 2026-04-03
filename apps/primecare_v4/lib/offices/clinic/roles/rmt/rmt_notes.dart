import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class RmtNotesView extends ConsumerStatefulWidget {
  const RmtNotesView({Key? key}) : super(key: key);

  @override
  ConsumerState<RmtNotesView> createState() => _RmtNotesViewState();
}

class _RmtNotesViewState extends ConsumerState<RmtNotesView> {
  final _subjectiveController = TextEditingController();
  final _objectiveController = TextEditingController();
  final _assessmentController = TextEditingController();
  final _planController = TextEditingController();
  
  bool _consentReconciled = false;

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
          'Registered Massage Therapy Notes',
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
                  color: Colors.teal.withOpacity(0.1),
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
              Text('Musculoskeletal & Pain Baseline', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Pain Scale', value: '4/10', icon: Icons.personal_injury, iconColor: Colors.red, subtitle: 'Cervical Spine')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Tissue Tension', value: 'High', icon: Icons.back_hand, iconColor: Colors.orange, subtitle: 'Upper Trapezius')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'ROM Limitation', value: '-15°', icon: Icons.accessibility_new, iconColor: Colors.indigo, subtitle: 'Cervical Rotation')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Edema', value: 'Trace', icon: Icons.water_drop, iconColor: Colors.blue, subtitle: 'Bilateral Upper Extremity')),
                ],
              ),

              const SizedBox(height: 32),

              // SAFETY RECONCILIATION
              GlassSurface(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    const Icon(Icons.playlist_add_check_circle, color: AppTheme.primary),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Consent & Draping Protocol Verification', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Verify that informed consent for specific body areas and professional draping standards were applied.', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _consentReconciled, 
                      onChanged: (v) => setState(() => _consentReconciled = v),
                      activeColor: Colors.teal,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // SOAP NOTE EDITOR
              Text('Massage Therapy Note (SOAP)', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildSoapField('Subjective', 'Patient reports chronic stiffness in neck and shoulders following long hours at desk...', _subjectiveController),
              _buildSoapField('Objective', 'Hypertonicity palpated in bilateral upper trapezius and levator scapulae. Trigger points active...', _objectiveController),
              _buildSoapField('Assessment', 'Myofascial restriction and tension headaches secondary to postural strain. Good response to deep tissue work...', _assessmentController),
              _buildSoapField('Plan', 'Continue bi-weekly RMT for 4 weeks. Instructed patient on daily pectoral stretches...', _planController),

              const SizedBox(height: 48),

              // ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {}, 
                    icon: const Icon(Icons.draw),
                    label: const Text('Save & Sign RMT Note'),
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
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('ACTIVE TREATMENT', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)),
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
              hintStyle: TextStyle(color: Colors.blueGrey.withOpacity(0.5)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
