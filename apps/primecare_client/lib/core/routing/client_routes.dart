// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:primecare_ui/primecare_ui.dart'
    hide
        PatientDashboardScreen,
        FamilyDashboardScreen,
        PatientBookAppointmentScreen,
        PatientMyAppointmentsScreen,
        PatientCareTeamScreen,
        PatientTreatmentHistoryScreen,
        PatientPaymentsScreen,
        PatientProfileScreen,
        FamilyLovedOneScheduleScreen,
        FamilyCareUpdatesScreen,
        FamilyBillingScreen,
        FamilyEmergencyContactsScreen,
        FamilyProfileScreen;
import 'package:flutter_core/theme/theme_config_generated.dart';

import '../../features/patient/screens/patient_dashboard_screen.dart';
import '../../features/patient/screens/patient_book_appointment_screen.dart';
import '../../features/patient/screens/patient_my_appointments_screen.dart';
import '../../features/patient/screens/patient_care_team_screen.dart';
import '../../features/patient/screens/patient_treatment_history_screen.dart';
import '../../features/patient/screens/patient_payments_screen.dart';
import '../../features/patient/screens/patient_profile_screen.dart';
import '../../features/family/screens/family_dashboard_screen.dart';
import '../../features/family/screens/family_loved_one_schedule_screen.dart';
import '../../features/family/screens/family_care_updates_screen.dart';
import '../../features/family/screens/family_billing_screen.dart';
import '../../features/family/screens/family_emergency_contacts_screen.dart';
import '../../features/family/screens/family_profile_screen.dart';

class ClientTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_client';
  @override
  String get name => 'PrimeCare Client Portal';
  @override
  ThemeData get branding => PrimeThemeData(
        colors: PrimeColors.fromPalette(ThemeConfig.getAppPalette('client')),
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
  List<PlatformRole> get allowedRoles => [
        PlatformRole.patient,
        PlatformRole.client,
        PlatformRole.guest,
        PlatformRole.portal,
      ];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Patient Dashboard',
          route: ClientRoutes.patientDashboard,
          icon: Icons.dashboard,
          builder: (context) => const PatientDashboardScreen(),
        ),
        PrimeCareScreen(
          title: 'Book Appointment',
          route: ClientRoutes.clientBookAppointment,
          icon: Icons.event,
          builder: (context) => const PatientBookAppointmentScreen(),
        ),
        PrimeCareScreen(
          title: 'My Appointments',
          route: ClientRoutes.clientMyAppointments,
          icon: Icons.calendar_month,
          builder: (context) => const PatientMyAppointmentsScreen(),
        ),
        PrimeCareScreen(
          title: 'My Care Team',
          route: ClientRoutes.clientCareTeam,
          icon: Icons.medical_services,
          builder: (context) => const PatientCareTeamScreen(),
        ),
        PrimeCareScreen(
          title: 'Treatment History',
          route: ClientRoutes.clientTreatmentHistory,
          icon: Icons.history,
          builder: (context) => const PatientTreatmentHistoryScreen(),
        ),
        PrimeCareScreen(
          title: 'Billing & Payments',
          route: ClientRoutes.clientPayments,
          icon: Icons.payment,
          builder: (context) => const PatientPaymentsScreen(),
        ),
        PrimeCareScreen(
          title: 'My Profile',
          route: ClientRoutes.clientProfile,
          icon: Icons.person,
          builder: (context) => const PatientProfileScreen(),
        ),
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
        PrimeCareScreen(
          title: 'Family Dashboard',
          route: ClientRoutes.familyMemberDashboard,
          icon: Icons.dashboard,
          builder: (context) => const FamilyDashboardScreen(),
        ),
        PrimeCareScreen(
          title: "Loved One's Schedule",
          route: ClientRoutes.familyMemberLovedOneSchedule,
          icon: Icons.schedule,
          builder: (context) => const FamilyLovedOneScheduleScreen(),
        ),
        PrimeCareScreen(
          title: 'Care Updates',
          route: ClientRoutes.familyMemberCareUpdates,
          icon: Icons.update,
          builder: (context) => const FamilyCareUpdatesScreen(),
        ),
        PrimeCareScreen(
          title: 'Billing',
          route: ClientRoutes.familyMemberBilling,
          icon: Icons.receipt,
          builder: (context) => const FamilyBillingScreen(),
        ),
        PrimeCareScreen(
          title: 'Emergency Contacts',
          route: ClientRoutes.familyMemberEmergencyContacts,
          icon: Icons.contact_phone,
          builder: (context) => const FamilyEmergencyContactsScreen(),
        ),
        PrimeCareScreen(
          title: 'My Profile',
          route: ClientRoutes.familyMemberProfile,
          icon: Icons.person,
          builder: (context) => const FamilyProfileScreen(),
        ),
      ];
}

class ClientApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_client';
  @override
  String get name => 'PrimeCare Client Portal';
  @override
  String get homeRoute => ClientRoutes.patientDashboard;
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
        PlatformRoleDefinition(
          role: PlatformRole.portal,
          dashboardRoute: ClientRoutes.patientDashboard,
          modules: [ClientPatientModule()],
        ),
      ];
}