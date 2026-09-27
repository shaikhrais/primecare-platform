const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLIENT_DIR = path.join(__dirname, '..', 'apps', 'primecare_client');
const ROUTER_FILE = path.join(CLIENT_DIR, 'lib', 'core', 'routing', 'app_router.dart');
const ROUTES_FILE = path.join(CLIENT_DIR, 'lib', 'core', 'routing', 'client_routes.dart');

console.log('--- STARTING BATCH 4 (CLIENT PORTAL) IMPLEMENTATION ---');

const PATIENT_DIR = path.join(CLIENT_DIR, 'lib', 'features', 'patient', 'screens');
const FAMILY_DIR = path.join(CLIENT_DIR, 'lib', 'features', 'family', 'screens');
if (!fs.existsSync(PATIENT_DIR)) fs.mkdirSync(PATIENT_DIR, { recursive: true });
if (!fs.existsSync(FAMILY_DIR)) fs.mkdirSync(FAMILY_DIR, { recursive: true });

// 1. Scaffold 13 Screens
const patientScreens = [
  { file: 'patient_dashboard_screen.dart', cls: 'PatientDashboardScreen', title: 'My Health Dashboard', icon: 'Icons.favorite', route: '/offices/client/roles/client/dashboard' },
  { file: 'patient_book_appointment_screen.dart', cls: 'PatientBookAppointmentScreen', title: 'Book Appointment', icon: 'Icons.event_available', route: '/offices/client/roles/client/book-appointment' },
  { file: 'patient_my_appointments_screen.dart', cls: 'PatientMyAppointmentsScreen', title: 'My Appointments', icon: 'Icons.calendar_month', route: '/offices/client/roles/client/my-appointments' },
  { file: 'patient_care_team_screen.dart', cls: 'PatientCareTeamScreen', title: 'My Care Team', icon: 'Icons.medical_services', route: '/offices/client/roles/client/care-team' },
  { file: 'patient_treatment_history_screen.dart', cls: 'PatientTreatmentHistoryScreen', title: 'Treatment History', icon: 'Icons.history', route: '/offices/client/roles/client/treatment-history' },
  { file: 'patient_payments_screen.dart', cls: 'PatientPaymentsScreen', title: 'Billing & Payments', icon: 'Icons.payment', route: '/offices/client/roles/client/payments' },
  { file: 'patient_profile_screen.dart', cls: 'PatientProfileScreen', title: 'My Profile', icon: 'Icons.person', route: '/offices/client/roles/client/profile' },
];

const familyScreens = [
  { file: 'family_dashboard_screen.dart', cls: 'FamilyDashboardScreen', title: 'Family Dashboard', icon: 'Icons.family_restroom', route: '/offices/client/roles/family_member/dashboard' },
  { file: 'family_loved_one_schedule_screen.dart', cls: 'FamilyLovedOneScheduleScreen', title: "Loved One's Schedule", icon: 'Icons.schedule', route: '/offices/client/roles/family_member/loved-one-schedule' },
  { file: 'family_care_updates_screen.dart', cls: 'FamilyCareUpdatesScreen', title: 'Care Updates', icon: 'Icons.update', route: '/offices/client/roles/family_member/care-updates' },
  { file: 'family_billing_screen.dart', cls: 'FamilyBillingScreen', title: 'Family Billing', icon: 'Icons.receipt', route: '/offices/client/roles/family_member/billing' },
  { file: 'family_emergency_contacts_screen.dart', cls: 'FamilyEmergencyContactsScreen', title: 'Emergency Contacts', icon: 'Icons.contact_phone', route: '/offices/client/roles/family_member/emergency-contacts' },
  { file: 'family_profile_screen.dart', cls: 'FamilyProfileScreen', title: 'My Profile', icon: 'Icons.manage_accounts', route: '/offices/client/roles/family_member/profile' },
];

let importStatements = '';
let routeStatements = '';

const buildScreen = (s, color) => `
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
                const Icon(${s.icon}, size: 40, color: ${color}),
                const SizedBox(width: 16),
                Text('${s.title}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ${color})),
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
                      Text('${s.title} is active.', style: const TextStyle(fontSize: 20, color: Colors.black54)),
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

patientScreens.forEach(s => {
  fs.writeFileSync(path.join(PATIENT_DIR, s.file), buildScreen(s, 'Colors.blue').trim());
  importStatements += `import '../../features/patient/screens/${s.file}';\n`;
  routeStatements += `      GoRoute(path: '${s.route}', builder: (context, state) => const ${s.cls}()),\n`;
});

familyScreens.forEach(s => {
  fs.writeFileSync(path.join(FAMILY_DIR, s.file), buildScreen(s, 'Colors.purple').trim());
  importStatements += `import '../../features/family/screens/${s.file}';\n`;
  routeStatements += `      GoRoute(path: '${s.route}', builder: (context, state) => const ${s.cls}()),\n`;
});

console.log('✅ 13 Client Portal Screens scaffolded.');

// 2. Overwrite client_routes.dart to build the proper sidebar menus
const newRoutesFile = `
import 'package:primecare_ui/primecare_ui.dart';

class ClientTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_client';
  @override
  String get name => 'PrimeCare Client Portal';
  @override
  ThemeData get branding => PrimeThemeData(
        colors: const PrimeColors().copyWith(
          primary: const Color(0xFF0EA5E9),
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFE0F2FE),
        ),
      ).toThemeData();
}

class ClientPatientModule extends PlatformModule {
  @override
  String get moduleId => 'client_patient';
  @override
  String get name => 'My Care';
  @override
  IconData get icon => Icons.health_and_safety;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.patient, PlatformRole.client, PlatformRole.guest];
  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(title: 'Patient Dashboard', route: ClientRoutes.patientDashboard, icon: Icons.dashboard),
    PrimeCareScreen(title: 'Book Appointment', route: ClientRoutes.clientBookAppointment, icon: Icons.event),
    PrimeCareScreen(title: 'My Appointments', route: ClientRoutes.clientMyAppointments, icon: Icons.calendar_month),
    PrimeCareScreen(title: 'My Care Team', route: ClientRoutes.clientCareTeam, icon: Icons.medical_services),
    PrimeCareScreen(title: 'Treatment History', route: ClientRoutes.clientTreatmentHistory, icon: Icons.history),
    PrimeCareScreen(title: 'Billing & Payments', route: ClientRoutes.clientPayments, icon: Icons.payment),
    PrimeCareScreen(title: 'My Profile', route: ClientRoutes.clientProfile, icon: Icons.person),
  ];
}

class ClientFamilyModule extends PlatformModule {
  @override
  String get moduleId => 'client_family';
  @override
  String get name => 'Family Portal';
  @override
  IconData get icon => Icons.family_restroom;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.familyMember];
  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(title: 'Family Dashboard', route: ClientRoutes.familyMemberDashboard, icon: Icons.dashboard),
    PrimeCareScreen(title: "Loved One's Schedule", route: ClientRoutes.familyMemberLovedOneSchedule, icon: Icons.schedule),
    PrimeCareScreen(title: 'Care Updates', route: ClientRoutes.familyMemberCareUpdates, icon: Icons.update),
    PrimeCareScreen(title: 'Billing', route: ClientRoutes.familyMemberBilling, icon: Icons.receipt),
    PrimeCareScreen(title: 'Emergency Contacts', route: ClientRoutes.familyMemberEmergencyContacts, icon: Icons.contact_phone),
    PrimeCareScreen(title: 'My Profile', route: ClientRoutes.familyMemberProfile, icon: Icons.person),
  ];
}

class ClientApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_client';
  @override
  String get name => 'PrimeCare Client Portal';
  @override
  PlatformTenant get tenant => ClientTenant();
  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.patient,
          dashboardRoute: ClientRoutes.patientDashboard,
          modules: [ClientPatientModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.familyMember,
          dashboardRoute: ClientRoutes.familyMemberDashboard,
          modules: [ClientFamilyModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.client,
          dashboardRoute: ClientRoutes.patientDashboard,
          modules: [ClientPatientModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.guest,
          dashboardRoute: ClientRoutes.patientDashboard,
          modules: [ClientPatientModule()],
        ),
      ];
}
`;
fs.writeFileSync(ROUTES_FILE, newRoutesFile.trim(), 'utf8');
console.log('✅ Overwrote client_routes.dart with proper Architecture.');

// 3. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Add imports
    if (!content.includes('patient_dashboard_screen.dart')) {
        content = content.replace("import 'client_routes.dart';", "import 'client_routes.dart';\n" + importStatements);
    }
    
    // Add routes
    if (!content.includes('/offices/client/roles/client/dashboard')) {
        content = content.replace("publicRoutes: [", "publicRoutes: [\n" + routeStatements);
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 4 Routes injected into app_router.dart.');
}

// 4. Trigger Build & Deploy
console.log('--- BUILDING AND DEPLOYING BATCH 4 (CLIENT PORTAL) ---');
try {
    execSync('flutter build web --release', { cwd: CLIENT_DIR, stdio: 'inherit' });
    execSync('wrangler pages deploy build/web --project-name primecare-client --commit-dirty=true', { cwd: CLIENT_DIR, stdio: 'inherit' });
    console.log('🏆 Batch 4 (Client Portal) Deployed Successfully!');
} catch (e) {
    console.error('❌ Build/Deploy Failed!', e.message);
}
