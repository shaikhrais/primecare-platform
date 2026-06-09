// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rmt", () => {
  it("tests all screens for role rmt", () => {
    cy.loginAsRole("rmt");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Navigating to /offices/clinical/roles/rmt/dashboard (RmtDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Checking shell & content for RmtDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtdashboard-screen").should("be.visible");
  cy.getCy("rmtdashboard-title").should("be.visible");
  cy.getCy("rmtdashboard-content").should("be.visible");
  cy.getCy("rmt-dashboard-btn-schedule-appointment").should("be.visible");
  cy.getCy("rmt-dashboard-btn-submit-soap-notes").should("be.visible");
  cy.getCy("rmt-dashboard-btn-view-patient-history").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Saving screenshot for RmtDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Verified RmtDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Navigating to /offices/clinical/roles/rmt/analytics (RmtAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Checking shell & content for RmtAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtanalytics-screen").should("be.visible");
  cy.getCy("rmtanalytics-title").should("be.visible");
  cy.getCy("rmtanalytics-content").should("be.visible");
  cy.getCy("rmt-dashboard-btn-schedule-appointment").should("be.visible");
  cy.getCy("rmt-dashboard-btn-track-progress").should("be.visible");
  cy.getCy("rmt-dashboard-btn-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Saving screenshot for RmtAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Verified RmtAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Navigating to /offices/clinical/roles/rmt/compliance (RmtComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Checking shell & content for RmtComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcompliance-screen").should("be.visible");
  cy.getCy("rmtcompliance-title").should("be.visible");
  cy.getCy("rmtcompliance-content").should("be.visible");
  cy.getCy("rmt-dashboard-client-appointments").should("be.visible");
  cy.getCy("rmt-dashboard-compliance-audit").should("be.visible");
  cy.getCy("rmt-dashboard-client-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Saving screenshot for RmtComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Verified RmtComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Navigating to /offices/clinical/roles/rmt/workflow (RmtWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Checking shell & content for RmtWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtworkflow-screen").should("be.visible");
  cy.getCy("rmtworkflow-title").should("be.visible");
  cy.getCy("rmtworkflow-content").should("be.visible");
  cy.getCy("rmt-client-management").should("be.visible");
  cy.getCy("rmt-appointment-scheduler").should("be.visible");
  cy.getCy("rmt-treatment-plan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Saving screenshot for RmtWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Verified RmtWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Navigating to /offices/clinical/roles/rmt/command-center (RmtCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Checking shell & content for RmtCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcommandcenter-screen").should("be.visible");
  cy.getCy("rmtcommandcenter-title").should("be.visible");
  cy.getCy("rmtcommandcenter-content").should("be.visible");
  cy.getCy("rmt-dashboard-btn-schedule-appointment").should("be.visible");
  cy.getCy("rmt-dashboard-btn-view-client-records").should("be.visible");
  cy.getCy("rmt-dashboard-btn-update-treatment-plan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Saving screenshot for RmtCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Verified RmtCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Navigating to /offices/clinical/roles/rmt/appointments (RmtAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Checking shell & content for RmtAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtappointments-screen").should("be.visible");
  cy.getCy("rmtappointments-title").should("be.visible");
  cy.getCy("rmtappointments-content").should("be.visible");
  cy.getCy("rmt-appointments-schedule").should("be.visible");
  cy.getCy("rmt-assessment-submit").should("be.visible");
  cy.getCy("rmt-treatment-save").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Saving screenshot for RmtAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Verified RmtAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Navigating to /offices/clinical/roles/rmt/client-intake (RmtClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Checking shell & content for RmtClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtclientintake-screen").should("be.visible");
  cy.getCy("rmtclientintake-title").should("be.visible");
  cy.getCy("rmtclientintake-content").should("be.visible");
  cy.getCy("rmt-intake-form-submit").should("be.visible");
  cy.getCy("rmt-treatment-plan-save").should("be.visible");
  cy.getCy("rmt-appointment-schedule").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Saving screenshot for RmtClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Verified RmtClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Navigating to /offices/clinical/roles/rmt/assessment (RmtAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Checking shell & content for RmtAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtassessment-screen").should("be.visible");
  cy.getCy("rmtassessment-title").should("be.visible");
  cy.getCy("rmtassessment-content").should("be.visible");
  cy.getCy("rmt-dashboard-client-overview").should("be.visible");
  cy.getCy("rmt-dashboard-compliance-status").should("be.visible");
  cy.getCy("rmt-dashboard-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Saving screenshot for RmtAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Verified RmtAssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Navigating to /offices/clinical/roles/rmt/treatment-notes (RmtTreatmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/treatment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Checking shell & content for RmtTreatmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmttreatmentnotes-screen").should("be.visible");
  cy.getCy("rmttreatmentnotes-title").should("be.visible");
  cy.getCy("rmttreatmentnotes-content").should("be.visible");
  cy.getCy("rmt-dashboard-client-overview").should("be.visible");
  cy.getCy("rmt-dashboard-compliance-status").should("be.visible");
  cy.getCy("rmt-dashboard-kpi-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Saving screenshot for RmtTreatmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_treatment_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Verified RmtTreatmentNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Navigating to /offices/clinical/roles/rmt/exercise-plan (RmtExercisePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/exercise-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Checking shell & content for RmtExercisePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtexerciseplan-screen").should("be.visible");
  cy.getCy("rmtexerciseplan-title").should("be.visible");
  cy.getCy("rmtexerciseplan-content").should("be.visible");
  cy.getCy("rmt-dashboard-client-overview").should("be.visible");
  cy.getCy("rmt-dashboard-compliance-status").should("be.visible");
  cy.getCy("rmt-dashboard-feedback-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Saving screenshot for RmtExercisePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_exercise_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Verified RmtExercisePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Navigating to /offices/clinical/roles/rmt/billing-link (RmtBillingLinkScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/billing-link");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Checking shell & content for RmtBillingLinkScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtbillinglink-screen").should("be.visible");
  cy.getCy("rmtbillinglink-title").should("be.visible");
  cy.getCy("rmtbillinglink-content").should("be.visible");
  cy.getCy("rmt-dashboard-btn-add-client").should("be.visible");
  cy.getCy("rmt-dashboard-btn-update-treatment").should("be.visible");
  cy.getCy("rmt-dashboard-btn-submit-billing").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Saving screenshot for RmtBillingLinkScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_billing_link");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Verified RmtBillingLinkScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Navigating to /offices/clinical/roles/rmt/reports (RmtReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Checking shell & content for RmtReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtreports-screen").should("be.visible");
  cy.getCy("rmtreports-title").should("be.visible");
  cy.getCy("rmtreports-content").should("be.visible");
  cy.getCy("rmt-dashboard-btn-schedule-appointment").should("be.visible");
  cy.getCy("rmt-dashboard-btn-view-client-records").should("be.visible");
  cy.getCy("rmt-dashboard-btn-submit-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Saving screenshot for RmtReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Verified RmtReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Navigating to /offices/clinical/roles/rmt/massage-assessment (MassageAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/massage-assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Checking shell & content for MassageAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("massageassessment-screen").should("be.visible");
  cy.getCy("massageassessment-title").should("be.visible");
  cy.getCy("massageassessment-content").should("be.visible");
  cy.getCy("massage-assessment-btn-save").should("be.visible");
  cy.getCy("massage-assessment-btn-generate-plan").should("be.visible");
  cy.getCy("massage-assessment-btn-record-session").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Saving screenshot for MassageAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("massage_assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Verified MassageAssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Navigating to /offices/clinical/roles/rmt/home-care-plan (HomeCarePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/home-care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Checking shell & content for HomeCarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("homecareplan-screen").should("be.visible");
  cy.getCy("homecareplan-title").should("be.visible");
  cy.getCy("homecareplan-content").should("be.visible");
  cy.getCy("homecareplan-btn-view-client").should("be.visible");
  cy.getCy("homecareplan-btn-schedule-appointment").should("be.visible");
  cy.getCy("homecareplan-btn-update-treatment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Saving screenshot for HomeCarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("home_care_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Verified HomeCarePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Navigating to /offices/clinical/roles/rmt/client-progress (ClientProgressScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/client-progress");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Checking shell & content for ClientProgressScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientprogress-screen").should("be.visible");
  cy.getCy("clientprogress-title").should("be.visible");
  cy.getCy("clientprogress-content").should("be.visible");
  cy.getCy("client-appointment-scheduler").should("be.visible");
  cy.getCy("client-assessment-tracker").should("be.visible");
  cy.getCy("performance-metrics-card").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Saving screenshot for ClientProgressScreen...");
  cy.waitAndSee();
  cy.screenshot("client_progress");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Verified ClientProgressScreen successfully!\n");

  });
});
