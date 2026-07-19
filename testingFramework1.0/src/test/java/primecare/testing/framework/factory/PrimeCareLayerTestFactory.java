package primecare.testing.framework.factory;

import primecare.testing.framework.database.DatabaseHealthCheck;
import primecare.testing.framework.database.DatabaseMigrationRunner;
import primecare.testing.framework.planning.*;
import primecare.testing.framework.reporting.DryRunReporter;
import primecare.testing.framework.reporting.TestPlanConsoleReporter;
import org.testng.annotations.Factory;

import java.util.ArrayList;
import java.util.List;

public class PrimeCareLayerTestFactory {

    @Factory
    @org.testng.annotations.Parameters({"level", "layers", "screen"})
    public Object[] createTests(
        @org.testng.annotations.Optional String levelParam, 
        @org.testng.annotations.Optional String layersParam,
        @org.testng.annotations.Optional String screenParam
    ) {
        if (levelParam != null && !levelParam.isEmpty()) {
            System.setProperty("level", levelParam);
        }
        if (layersParam != null && !layersParam.isEmpty()) {
            System.setProperty("layers", layersParam);
        }
        if (screenParam != null && !screenParam.isEmpty()) {
            System.setProperty("screen", screenParam);
        }

        System.out.println("[FACTORY] Starting PrimeCare 10-Layer level-driven execution orchestrator...");
        
        // 1. Initialize SQLite Database and run schema migrations
        DatabaseMigrationRunner.runMigrations();

        // 2. Validate database health and constraints integrity
        DatabaseHealthCheck.verifyDatabaseState();

        // 3. Register and synchronize screen-wise custom test suites
        registerScreenSuites();
        ScreenTestMetadataSynchronizer.synchronizeMetadata();

        // 4. Parse system and environmental arguments
        TestExecutionRequest request = TestExecutionRequestParser.fromSystemProperties();
        
        // 5. Enforce request constraints
        TestExecutionRequestValidator.validate(request);

        // 6. Generate the execution test plan
        TestPlan plan = TestPlanFactory.createPlan(request);

        // 7. Handle Dry Run Preview
        if (request.dryRun) {
            DryRunReporter.recordDryRun(plan);
            return new Object[0];
        }

        // 8. Output execution plan summary
        TestPlanConsoleReporter.printPlan(plan);

        // 9. Instantiate dynamic screen tests
        List<Object> tests = new ArrayList<>();
        for (TestPlanItem item : plan.items) {
            if (item.testCases != null) {
                for (ScreenTestCaseDefinition tc : item.testCases) {
                    tests.add(new DynamicScreenTest(item, tc));
                }
            }
        }

        System.out.println("[FACTORY] Generated " + tests.size() + " test instances for execution.");
        return tests.toArray();
    }

            private void registerScreenSuites() {
        ScreenTestRegistry.clear();
        try {
            ScreenTestRegistry.register(new primecare.testing.screens.language.LanguageScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.login.LoginScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.success.SuccessScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.invalid_route.InvalidRouteScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.clinical_dashboard.ClinicalDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.clinic_dashboard.ClinicDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.dynamic_screen_dashboard.DynamicScreenDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.family_member_dashboard.FamilyMemberDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.franchise_dashboard.FranchiseDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.guest_dashboard.GuestDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.office_dashboard.OfficeDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.patient_dashboard.PatientDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.owner_dashboard.OwnerDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.psw_dashboard.PswDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.rn_dashboard.RnDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.rpn_dashboard.RpnDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.billing_admin_dashboard.BillingAdminDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.receptionist_dashboard.ReceptionistDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.regional_manager_ontario_dashboard.RegionalManagerOntarioDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.family_dashboard.FamilyDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.client_dashboard.ClientDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.unknown_dashboard.UnknownDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.clinical_director_dashboard.ClinicalDirectorDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.infection_control_dashboard.InfectionControlDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.nurse_dashboard.NurseDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.psw_care_dashboard.PswCareDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ceo_dashboard.CeoDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.it_admin_dashboard.ItAdminDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.admin_dashboard.AdminDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.franchise_owner_dashboard.FranchiseOwnerDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.marketing_manager_dashboard.MarketingManagerDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.regional_manager_dashboard.RegionalManagerDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.audit_dashboard.AuditDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.escalation_dashboard.EscalationDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.help_desk_dashboard.HelpDeskDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.it_administrator_dashboard.ItAdministratorDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.hipaa_audit_dashboard.HipaaAuditDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.provider_performance_dashboard.ProviderPerformanceDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.predictive_analytics_dashboard.PredictiveAnalyticsDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.c_m_e_tracking_dashboard.CMETrackingDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.campaign_performance_dashboard.CampaignPerformanceDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.pharmacy_dispensing_dashboard.PharmacyDispensingDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.epidemiological_surveillance_dashboard.EpidemiologicalSurveillanceDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.school_health_program_dashboard.SchoolHealthProgramDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.clinical_trial_recruitment_dashboard.ClinicalTrialRecruitmentDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.remote_patient_monitoring_dashboard.RemotePatientMonitoringDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.dynamic_dashboard.DynamicDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.screen_progress_dashboard.ScreenProgressDashboardScreenTestSuite());
        } catch (Exception e) {
            System.err.println("[FACTORY] Warning during screen suite registration: " + e.getMessage());
        }
    }
}
