// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
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