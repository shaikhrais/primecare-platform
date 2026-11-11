import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/screens/clinical/clinical_director_dashboard_screen.dart' as migrated0;
import 'package:primecare_ui/src/features/generated_screens/auth_layout.dart' as migrated1;
import 'package:primecare_ui/src/features/generated_screens/billing_admin_dashboard_screen.dart' as migrated2;
import 'package:primecare_ui/src/features/generated_screens/branch_comparison.dart' as migrated3;
import 'package:primecare_ui/src/features/generated_screens/ceo_dashboard_labels.dart' as migrated4;
import 'package:primecare_ui/src/features/generated_screens/cfo_dashboard_labels.dart' as migrated5;
import 'package:primecare_ui/src/features/generated_screens/clinical_director_labels.dart' as migrated6;
import 'package:primecare_ui/src/features/generated_screens/clinical_labels.dart' as migrated7;
import 'package:primecare_ui/src/features/generated_screens/command_center_labels.dart' as migrated8;
import 'package:primecare_ui/src/features/generated_screens/common_dashboard_labels.dart' as migrated9;
import 'package:primecare_ui/src/features/generated_screens/create_shift_form.dart' as migrated10;
import 'package:primecare_ui/src/features/generated_screens/create_user_form.dart' as migrated11;
import 'package:primecare_ui/src/features/generated_screens/cto_dashboard_labels.dart' as migrated12;
import 'package:primecare_ui/src/features/generated_screens/curriculum_hub.dart' as migrated13;
import 'package:primecare_ui/src/features/generated_screens/document_vault.dart' as migrated14;
import 'package:primecare_ui/src/features/generated_screens/global_settings.dart' as migrated15;
import 'package:primecare_ui/src/features/generated_screens/guest_dashboard_screen.dart' as migrated16;
import 'package:primecare_ui/src/features/generated_screens/hr_hiring_dashboard_screen.dart' as migrated17;
import 'package:primecare_ui/src/features/generated_screens/ledger_command.dart' as migrated18;
import 'package:primecare_ui/src/features/generated_screens/marketing_dashboard_labels.dart' as migrated19;
import 'package:primecare_ui/src/features/generated_screens/messages.dart' as migrated20;
import 'package:primecare_ui/src/features/generated_screens/messaging_hub.dart' as migrated21;
import 'package:primecare_ui/src/features/generated_screens/notification_center.dart' as migrated22;
import 'package:primecare_ui/src/features/generated_screens/password_reset_form.dart' as migrated23;
import 'package:primecare_ui/src/features/generated_screens/receptionist_dashboard_screen.dart' as migrated24;
import 'package:primecare_ui/src/features/generated_screens/regional_manager_labels.dart' as migrated25;
import 'package:primecare_ui/src/features/generated_screens/scheduler_dashboard_screen.dart' as migrated26;
import 'package:primecare_ui/src/features/generated_screens/scrum_master_dashboard_screen.dart' as migrated27;
import 'package:primecare_ui/src/features/generated_screens/shift_tracker.dart' as migrated28;
import 'package:primecare_ui/src/features/generated_screens/skill_matrix.dart' as migrated29;
import 'package:primecare_ui/src/features/generated_screens/support_dashboard_labels.dart' as migrated30;

void main() {
  test('all semantic palette consumers compile', () {
    final types = <Type>[
      migrated0.ClinicalDirectorDashboardController,
      migrated1.AuthLayout,
      migrated2.BillingAdminDashboardScreen,
      migrated3.BranchComparison,
      migrated4.CeoDashboardLabels,
      migrated5.CfoDashboardLabels,
      migrated6.ClinicalDirectorLabels,
      migrated7.ClinicalLabels,
      migrated8.CommandCenterLabels,
      migrated9.CommonDashboardLabels,
      migrated10.CreateShiftForm,
      migrated11.CreateUserForm,
      migrated12.CtoDashboardLabels,
      migrated13.CurriculumHub,
      migrated14.DocumentVault,
      migrated15.GlobalSettings,
      migrated16.GuestDashboardScreen,
      migrated17.HrHiringDashboardScreen,
      migrated18.LedgerCommand,
      migrated19.MarketingDashboardLabels,
      migrated20.Messages,
      migrated21.MessagingHub,
      migrated22.NotificationCenter,
      migrated23.PasswordResetForm,
      migrated24.ReceptionistDashboardScreen,
      migrated25.RegionalManagerLabels,
      migrated26.SchedulerDashboardScreen,
      migrated27.ScrumMasterDashboardScreen,
      migrated28.ShiftTracker,
      migrated29.SkillMatrix,
      migrated30.SupportDashboardLabels
    ];
    expect(types, hasLength(31));
  });
}
