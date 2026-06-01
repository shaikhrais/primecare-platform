// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - chiropractor", () => {
  it("tests all screens for role chiropractor", () => {
    cy.loginAsRole("chiropractor");


  
  cy.checkTestRegistry("chiropractordashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /offices/clinical/roles/chiropractor/dashboard (ChiropractorDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for /offices/clinical/roles/chiropractor/dashboard (ChiropractorDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractordashboard-screen").should("be.visible");
    cy.getCy("chiropractordashboard-title").should("be.visible");
    cy.getCy("chiropractordashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for /offices/clinical/roles/chiropractor/dashboard (ChiropractorDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_dashboard");
    
    cy.updateTestRegistry("chiropractordashboard", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_dashboard");
    cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified ChiropractorDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractoranalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /offices/clinical/roles/chiropractor/analytics (ChiropractorAnalyticsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for /offices/clinical/roles/chiropractor/analytics (ChiropractorAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractoranalytics-screen").should("be.visible");
    cy.getCy("chiropractoranalytics-title").should("be.visible");
    cy.getCy("chiropractoranalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for /offices/clinical/roles/chiropractor/analytics (ChiropractorAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_analytics");
    
    cy.updateTestRegistry("chiropractoranalytics", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_analytics");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified ChiropractorAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorcompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /offices/clinical/roles/chiropractor/compliance (ChiropractorComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for /offices/clinical/roles/chiropractor/compliance (ChiropractorComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorcompliance-screen").should("be.visible");
    cy.getCy("chiropractorcompliance-title").should("be.visible");
    cy.getCy("chiropractorcompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for /offices/clinical/roles/chiropractor/compliance (ChiropractorComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_compliance");
    
    cy.updateTestRegistry("chiropractorcompliance", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_compliance");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified ChiropractorComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /offices/clinical/roles/chiropractor/workflow (ChiropractorWorkflowScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for /offices/clinical/roles/chiropractor/workflow (ChiropractorWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorworkflow-screen").should("be.visible");
    cy.getCy("chiropractorworkflow-title").should("be.visible");
    cy.getCy("chiropractorworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for /offices/clinical/roles/chiropractor/workflow (ChiropractorWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_workflow");
    
    cy.updateTestRegistry("chiropractorworkflow", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified ChiropractorWorkflowScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorcommandcenter").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /offices/clinical/roles/chiropractor/command-center (ChiropractorCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/command-center");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for /offices/clinical/roles/chiropractor/command-center (ChiropractorCommandCenterScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
    cy.getCy("chiropractorcommandcenter-title").should("be.visible");
    cy.getCy("chiropractorcommandcenter-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for /offices/clinical/roles/chiropractor/command-center (ChiropractorCommandCenterScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_command_center");
    
    cy.updateTestRegistry("chiropractorcommandcenter", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_command_center");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified ChiropractorCommandCenterScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorappointments").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /offices/clinical/roles/chiropractor/appointments (ChiropractorAppointmentsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/appointments");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for /offices/clinical/roles/chiropractor/appointments (ChiropractorAppointmentsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorappointments-screen").should("be.visible");
    cy.getCy("chiropractorappointments-title").should("be.visible");
    cy.getCy("chiropractorappointments-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for /offices/clinical/roles/chiropractor/appointments (ChiropractorAppointmentsScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_appointments");
    
    cy.updateTestRegistry("chiropractorappointments", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_appointments");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified ChiropractorAppointmentsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorclientintake").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /offices/clinical/roles/chiropractor/client-intake (ChiropractorClientIntakeScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/client-intake");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for /offices/clinical/roles/chiropractor/client-intake (ChiropractorClientIntakeScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorclientintake-screen").should("be.visible");
    cy.getCy("chiropractorclientintake-title").should("be.visible");
    cy.getCy("chiropractorclientintake-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for /offices/clinical/roles/chiropractor/client-intake (ChiropractorClientIntakeScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_client_intake");
    
    cy.updateTestRegistry("chiropractorclientintake", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_client_intake");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified ChiropractorClientIntakeScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorassessment").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /offices/clinical/roles/chiropractor/assessment (ChiropractorAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/assessment");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for /offices/clinical/roles/chiropractor/assessment (ChiropractorAssessmentScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorassessment-screen").should("be.visible");
    cy.getCy("chiropractorassessment-title").should("be.visible");
    cy.getCy("chiropractorassessment-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for /offices/clinical/roles/chiropractor/assessment (ChiropractorAssessmentScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_assessment");
    
    cy.updateTestRegistry("chiropractorassessment", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_assessment");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified ChiropractorAssessmentScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractortreatmentnotes").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /offices/clinical/roles/chiropractor/treatment-notes (ChiropractorTreatmentNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/treatment-notes");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for /offices/clinical/roles/chiropractor/treatment-notes (ChiropractorTreatmentNotesScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
    cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
    cy.getCy("chiropractortreatmentnotes-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for /offices/clinical/roles/chiropractor/treatment-notes (ChiropractorTreatmentNotesScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_treatment_notes");
    
    cy.updateTestRegistry("chiropractortreatmentnotes", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_treatment_notes");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified ChiropractorTreatmentNotesScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorexerciseplan").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /offices/clinical/roles/chiropractor/exercise-plan (ChiropractorExercisePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/exercise-plan");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for /offices/clinical/roles/chiropractor/exercise-plan (ChiropractorExercisePlanScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
    cy.getCy("chiropractorexerciseplan-title").should("be.visible");
    cy.getCy("chiropractorexerciseplan-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for /offices/clinical/roles/chiropractor/exercise-plan (ChiropractorExercisePlanScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_exercise_plan");
    
    cy.updateTestRegistry("chiropractorexerciseplan", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_exercise_plan");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified ChiropractorExercisePlanScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorbillinglink").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /offices/clinical/roles/chiropractor/billing-link (ChiropractorBillingLinkScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/billing-link");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for /offices/clinical/roles/chiropractor/billing-link (ChiropractorBillingLinkScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorbillinglink-screen").should("be.visible");
    cy.getCy("chiropractorbillinglink-title").should("be.visible");
    cy.getCy("chiropractorbillinglink-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for /offices/clinical/roles/chiropractor/billing-link (ChiropractorBillingLinkScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_billing_link");
    
    cy.updateTestRegistry("chiropractorbillinglink", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_billing_link");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified ChiropractorBillingLinkScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropractorreports").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /offices/clinical/roles/chiropractor/reports (ChiropractorReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/reports");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for /offices/clinical/roles/chiropractor/reports (ChiropractorReportsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropractorreports-screen").should("be.visible");
    cy.getCy("chiropractorreports-title").should("be.visible");
    cy.getCy("chiropractorreports-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for /offices/clinical/roles/chiropractor/reports (ChiropractorReportsScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractor_reports");
    
    cy.updateTestRegistry("chiropractorreports", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractor_reports");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified ChiropractorReportsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropracticassessment").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /offices/clinical/roles/chiropractor/chiropractic-assessment (ChiropracticAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-assessment");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for /offices/clinical/roles/chiropractor/chiropractic-assessment (ChiropracticAssessmentScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropracticassessment-screen").should("be.visible");
    cy.getCy("chiropracticassessment-title").should("be.visible");
    cy.getCy("chiropracticassessment-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for /offices/clinical/roles/chiropractor/chiropractic-assessment (ChiropracticAssessmentScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractic_assessment");
    
    cy.updateTestRegistry("chiropracticassessment", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractic_assessment");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified ChiropracticAssessmentScreen successfully!\n");
  });


  
  cy.checkTestRegistry("adjustmentnotes").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /offices/clinical/roles/chiropractor/adjustment-notes (AdjustmentNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/adjustment-notes");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for /offices/clinical/roles/chiropractor/adjustment-notes (AdjustmentNotesScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("adjustmentnotes-screen").should("be.visible");
    cy.getCy("adjustmentnotes-title").should("be.visible");
    cy.getCy("adjustmentnotes-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for /offices/clinical/roles/chiropractor/adjustment-notes (AdjustmentNotesScreen)...");
    cy.waitAndSee();
    cy.screenshot("adjustment_notes");
    
    cy.updateTestRegistry("adjustmentnotes", "PASS", "role_chiropractor_all_screens.cy.js", "adjustment_notes");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified AdjustmentNotesScreen successfully!\n");
  });


  
  cy.checkTestRegistry("xrayreview").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /offices/clinical/roles/chiropractor/xray-review (XrayReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/xray-review");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for /offices/clinical/roles/chiropractor/xray-review (XrayReviewScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("xrayreview-screen").should("be.visible");
    cy.getCy("xrayreview-title").should("be.visible");
    cy.getCy("xrayreview-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for /offices/clinical/roles/chiropractor/xray-review (XrayReviewScreen)...");
    cy.waitAndSee();
    cy.screenshot("xray_review");
    
    cy.updateTestRegistry("xrayreview", "PASS", "role_chiropractor_all_screens.cy.js", "xray_review");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified XrayReviewScreen successfully!\n");
  });


  
  cy.checkTestRegistry("chiropracticprogresstracking").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /offices/clinical/roles/chiropractor/chiropractic-progress-tracking (ChiropracticProgressTrackingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-progress-tracking");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for /offices/clinical/roles/chiropractor/chiropractic-progress-tracking (ChiropracticProgressTrackingScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
    cy.getCy("chiropracticprogresstracking-title").should("be.visible");
    cy.getCy("chiropracticprogresstracking-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for /offices/clinical/roles/chiropractor/chiropractic-progress-tracking (ChiropracticProgressTrackingScreen)...");
    cy.waitAndSee();
    cy.screenshot("chiropractic_progress_tracking");
    
    cy.updateTestRegistry("chiropracticprogresstracking", "PASS", "role_chiropractor_all_screens.cy.js", "chiropractic_progress_tracking");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified ChiropracticProgressTrackingScreen successfully!\n");
  });


  });
});
