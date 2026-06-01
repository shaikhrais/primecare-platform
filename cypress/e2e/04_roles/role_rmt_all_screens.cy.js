// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rmt", () => {
  it("tests all screens for role rmt", () => {
    cy.loginAsRole("rmt");


  
  cy.checkTestRegistry("rmtdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Navigating to /offices/clinical/roles/rmt/dashboard (RmtDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Checking shell & content for /offices/clinical/roles/rmt/dashboard (RmtDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtdashboard-screen").should("be.visible");
    cy.getCy("rmtdashboard-title").should("be.visible");
    cy.getCy("rmtdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Saving screenshot for /offices/clinical/roles/rmt/dashboard (RmtDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_dashboard");
    
    cy.updateTestRegistry("rmtdashboard", "PASS", "role_rmt_all_screens.cy.js", "rmt_dashboard");
    cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Verified RmtDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtanalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Navigating to /offices/clinical/roles/rmt/analytics (RmtAnalyticsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Checking shell & content for /offices/clinical/roles/rmt/analytics (RmtAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtanalytics-screen").should("be.visible");
    cy.getCy("rmtanalytics-title").should("be.visible");
    cy.getCy("rmtanalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Saving screenshot for /offices/clinical/roles/rmt/analytics (RmtAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_analytics");
    
    cy.updateTestRegistry("rmtanalytics", "PASS", "role_rmt_all_screens.cy.js", "rmt_analytics");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Verified RmtAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtcompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Navigating to /offices/clinical/roles/rmt/compliance (RmtComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Checking shell & content for /offices/clinical/roles/rmt/compliance (RmtComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtcompliance-screen").should("be.visible");
    cy.getCy("rmtcompliance-title").should("be.visible");
    cy.getCy("rmtcompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Saving screenshot for /offices/clinical/roles/rmt/compliance (RmtComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_compliance");
    
    cy.updateTestRegistry("rmtcompliance", "PASS", "role_rmt_all_screens.cy.js", "rmt_compliance");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Verified RmtComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Navigating to /offices/clinical/roles/rmt/workflow (RmtWorkflowScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Checking shell & content for /offices/clinical/roles/rmt/workflow (RmtWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtworkflow-screen").should("be.visible");
    cy.getCy("rmtworkflow-title").should("be.visible");
    cy.getCy("rmtworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Saving screenshot for /offices/clinical/roles/rmt/workflow (RmtWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_workflow");
    
    cy.updateTestRegistry("rmtworkflow", "PASS", "role_rmt_all_screens.cy.js", "rmt_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Verified RmtWorkflowScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtcommandcenter").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Navigating to /offices/clinical/roles/rmt/command-center (RmtCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/command-center");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Checking shell & content for /offices/clinical/roles/rmt/command-center (RmtCommandCenterScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtcommandcenter-screen").should("be.visible");
    cy.getCy("rmtcommandcenter-title").should("be.visible");
    cy.getCy("rmtcommandcenter-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Saving screenshot for /offices/clinical/roles/rmt/command-center (RmtCommandCenterScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_command_center");
    
    cy.updateTestRegistry("rmtcommandcenter", "PASS", "role_rmt_all_screens.cy.js", "rmt_command_center");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Verified RmtCommandCenterScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtappointments").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Navigating to /offices/clinical/roles/rmt/appointments (RmtAppointmentsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/appointments");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Checking shell & content for /offices/clinical/roles/rmt/appointments (RmtAppointmentsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtappointments-screen").should("be.visible");
    cy.getCy("rmtappointments-title").should("be.visible");
    cy.getCy("rmtappointments-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Saving screenshot for /offices/clinical/roles/rmt/appointments (RmtAppointmentsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_appointments");
    
    cy.updateTestRegistry("rmtappointments", "PASS", "role_rmt_all_screens.cy.js", "rmt_appointments");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Verified RmtAppointmentsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtclientintake").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Navigating to /offices/clinical/roles/rmt/client-intake (RmtClientIntakeScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/client-intake");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Checking shell & content for /offices/clinical/roles/rmt/client-intake (RmtClientIntakeScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtclientintake-screen").should("be.visible");
    cy.getCy("rmtclientintake-title").should("be.visible");
    cy.getCy("rmtclientintake-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Saving screenshot for /offices/clinical/roles/rmt/client-intake (RmtClientIntakeScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_client_intake");
    
    cy.updateTestRegistry("rmtclientintake", "PASS", "role_rmt_all_screens.cy.js", "rmt_client_intake");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Verified RmtClientIntakeScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtassessment").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Navigating to /offices/clinical/roles/rmt/assessment (RmtAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/assessment");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Checking shell & content for /offices/clinical/roles/rmt/assessment (RmtAssessmentScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtassessment-screen").should("be.visible");
    cy.getCy("rmtassessment-title").should("be.visible");
    cy.getCy("rmtassessment-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Saving screenshot for /offices/clinical/roles/rmt/assessment (RmtAssessmentScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_assessment");
    
    cy.updateTestRegistry("rmtassessment", "PASS", "role_rmt_all_screens.cy.js", "rmt_assessment");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Verified RmtAssessmentScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmttreatmentnotes").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Navigating to /offices/clinical/roles/rmt/treatment-notes (RmtTreatmentNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/treatment-notes");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Checking shell & content for /offices/clinical/roles/rmt/treatment-notes (RmtTreatmentNotesScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmttreatmentnotes-screen").should("be.visible");
    cy.getCy("rmttreatmentnotes-title").should("be.visible");
    cy.getCy("rmttreatmentnotes-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Saving screenshot for /offices/clinical/roles/rmt/treatment-notes (RmtTreatmentNotesScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_treatment_notes");
    
    cy.updateTestRegistry("rmttreatmentnotes", "PASS", "role_rmt_all_screens.cy.js", "rmt_treatment_notes");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Verified RmtTreatmentNotesScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtexerciseplan").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Navigating to /offices/clinical/roles/rmt/exercise-plan (RmtExercisePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/exercise-plan");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Checking shell & content for /offices/clinical/roles/rmt/exercise-plan (RmtExercisePlanScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtexerciseplan-screen").should("be.visible");
    cy.getCy("rmtexerciseplan-title").should("be.visible");
    cy.getCy("rmtexerciseplan-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Saving screenshot for /offices/clinical/roles/rmt/exercise-plan (RmtExercisePlanScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_exercise_plan");
    
    cy.updateTestRegistry("rmtexerciseplan", "PASS", "role_rmt_all_screens.cy.js", "rmt_exercise_plan");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Verified RmtExercisePlanScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtbillinglink").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Navigating to /offices/clinical/roles/rmt/billing-link (RmtBillingLinkScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/billing-link");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Checking shell & content for /offices/clinical/roles/rmt/billing-link (RmtBillingLinkScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtbillinglink-screen").should("be.visible");
    cy.getCy("rmtbillinglink-title").should("be.visible");
    cy.getCy("rmtbillinglink-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Saving screenshot for /offices/clinical/roles/rmt/billing-link (RmtBillingLinkScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_billing_link");
    
    cy.updateTestRegistry("rmtbillinglink", "PASS", "role_rmt_all_screens.cy.js", "rmt_billing_link");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Verified RmtBillingLinkScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rmtreports").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Navigating to /offices/clinical/roles/rmt/reports (RmtReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/reports");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Checking shell & content for /offices/clinical/roles/rmt/reports (RmtReportsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rmtreports-screen").should("be.visible");
    cy.getCy("rmtreports-title").should("be.visible");
    cy.getCy("rmtreports-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Saving screenshot for /offices/clinical/roles/rmt/reports (RmtReportsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rmt_reports");
    
    cy.updateTestRegistry("rmtreports", "PASS", "role_rmt_all_screens.cy.js", "rmt_reports");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Verified RmtReportsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("massageassessment").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Navigating to /offices/clinical/roles/rmt/massage-assessment (MassageAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/massage-assessment");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Checking shell & content for /offices/clinical/roles/rmt/massage-assessment (MassageAssessmentScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("massageassessment-screen").should("be.visible");
    cy.getCy("massageassessment-title").should("be.visible");
    cy.getCy("massageassessment-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Saving screenshot for /offices/clinical/roles/rmt/massage-assessment (MassageAssessmentScreen)...");
    cy.waitAndSee();
    cy.screenshot("massage_assessment");
    
    cy.updateTestRegistry("massageassessment", "PASS", "role_rmt_all_screens.cy.js", "massage_assessment");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Verified MassageAssessmentScreen successfully!\n");
  });


  
  cy.checkTestRegistry("homecareplan").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Navigating to /offices/clinical/roles/rmt/home-care-plan (HomeCarePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/home-care-plan");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Checking shell & content for /offices/clinical/roles/rmt/home-care-plan (HomeCarePlanScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("homecareplan-screen").should("be.visible");
    cy.getCy("homecareplan-title").should("be.visible");
    cy.getCy("homecareplan-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Saving screenshot for /offices/clinical/roles/rmt/home-care-plan (HomeCarePlanScreen)...");
    cy.waitAndSee();
    cy.screenshot("home_care_plan");
    
    cy.updateTestRegistry("homecareplan", "PASS", "role_rmt_all_screens.cy.js", "home_care_plan");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Verified HomeCarePlanScreen successfully!\n");
  });


  
  cy.checkTestRegistry("clientprogress").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Navigating to /offices/clinical/roles/rmt/client-progress (ClientProgressScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rmt/client-progress");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Checking shell & content for /offices/clinical/roles/rmt/client-progress (ClientProgressScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("clientprogress-screen").should("be.visible");
    cy.getCy("clientprogress-title").should("be.visible");
    cy.getCy("clientprogress-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Saving screenshot for /offices/clinical/roles/rmt/client-progress (ClientProgressScreen)...");
    cy.waitAndSee();
    cy.screenshot("client_progress");
    
    cy.updateTestRegistry("clientprogress", "PASS", "role_rmt_all_screens.cy.js", "client_progress");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Verified ClientProgressScreen successfully!\n");
  });


  });
});
