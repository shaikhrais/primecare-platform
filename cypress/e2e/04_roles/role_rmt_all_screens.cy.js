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

  // cy.getCy("rmtdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtcompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtcompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtcompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtcommandcenter-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtcommandcenter-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtcommandcenter-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtappointments-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtappointments-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtappointments-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtclientintake-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtclientintake-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtclientintake-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtassessment-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtassessment-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtassessment-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmttreatmentnotes-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmttreatmentnotes-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmttreatmentnotes-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtexerciseplan-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtexerciseplan-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtexerciseplan-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtbillinglink-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtbillinglink-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtbillinglink-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("rmtreports-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtreports-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rmtreports-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("massageassessment-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("massageassessment-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("massageassessment-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("homecareplan-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("homecareplan-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("homecareplan-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

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

  // cy.getCy("clientprogress-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clientprogress-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clientprogress-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Saving screenshot for ClientProgressScreen...");
  cy.waitAndSee();
  cy.screenshot("client_progress");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Verified ClientProgressScreen successfully!\n");

  });
});
