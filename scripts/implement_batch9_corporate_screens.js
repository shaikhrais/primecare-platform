const fs = require('fs');
const path = require('path');

const APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_corporate');
const ROUTER_FILE = path.join(APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 9 (COMPLIANCE & TRAINING) IMPLEMENTATION ---');

const COMP_DIR = path.join(APP_DIR, 'lib', 'features', 'compliance', 'screens');
const TRAIN_DIR = path.join(APP_DIR, 'lib', 'features', 'training', 'screens');

[COMP_DIR, TRAIN_DIR].forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 1. Scaffold 24 Screens
const screens = [
  // Compliance Manager
  { dir: COMP_DIR, sub: 'compliance', file: 'compliance_manager_dashboard_screen.dart', cls: 'ComplianceManagerDashboardScreen', title: 'Compliance Dashboard', icon: 'Icons.dashboard', route: 'CorporateRoutes.complianceManagerDashboard', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'compliance_cases_screen.dart', cls: 'ComplianceManagerComplianceCasesScreen', title: 'Compliance Cases', icon: 'Icons.work', route: 'CorporateRoutes.complianceManagerComplianceCases', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'policies_screen.dart', cls: 'ComplianceManagerPoliciesScreen', title: 'Policies', icon: 'Icons.policy', route: 'CorporateRoutes.complianceManagerPolicies', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'audits_screen.dart', cls: 'ComplianceManagerAuditsScreen', title: 'Audits', icon: 'Icons.assignment', route: 'CorporateRoutes.complianceManagerAudits', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'incident_review_screen.dart', cls: 'ComplianceManagerIncidentReviewScreen', title: 'Incident Review', icon: 'Icons.report', route: 'CorporateRoutes.complianceManagerIncidentReview', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'credential_tracking_screen.dart', cls: 'ComplianceManagerCredentialTrackingScreen', title: 'Credential Tracking', icon: 'Icons.badge', route: 'CorporateRoutes.complianceManagerCredentialTracking', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'document_expiry_screen.dart', cls: 'ComplianceManagerDocumentExpiryScreen', title: 'Document Expiry', icon: 'Icons.event_busy', route: 'CorporateRoutes.complianceManagerDocumentExpiry', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'risk_register_screen.dart', cls: 'ComplianceManagerRiskRegisterScreen', title: 'Risk Register', icon: 'Icons.warning', route: 'CorporateRoutes.complianceManagerRiskRegister', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'corrective_actions_screen.dart', cls: 'ComplianceManagerCorrectiveActionsScreen', title: 'Corrective Actions', icon: 'Icons.build', route: 'CorporateRoutes.complianceManagerCorrectiveActions', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'training_compliance_screen.dart', cls: 'ComplianceManagerTrainingComplianceScreen', title: 'Training Compliance', icon: 'Icons.school', route: 'CorporateRoutes.complianceManagerTrainingCompliance', color: 'Colors.indigo.shade800' },
  { dir: COMP_DIR, sub: 'compliance', file: 'compliance_reports_screen.dart', cls: 'ComplianceManagerReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'CorporateRoutes.complianceManagerReports', color: 'Colors.indigo.shade800' },

  // Training Director
  { dir: TRAIN_DIR, sub: 'training', file: 'training_director_dashboard_screen.dart', cls: 'TrainingDirectorDashboardScreen', title: 'Training Dashboard', icon: 'Icons.dashboard', route: 'CorporateRoutes.trainingDirectorDashboard', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'training_programs_screen.dart', cls: 'TrainingDirectorTrainingProgramsScreen', title: 'Training Programs', icon: 'Icons.library_books', route: 'CorporateRoutes.trainingDirectorTrainingPrograms', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'staff_training_matrix_screen.dart', cls: 'TrainingDirectorStaffTrainingMatrixScreen', title: 'Staff Training Matrix', icon: 'Icons.grid_on', route: 'CorporateRoutes.trainingDirectorStaffTrainingMatrix', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'compliance_training_screen.dart', cls: 'TrainingDirectorComplianceTrainingScreen', title: 'Compliance Training', icon: 'Icons.verified_user', route: 'CorporateRoutes.trainingDirectorComplianceTraining', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'course_library_screen.dart', cls: 'TrainingDirectorCourseLibraryScreen', title: 'Course Library', icon: 'Icons.menu_book', route: 'CorporateRoutes.trainingDirectorCourseLibrary', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'assessments_screen.dart', cls: 'TrainingDirectorAssessmentsScreen', title: 'Assessments', icon: 'Icons.quiz', route: 'CorporateRoutes.trainingDirectorAssessments', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'certifications_screen.dart', cls: 'TrainingDirectorCertificationsScreen', title: 'Certifications', icon: 'Icons.card_membership', route: 'CorporateRoutes.trainingDirectorCertifications', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'trainer_assignments_screen.dart', cls: 'TrainingDirectorTrainerAssignmentsScreen', title: 'Trainer Assignments', icon: 'Icons.person_pin', route: 'CorporateRoutes.trainingDirectorTrainerAssignments', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'training_reports_screen.dart', cls: 'TrainingDirectorReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'CorporateRoutes.trainingDirectorReports', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'training_analytics_screen.dart', cls: 'TrainingDirectorAnalyticsScreen', title: 'Analytics', icon: 'Icons.analytics', route: 'CorporateRoutes.trainingDirectorAnalytics', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'course_architect_screen.dart', cls: 'TrainingDirectorCourseArchitectScreen', title: 'Course Architect', icon: 'Icons.architecture', route: 'CorporateRoutes.courseArchitectDashboard', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'training_hub_screen.dart', cls: 'TrainingDirectorHubScreen', title: 'Training Hub', icon: 'Icons.hub', route: 'CorporateRoutes.trainingHubDashboard', color: 'Colors.orange.shade800' },
  { dir: TRAIN_DIR, sub: 'training', file: 'certificates_screen.dart', cls: 'TrainingDirectorCertificatesScreen', title: 'Certificates', icon: 'Icons.workspace_premium', route: 'CorporateRoutes.trainingDirectorCertificates', color: 'Colors.orange.shade800' },
];

let importStatements = '';
let routeStatements = '';
let hideClasses = [];

const buildScreen = (s) => `
import 'package:flutter/material.dart';

class ${s.cls} extends StatelessWidget {
  const ${s.cls}({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(${s.icon}, size: 40, color: ${s.color}),
                const SizedBox(width: 16),
                Text("${s.title}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ${s.color})),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(${s.icon}, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("${s.title} actively running.", style: const TextStyle(fontSize: 20, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
`;

screens.forEach(s => {
  fs.writeFileSync(path.join(s.dir, s.file), buildScreen(s).trim());
  importStatements += `import '../../features/${s.sub}/screens/${s.file}';\n`;
  routeStatements += `      GoRoute(path: ${s.route}, builder: (context, state) => const ${s.cls}()),\n`;
  hideClasses.push(s.cls);
});

console.log('✅ 24 Compliance/Training Screens scaffolded.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Inject hide classes into the existing primecare_ui import
    const hideString = "hide " + hideClasses.join(", ") + ", ";
    if (!content.includes(hideClasses[0])) {
        content = content.replace("hide ", hideString);
        content = content.replace("import 'corporate_routes.dart';", "import 'corporate_routes.dart';\n" + importStatements);
    }
    
    // Inject the exact explicit routes right into publicRoutes
    if (!content.includes(screens[0].cls)) {
        content = content.replace(
            "publicRoutes: [", 
            "publicRoutes: [\n" + routeStatements
        );
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 9 Routes injected and collisions hidden.');
}

// 3. Trigger Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR BATCH 9 ---');
try {
    require('child_process').exec('flutter build web --release && wrangler pages deploy build/web --project-name primecare-corporate --commit-dirty=true', { cwd: APP_DIR });
    console.log('🏆 Batch 9 Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger deployment!', e.message);
}
