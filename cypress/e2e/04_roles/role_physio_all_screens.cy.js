// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - physio", () => {
  it("tests all screens for role physio", () => {
    cy.loginAsRole("physio");


  
  cy.checkTestRegistry("physiotherapistdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Navigating to /offices/clinical/roles/physiotherapist/dashboard (PhysiotherapistDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Checking shell & content for /offices/clinical/roles/physiotherapist/dashboard (PhysiotherapistDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistdashboard-screen").should("be.visible");
    cy.getCy("physiotherapistdashboard-title").should("be.visible");
    cy.getCy("physiotherapistdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Saving screenshot for /offices/clinical/roles/physiotherapist/dashboard (PhysiotherapistDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_dashboard");
    
    cy.updateTestRegistry("physiotherapistdashboard", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_dashboard");
    cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Verified PhysiotherapistDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistanalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Navigating to /offices/clinical/roles/physiotherapist/analytics (PhysiotherapistAnalyticsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Checking shell & content for /offices/clinical/roles/physiotherapist/analytics (PhysiotherapistAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistanalytics-screen").should("be.visible");
    cy.getCy("physiotherapistanalytics-title").should("be.visible");
    cy.getCy("physiotherapistanalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Saving screenshot for /offices/clinical/roles/physiotherapist/analytics (PhysiotherapistAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_analytics");
    
    cy.updateTestRegistry("physiotherapistanalytics", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_analytics");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Verified PhysiotherapistAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistcompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Navigating to /offices/clinical/roles/physiotherapist/compliance (PhysiotherapistComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Checking shell & content for /offices/clinical/roles/physiotherapist/compliance (PhysiotherapistComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistcompliance-screen").should("be.visible");
    cy.getCy("physiotherapistcompliance-title").should("be.visible");
    cy.getCy("physiotherapistcompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Saving screenshot for /offices/clinical/roles/physiotherapist/compliance (PhysiotherapistComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_compliance");
    
    cy.updateTestRegistry("physiotherapistcompliance", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_compliance");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Verified PhysiotherapistComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Navigating to /offices/clinical/roles/physiotherapist/workflow (PhysiotherapistWorkflowScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Checking shell & content for /offices/clinical/roles/physiotherapist/workflow (PhysiotherapistWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistworkflow-screen").should("be.visible");
    cy.getCy("physiotherapistworkflow-title").should("be.visible");
    cy.getCy("physiotherapistworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Saving screenshot for /offices/clinical/roles/physiotherapist/workflow (PhysiotherapistWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_workflow");
    
    cy.updateTestRegistry("physiotherapistworkflow", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Verified PhysiotherapistWorkflowScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistcommandcenter").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Navigating to /offices/clinical/roles/physiotherapist/command-center (PhysiotherapistCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/command-center");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Checking shell & content for /offices/clinical/roles/physiotherapist/command-center (PhysiotherapistCommandCenterScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistcommandcenter-screen").should("be.visible");
    cy.getCy("physiotherapistcommandcenter-title").should("be.visible");
    cy.getCy("physiotherapistcommandcenter-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Saving screenshot for /offices/clinical/roles/physiotherapist/command-center (PhysiotherapistCommandCenterScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_command_center");
    
    cy.updateTestRegistry("physiotherapistcommandcenter", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_command_center");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Verified PhysiotherapistCommandCenterScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistappointments").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Navigating to /offices/clinical/roles/physiotherapist/appointments (PhysiotherapistAppointmentsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/appointments");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Checking shell & content for /offices/clinical/roles/physiotherapist/appointments (PhysiotherapistAppointmentsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistappointments-screen").should("be.visible");
    cy.getCy("physiotherapistappointments-title").should("be.visible");
    cy.getCy("physiotherapistappointments-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Saving screenshot for /offices/clinical/roles/physiotherapist/appointments (PhysiotherapistAppointmentsScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_appointments");
    
    cy.updateTestRegistry("physiotherapistappointments", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_appointments");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Verified PhysiotherapistAppointmentsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistclientintake").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Navigating to /offices/clinical/roles/physiotherapist/client-intake (PhysiotherapistClientIntakeScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/client-intake");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Checking shell & content for /offices/clinical/roles/physiotherapist/client-intake (PhysiotherapistClientIntakeScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistclientintake-screen").should("be.visible");
    cy.getCy("physiotherapistclientintake-title").should("be.visible");
    cy.getCy("physiotherapistclientintake-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Saving screenshot for /offices/clinical/roles/physiotherapist/client-intake (PhysiotherapistClientIntakeScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_client_intake");
    
    cy.updateTestRegistry("physiotherapistclientintake", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_client_intake");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Verified PhysiotherapistClientIntakeScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistassessment").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Navigating to /offices/clinical/roles/physiotherapist/assessment (PhysiotherapistAssessmentScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/assessment");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Checking shell & content for /offices/clinical/roles/physiotherapist/assessment (PhysiotherapistAssessmentScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistassessment-screen").should("be.visible");
    cy.getCy("physiotherapistassessment-title").should("be.visible");
    cy.getCy("physiotherapistassessment-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Saving screenshot for /offices/clinical/roles/physiotherapist/assessment (PhysiotherapistAssessmentScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_assessment");
    
    cy.updateTestRegistry("physiotherapistassessment", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_assessment");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Verified PhysiotherapistAssessmentScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapisttreatmentnotes").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Navigating to /offices/clinical/roles/physiotherapist/treatment-notes (PhysiotherapistTreatmentNotesScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-notes");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Checking shell & content for /offices/clinical/roles/physiotherapist/treatment-notes (PhysiotherapistTreatmentNotesScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapisttreatmentnotes-screen").should("be.visible");
    cy.getCy("physiotherapisttreatmentnotes-title").should("be.visible");
    cy.getCy("physiotherapisttreatmentnotes-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Saving screenshot for /offices/clinical/roles/physiotherapist/treatment-notes (PhysiotherapistTreatmentNotesScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_treatment_notes");
    
    cy.updateTestRegistry("physiotherapisttreatmentnotes", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_treatment_notes");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Verified PhysiotherapistTreatmentNotesScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistexerciseplan").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Navigating to /offices/clinical/roles/physiotherapist/exercise-plan (PhysiotherapistExercisePlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-plan");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Checking shell & content for /offices/clinical/roles/physiotherapist/exercise-plan (PhysiotherapistExercisePlanScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistexerciseplan-screen").should("be.visible");
    cy.getCy("physiotherapistexerciseplan-title").should("be.visible");
    cy.getCy("physiotherapistexerciseplan-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Saving screenshot for /offices/clinical/roles/physiotherapist/exercise-plan (PhysiotherapistExercisePlanScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_exercise_plan");
    
    cy.updateTestRegistry("physiotherapistexerciseplan", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_exercise_plan");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Verified PhysiotherapistExercisePlanScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistbillinglink").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Navigating to /offices/clinical/roles/physiotherapist/billing-link (PhysiotherapistBillingLinkScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/billing-link");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Checking shell & content for /offices/clinical/roles/physiotherapist/billing-link (PhysiotherapistBillingLinkScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistbillinglink-screen").should("be.visible");
    cy.getCy("physiotherapistbillinglink-title").should("be.visible");
    cy.getCy("physiotherapistbillinglink-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Saving screenshot for /offices/clinical/roles/physiotherapist/billing-link (PhysiotherapistBillingLinkScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_billing_link");
    
    cy.updateTestRegistry("physiotherapistbillinglink", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_billing_link");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Verified PhysiotherapistBillingLinkScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiotherapistreports").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Navigating to /offices/clinical/roles/physiotherapist/reports (PhysiotherapistReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/reports");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Checking shell & content for /offices/clinical/roles/physiotherapist/reports (PhysiotherapistReportsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiotherapistreports-screen").should("be.visible");
    cy.getCy("physiotherapistreports-title").should("be.visible");
    cy.getCy("physiotherapistreports-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Saving screenshot for /offices/clinical/roles/physiotherapist/reports (PhysiotherapistReportsScreen)...");
    cy.waitAndSee();
    cy.screenshot("physiotherapist_reports");
    
    cy.updateTestRegistry("physiotherapistreports", "PASS", "role_physio_all_screens.cy.js", "physiotherapist_reports");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Verified PhysiotherapistReportsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("treatmentplan").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Navigating to /offices/clinical/roles/physiotherapist/treatment-plan (TreatmentPlanScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-plan");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Checking shell & content for /offices/clinical/roles/physiotherapist/treatment-plan (TreatmentPlanScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("treatmentplan-screen").should("be.visible");
    cy.getCy("treatmentplan-title").should("be.visible");
    cy.getCy("treatmentplan-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Saving screenshot for /offices/clinical/roles/physiotherapist/treatment-plan (TreatmentPlanScreen)...");
    cy.waitAndSee();
    cy.screenshot("treatment_plan");
    
    cy.updateTestRegistry("treatmentplan", "PASS", "role_physio_all_screens.cy.js", "treatment_plan");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Verified TreatmentPlanScreen successfully!\n");
  });


  
  cy.checkTestRegistry("exerciseprescription").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Navigating to /offices/clinical/roles/physiotherapist/exercise-prescription (ExercisePrescriptionScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-prescription");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Checking shell & content for /offices/clinical/roles/physiotherapist/exercise-prescription (ExercisePrescriptionScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("exerciseprescription-screen").should("be.visible");
    cy.getCy("exerciseprescription-title").should("be.visible");
    cy.getCy("exerciseprescription-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Saving screenshot for /offices/clinical/roles/physiotherapist/exercise-prescription (ExercisePrescriptionScreen)...");
    cy.waitAndSee();
    cy.screenshot("exercise_prescription");
    
    cy.updateTestRegistry("exerciseprescription", "PASS", "role_physio_all_screens.cy.js", "exercise_prescription");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Verified ExercisePrescriptionScreen successfully!\n");
  });


  
  cy.checkTestRegistry("progresstracking").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Navigating to /offices/clinical/roles/physiotherapist/progress-tracking (ProgressTrackingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/progress-tracking");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Checking shell & content for /offices/clinical/roles/physiotherapist/progress-tracking (ProgressTrackingScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("progresstracking-screen").should("be.visible");
    cy.getCy("progresstracking-title").should("be.visible");
    cy.getCy("progresstracking-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Saving screenshot for /offices/clinical/roles/physiotherapist/progress-tracking (ProgressTrackingScreen)...");
    cy.waitAndSee();
    cy.screenshot("progress_tracking");
    
    cy.updateTestRegistry("progresstracking", "PASS", "role_physio_all_screens.cy.js", "progress_tracking");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Verified ProgressTrackingScreen successfully!\n");
  });


  });
});
