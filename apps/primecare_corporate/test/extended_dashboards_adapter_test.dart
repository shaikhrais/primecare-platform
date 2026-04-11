import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/src/screens/offices/admin/admin_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/business_development/franchise_sales_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/business_development/general_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/business_development/partnership_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/business_development/regional_manager_ontario_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/business_development/regional_manager_usa_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/business_development/territory_expansion_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/client/family_member_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/client/patient_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/clinical/psw_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/corporate/ceo_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/corporate/cfo_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/corporate/compliance_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/corporate/coo_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/corporate/cto_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/corporate/training_director_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/billing_admin_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/billing_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/franchise_owner_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/hr_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/hr_hiring_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/operations_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/ops_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/scheduler_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/franchise/scheduling_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/marketing/community_outreach_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/marketing/head_of_marketing_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/marketing/local_marketing_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/marketing/local_marketing_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/marketing/territory_sales_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/marketing/territory_sales_manager_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/support/customer_support_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/support/intake_coordinator_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/support/intake_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/support/qa_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/support/quality_assurance_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/support/support_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/support/training_coordinator_dashboard.dart';
import '../integration_test/page_objects/master_dashboard_page.dart';

void main() {
  setUpAll(() {
    DataSourceConfig.currentMode = DataSourceType.mock;
    EasyLocalization.logger.enableBuildModes = [];
  });

  group('Extended E2E Dashboard Adapter Hydration Validation', () {

    testWidgets('Verify AdminDashboardScreen hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const AdminDashboardScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('admin.admin.dashboard.title');
      await dashboard.verifySubtitle('admin.admin.dashboard.subtitle');
    });

    testWidgets('Verify FranchiseSalesManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const FranchiseSalesManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('business_development.franchiseSalesManager.dashboard.title');
      await dashboard.verifySubtitle('business_development.franchiseSalesManager.dashboard.subtitle');
    });

    testWidgets('Verify GeneralManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const GeneralManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('business_development.generalManager.dashboard.title');
      await dashboard.verifySubtitle('business_development.generalManager.dashboard.subtitle');
    });

    testWidgets('Verify PartnershipManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const PartnershipManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('business_development.partnershipManager.dashboard.title');
      await dashboard.verifySubtitle('business_development.partnershipManager.dashboard.subtitle');
    });

    testWidgets('Verify RegionalManagerOntarioDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const RegionalManagerOntarioDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('business_development.regionalManagerOntario.dashboard.title');
      await dashboard.verifySubtitle('business_development.regionalManagerOntario.dashboard.subtitle');
    });

    testWidgets('Verify RegionalManagerUsaDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const RegionalManagerUsaDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('business_development.regionalManagerUsa.dashboard.title');
      await dashboard.verifySubtitle('business_development.regionalManagerUsa.dashboard.subtitle');
    });

    testWidgets('Verify TerritoryExpansionManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const TerritoryExpansionManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('business_development.territoryExpansionManager.dashboard.title');
      await dashboard.verifySubtitle('business_development.territoryExpansionManager.dashboard.subtitle');
    });

    testWidgets('Verify FamilyMemberDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const FamilyMemberDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('client.familyMember.dashboard.title');
      await dashboard.verifySubtitle('client.familyMember.dashboard.subtitle');
    });

    testWidgets('Verify PatientDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const PatientDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('client.patient.dashboard.title');
      await dashboard.verifySubtitle('client.patient.dashboard.subtitle');
    });

    testWidgets('Verify PswDashboardScreen hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const PswDashboardScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('clinical.psw.dashboard.title');
      await dashboard.verifySubtitle('clinical.psw.dashboard.subtitle');
    });

    testWidgets('Verify CeoDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CeoDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.ceo.dashboard.title');
      await dashboard.verifySubtitle('corporate.ceo.dashboard.subtitle');
    });

    testWidgets('Verify CfoDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CfoDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.cfo.dashboard.title');
      await dashboard.verifySubtitle('corporate.cfo.dashboard.subtitle');
    });

    testWidgets('Verify ComplianceManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const ComplianceManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.complianceManager.dashboard.title');
      await dashboard.verifySubtitle('corporate.complianceManager.dashboard.subtitle');
    });

    testWidgets('Verify CooDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CooDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.coo.dashboard.title');
      await dashboard.verifySubtitle('corporate.coo.dashboard.subtitle');
    });

    testWidgets('Verify CtoDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CtoDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.cto.dashboard.title');
      await dashboard.verifySubtitle('corporate.cto.dashboard.subtitle');
    });

    testWidgets('Verify TrainingDirectorDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const TrainingDirectorDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.trainingDirector.dashboard.title');
      await dashboard.verifySubtitle('corporate.trainingDirector.dashboard.subtitle');
    });

    testWidgets('Verify BillingAdminDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const BillingAdminDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.billingAdmin.dashboard.title');
      await dashboard.verifySubtitle('franchise.billingAdmin.dashboard.subtitle');
    });

    testWidgets('Verify BillingDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const BillingDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.billing.dashboard.title');
      await dashboard.verifySubtitle('franchise.billing.dashboard.subtitle');
    });

    testWidgets('Verify FranchiseOwnerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const FranchiseOwnerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.franchiseOwner.dashboard.title');
      await dashboard.verifySubtitle('franchise.franchiseOwner.dashboard.subtitle');
    });

    testWidgets('Verify HrDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const HrDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.hr.dashboard.title');
      await dashboard.verifySubtitle('franchise.hr.dashboard.subtitle');
    });

    testWidgets('Verify HrHiringDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const HrHiringDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.hrHiring.dashboard.title');
      await dashboard.verifySubtitle('franchise.hrHiring.dashboard.subtitle');
    });

    testWidgets('Verify OperationsManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const OperationsManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.operationsManager.dashboard.title');
      await dashboard.verifySubtitle('franchise.operationsManager.dashboard.subtitle');
    });

    testWidgets('Verify OpsManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const OpsManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.opsManager.dashboard.title');
      await dashboard.verifySubtitle('franchise.opsManager.dashboard.subtitle');
    });

    testWidgets('Verify SchedulerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const SchedulerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.scheduler.dashboard.title');
      await dashboard.verifySubtitle('franchise.scheduler.dashboard.subtitle');
    });

    testWidgets('Verify SchedulingDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const SchedulingDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('franchise.scheduling.dashboard.title');
      await dashboard.verifySubtitle('franchise.scheduling.dashboard.subtitle');
    });

    testWidgets('Verify CommunityOutreachDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CommunityOutreachDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('marketing.communityOutreach.dashboard.title');
      await dashboard.verifySubtitle('marketing.communityOutreach.dashboard.subtitle');
    });

    testWidgets('Verify HeadOfMarketingDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const HeadOfMarketingDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('marketing.headOfMarketing.dashboard.title');
      await dashboard.verifySubtitle('marketing.headOfMarketing.dashboard.subtitle');
    });

    testWidgets('Verify LocalMarketingDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const LocalMarketingDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('marketing.localMarketing.dashboard.title');
      await dashboard.verifySubtitle('marketing.localMarketing.dashboard.subtitle');
    });

    testWidgets('Verify LocalMarketingManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const LocalMarketingManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('marketing.localMarketingManager.dashboard.title');
      await dashboard.verifySubtitle('marketing.localMarketingManager.dashboard.subtitle');
    });

    testWidgets('Verify TerritorySalesDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const TerritorySalesDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('marketing.territorySales.dashboard.title');
      await dashboard.verifySubtitle('marketing.territorySales.dashboard.subtitle');
    });

    testWidgets('Verify TerritorySalesManagerDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const TerritorySalesManagerDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('marketing.territorySalesManager.dashboard.title');
      await dashboard.verifySubtitle('marketing.territorySalesManager.dashboard.subtitle');
    });

    testWidgets('Verify CustomerSupportDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CustomerSupportDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('support.customerSupport.dashboard.title');
      await dashboard.verifySubtitle('support.customerSupport.dashboard.subtitle');
    });

    testWidgets('Verify IntakeCoordinatorDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const IntakeCoordinatorDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('support.intakeCoordinator.dashboard.title');
      await dashboard.verifySubtitle('support.intakeCoordinator.dashboard.subtitle');
    });

    testWidgets('Verify IntakeDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const IntakeDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('support.intake.dashboard.title');
      await dashboard.verifySubtitle('support.intake.dashboard.subtitle');
    });

    testWidgets('Verify QaDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const QaDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('support.qa.dashboard.title');
      await dashboard.verifySubtitle('support.qa.dashboard.subtitle');
    });

    testWidgets('Verify QualityAssuranceDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const QualityAssuranceDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('support.qualityAssurance.dashboard.title');
      await dashboard.verifySubtitle('support.qualityAssurance.dashboard.subtitle');
    });

    testWidgets('Verify SupportDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const SupportDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('support.support.dashboard.title');
      await dashboard.verifySubtitle('support.support.dashboard.subtitle');
    });

    testWidgets('Verify TrainingCoordinatorDashboard hydration', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const TrainingCoordinatorDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('support.trainingCoordinator.dashboard.title');
      await dashboard.verifySubtitle('support.trainingCoordinator.dashboard.subtitle');
    });
  });
}
