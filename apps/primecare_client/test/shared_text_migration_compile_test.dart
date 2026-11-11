// Compile smoke coverage for constructor-only shared text migration.
// This does not claim individual screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_client/ai_chatbot_screen.dart' as migrated0;
import 'package:primecare_client/features/family/screens/family_billing_screen.dart' as migrated1;
import 'package:primecare_client/features/family/screens/family_care_updates_screen.dart' as migrated2;
import 'package:primecare_client/features/family/screens/family_dashboard_screen.dart' as migrated3;
import 'package:primecare_client/features/family/screens/family_emergency_contacts_screen.dart' as migrated4;
import 'package:primecare_client/features/family/screens/family_loved_one_schedule_screen.dart' as migrated5;
import 'package:primecare_client/features/family/screens/family_profile_screen.dart' as migrated6;
import 'package:primecare_client/features/generated_screens/client_book_appointment_screen.dart' as migrated7;
import 'package:primecare_client/features/generated_screens/client_care_team_screen.dart' as migrated8;
import 'package:primecare_client/features/generated_screens/client_dashboard_screen.dart' as migrated9;
import 'package:primecare_client/features/generated_screens/client_my_appointments_screen.dart' as migrated10;
import 'package:primecare_client/features/generated_screens/client_payments_screen.dart' as migrated11;
import 'package:primecare_client/features/generated_screens/client_profile_screen.dart' as migrated12;
import 'package:primecare_client/features/generated_screens/client_treatment_history_screen.dart' as migrated13;
import 'package:primecare_client/features/generated_screens/family_member_billing_screen.dart' as migrated14;
import 'package:primecare_client/features/generated_screens/family_member_care_updates_screen.dart' as migrated15;
import 'package:primecare_client/features/generated_screens/family_member_emergency_contacts_screen.dart' as migrated16;
import 'package:primecare_client/features/generated_screens/family_member_loved_one_schedule_screen.dart' as migrated17;
import 'package:primecare_client/features/generated_screens/family_member_profile_screen.dart' as migrated18;
import 'package:primecare_client/features/patient/screens/patient_book_appointment_screen.dart' as migrated19;
import 'package:primecare_client/features/patient/screens/patient_care_team_screen.dart' as migrated20;
import 'package:primecare_client/features/patient/screens/patient_my_appointments_screen.dart' as migrated21;
import 'package:primecare_client/features/patient/screens/patient_payments_screen.dart' as migrated22;
import 'package:primecare_client/features/patient/screens/patient_treatment_history_screen.dart' as migrated23;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
    migrated0.AiChatbotScreenState,
    migrated1.FamilyBillingScreenState,
    migrated2.FamilyCareUpdatesScreenState,
    migrated3.FamilyDashboardScreenState,
    migrated4.FamilyEmergencyContactsScreenState,
    migrated5.FamilyLovedOneScheduleScreenState,
    migrated6.FamilyProfileScreenState,
    migrated7.ClientBookAppointmentScreenState,
    migrated8.ClientCareTeamScreenState,
    migrated9.ClientDashboardScreenState,
    migrated10.ClientMyAppointmentsScreenState,
    migrated11.ClientPaymentsScreenState,
    migrated12.ClientProfileScreenState,
    migrated13.ClientTreatmentHistoryScreenState,
    migrated14.FamilyMemberBillingScreenState,
    migrated15.FamilyMemberCareUpdatesScreenState,
    migrated16.FamilyMemberEmergencyContactsScreenState,
    migrated17.FamilyMemberLovedOneScheduleScreenState,
    migrated18.FamilyMemberProfileScreenState,
    migrated19.PatientBookAppointmentScreenState,
    migrated20.PatientCareTeamScreenState,
    migrated21.PatientMyAppointmentsScreenState,
    migrated22.PatientPaymentsScreenState,
    migrated23.PatientTreatmentHistoryScreenState,
    ];
    expect(migratedTypes, hasLength(24));
  });
}
