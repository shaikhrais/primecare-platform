const fs = require('fs');
const path = require('path');

const UI_PACKAGE_PATH = path.join(__dirname, '..', 'packages', 'primecare_ui', 'lib', 'src', 'screens');
const ROLES_DIR = path.join(UI_PACKAGE_PATH, 'roles');

// Helper to convert snake_case to PascalCase
const toPascalCase = (str) => {
  return str.split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join('');
};

const newRoles = {
  admin: {
    daily: ['system_health_dashboard', 'user_access_requests', 'support_tickets'],
    weekly: ['platform_usage_report', 'billing_reconciliation', 'security_audit'],
    monthly: ['revenue_summary', 'vendor_invoices', 'compliance_report'],
    yearly: ['annual_budget_review', 'contract_renewals']
  },
  doctor: {
    daily: ['appointment_schedule', 'patient_charts', 'prescription_approvals'],
    weekly: ['lab_results_review', 'referral_management', 'peer_consultations'],
    monthly: ['continuing_education', 'department_metrics', 'patient_outcomes'],
    yearly: ['license_renewal', 'medical_board_review']
  },
  nurse: {
    daily: ['patient_rounds', 'medication_administration', 'vitals_monitoring'],
    weekly: ['supply_inventory', 'shift_planning', 'incident_reports'],
    monthly: ['protocol_updates', 'equipment_maintenance'],
    yearly: ['cpr_certification', 'annual_competency_assessment']
  },
  patient: {
    daily: ['symptom_tracker', 'medication_reminder', 'diet_log'],
    weekly: ['telehealth_visit', 'health_summary', 'message_provider'],
    monthly: ['refill_requests', 'billing_statements'],
    yearly: ['annual_physical_booking', 'insurance_verification']
  }
};

function generateRoleStructure() {
  if (!fs.existsSync(ROLES_DIR)) fs.mkdirSync(ROLES_DIR, { recursive: true });

  for (const [role, frequencies] of Object.entries(newRoles)) {
    const roleDir = path.join(ROLES_DIR, role);
    if (!fs.existsSync(roleDir)) fs.mkdirSync(roleDir);

    for (const [freq, features] of Object.entries(frequencies)) {
      const freqDir = path.join(roleDir, freq);
      if (!fs.existsSync(freqDir)) fs.mkdirSync(freqDir);

      for (const feature of features) {
        const featureDir = path.join(freqDir, feature);
        if (!fs.existsSync(featureDir)) fs.mkdirSync(featureDir);

        const className = toPascalCase(feature);

        // Generate View
        const viewPath = path.join(featureDir, `${feature}_view.dart`);
        if (!fs.existsSync(viewPath)) {
          fs.writeFileSync(viewPath, `
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '${feature}_controller.dart';

class ${className}View extends ConsumerWidget {
  const ${className}View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(${className}ControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('${className}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('${className} Screen'),
            ElevatedButton(
              onPressed: () => ref.read(${className}ControllerProvider.notifier).performAction(),
              child: const Text('Execute Task'),
            )
          ],
        ),
      ),
    );
  }
}
`);
        }

        // Generate Controller
        const controllerPath = path.join(featureDir, `${feature}_controller.dart`);
        if (!fs.existsSync(controllerPath)) {
          fs.writeFileSync(controllerPath, `
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '${feature}_service.dart';

part '${feature}_controller.g.dart';

@riverpod
class ${className}Controller extends _$${className}Controller {
  @override
  FutureOr<void> build() {
    // Initial state
  }

  Future<void> performAction() async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(${feature}ServiceProvider);
      await service.executeLogic();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
`);
        }

        // Generate Service
        const servicePath = path.join(featureDir, `${feature}_service.dart`);
        if (!fs.existsSync(servicePath)) {
          fs.writeFileSync(servicePath, `
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${feature}_service.g.dart';

@riverpod
${className}Service ${feature}Service(${className}ServiceRef ref) {
  return ${className}Service();
}

class ${className}Service {
  Future<void> executeLogic() async {
    // TODO: Implement business logic for ${className}
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
`);
        }
      }
    }
    console.log(`Generated structure, views, and logic for role: ${role}`);
  }
}

generateRoleStructure();
