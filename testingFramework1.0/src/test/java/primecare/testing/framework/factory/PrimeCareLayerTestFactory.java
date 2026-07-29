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
            ScreenTestRegistry.register(new primecare.testing.screens.LanguageScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.LoginScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.SuccessScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.InvalidRouteScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ClinicalDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ClinicDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.DynamicScreenDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.FamilyMemberDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.FranchiseDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.GuestDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.OfficeDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.PatientDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.OwnerDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.PswDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.RnDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.RpnDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.BillingAdminDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ReceptionistDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.RegionalManagerOntarioDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.FamilyDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ClientDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.UnknownDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ClinicalDirectorDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.InfectionControlDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.NurseDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.PswCareDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.CeoDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ItAdminDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.AdminDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.FranchiseOwnerDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.MarketingManagerDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.RegionalManagerDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.AuditDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.EscalationDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.HelpDeskDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ItAdministratorDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.HipaaAuditDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ProviderPerformanceDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.PredictiveAnalyticsDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.CMETrackingDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.CampaignPerformanceDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.PharmacyDispensingDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.EpidemiologicalSurveillanceDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.SchoolHealthProgramDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ClinicalTrialRecruitmentDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.RemotePatientMonitoringDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.DynamicDashboardScreenTestSuite());
            ScreenTestRegistry.register(new primecare.testing.screens.ScreenProgressDashboardScreenTestSuite());
        } catch (Exception e) {
            System.err.println("[FACTORY] Warning during screen suite registration: " + e.getMessage());
        }
    }
}
