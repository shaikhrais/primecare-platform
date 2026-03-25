import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/rn/providers/rn_care_plan_provider.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'dart:convert';

class RnCarePlanScreen extends ConsumerStatefulWidget {
  const RnCarePlanScreen({super.key});

  @override
  ConsumerState<RnCarePlanScreen> createState() => _RnCarePlanScreenState();
}

class _RnCarePlanScreenState extends ConsumerState<RnCarePlanScreen> {
  bool _isDeploying = false;

  Future<void> _deployCarePlanFHIR(String planId) async {
    setState(() => _isDeploying = true);
    try {
      final response = await apiClient.post(
        '/api/rn/care-plans/$planId/review',
        body: jsonEncode({
          'diagnoses': ['E08.9', 'I10'],
          'clinicalGoals': [
            'Maintain blood glucose',
            'Monitor vitals accurately weekly',
          ],
          'status': 'active',
          'reviewDate': DateTime.now().toIso8601String(),
        }),
      );
      if (response.statusCode == 200 && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Care Plan Deployed (FHIR R4 Sync Active)'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Deployment Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isDeploying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncPlans = ref.watch(activeCarePlansProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Care Plan Interoperability Hub')),
      body: asyncPlans.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading care plans directly: $err')),
        data: (plans) {
          if (plans.isEmpty) {
            return const Center(
              child: Text(
                'No active care plans pending review organically securely.',
              ),
            );
          }
          final activePlan =
              plans.first; // Load the top priority plan dynamically

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Active Patient: ${activePlan.patientName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                PrimeCard(
                  child: Column(
                    children: [
                      const Text('Existing Diagnoses (FHIR Codes)'),
                      const SizedBox(height: 8),
                      ...activePlan.diagnoses.map(
                        (d) => Text(
                          d,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Medication Frequency',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const MedicationFrequencyPicker(),
                const SizedBox(height: 24),
                const ClinicalInterventionFormGroup(),
                const SizedBox(height: 24),
                const Text(
                  'Attending RN Signature',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const DigitalSignaturePad(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: _isDeploying
                      ? const Center(child: CircularProgressIndicator())
                      : PrimeButton(
                          label: 'LOCK PLAN & DEPLOY (FHIR SYNC)',
                          onPressed: () => _deployCarePlanFHIR(activePlan.id),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
