// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - physio", () => {
  it("tests all screens for role physio", () => {
    cy.loginAsRole("physio");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /offices/clinical/roles/physiotherapist/dashboard (PhysiotherapistDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for PhysiotherapistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistdashboard-screen").should("be.visible");
  cy.getCy("physiotherapistdashboard-title").should("be.visible");
  cy.getCy("physiotherapistdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for PhysiotherapistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified PhysiotherapistDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /offices/clinical/roles/physiotherapist/analytics (PhysiotherapistAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for PhysiotherapistAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistanalytics-screen").should("be.visible");
  cy.getCy("physiotherapistanalytics-title").should("be.visible");
  cy.getCy("physiotherapistanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for PhysiotherapistAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified PhysiotherapistAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /offices/clinical/roles/physiotherapist/compliance (PhysiotherapistComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for PhysiotherapistComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcompliance-screen").should("be.visible");
  cy.getCy("physiotherapistcompliance-title").should("be.visible");
  cy.getCy("physiotherapistcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for PhysiotherapistComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified PhysiotherapistComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /offices/clinical/roles/physiotherapist/workflow (PhysiotherapistWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for PhysiotherapistWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistworkflow-screen").should("be.visible");
  cy.getCy("physiotherapistworkflow-title").should("be.visible");
  cy.getCy("physiotherapistworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for PhysiotherapistWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified PhysiotherapistWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /offices/clinical/roles/physiotherapist/command-center (PhysiotherapistCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for PhysiotherapistCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcommandcenter-screen").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-title").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for PhysiotherapistCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified PhysiotherapistCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /offices/clinical/roles/physiotherapist/appointments (PhysiotherapistAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for PhysiotherapistAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistappointments-screen").should("be.visible");
  cy.getCy("physiotherapistappointments-title").should("be.visible");
  cy.getCy("physiotherapistappointments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for PhysiotherapistAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified PhysiotherapistAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /offices/clinical/roles/physiotherapist/client-intake (PhysiotherapistClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for PhysiotherapistClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistclientintake-screen").should("be.visible");
  cy.getCy("physiotherapistclientintake-title").should("be.visible");
  cy.getCy("physiotherapistclientintake-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for PhysiotherapistClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified PhysiotherapistClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /offices/clinical/roles/physiotherapist/assessment (PhysiotherapistAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for PhysiotherapistAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistassessment-screen").should("be.visible");
  cy.getCy("physiotherapistassessment-title").should("be.visible");
  cy.getCy("physiotherapistassessment-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for PhysiotherapistAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified PhysiotherapistAssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /offices/clinical/roles/physiotherapist/treatment-notes (PhysiotherapistTreatmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for PhysiotherapistTreatmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapisttreatmentnotes-screen").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-title").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for PhysiotherapistTreatmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_treatment_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified PhysiotherapistTreatmentNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /offices/clinical/roles/physiotherapist/exercise-plan (PhysiotherapistExercisePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for PhysiotherapistExercisePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistexerciseplan-screen").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-title").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for PhysiotherapistExercisePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_exercise_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified PhysiotherapistExercisePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /offices/clinical/roles/physiotherapist/billing-link (PhysiotherapistBillingLinkScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/billing-link");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for PhysiotherapistBillingLinkScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistbillinglink-screen").should("be.visible");
  cy.getCy("physiotherapistbillinglink-title").should("be.visible");
  cy.getCy("physiotherapistbillinglink-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for PhysiotherapistBillingLinkScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_billing_link");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified PhysiotherapistBillingLinkScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /offices/clinical/roles/physiotherapist/reports (PhysiotherapistReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for PhysiotherapistReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistreports-screen").should("be.visible");
  cy.getCy("physiotherapistreports-title").should("be.visible");
  cy.getCy("physiotherapistreports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for PhysiotherapistReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified PhysiotherapistReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /offices/clinical/roles/physiotherapist/assessment (AssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for AssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("assessment-screen").should("be.visible");
  cy.getCy("assessment-title").should("be.visible");
  cy.getCy("assessment-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for AssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified AssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /offices/clinical/roles/physiotherapist/treatment-plan (TreatmentPlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for TreatmentPlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentplan-screen").should("be.visible");
  cy.getCy("treatmentplan-title").should("be.visible");
  cy.getCy("treatmentplan-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for TreatmentPlanScreen...");
  cy.waitAndSee();
  cy.screenshot("treatment_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified TreatmentPlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /offices/clinical/roles/physiotherapist/exercise-prescription (ExercisePrescriptionScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-prescription");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for ExercisePrescriptionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("exerciseprescription-screen").should("be.visible");
  cy.getCy("exerciseprescription-title").should("be.visible");
  cy.getCy("exerciseprescription-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for ExercisePrescriptionScreen...");
  cy.waitAndSee();
  cy.screenshot("exercise_prescription");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified ExercisePrescriptionScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /offices/clinical/roles/physiotherapist/progress-tracking (ProgressTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/progress-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for ProgressTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("progresstracking-screen").should("be.visible");
  cy.getCy("progresstracking-title").should("be.visible");
  cy.getCy("progresstracking-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for ProgressTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("progress_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified ProgressTrackingScreen successfully!\n");

  });
});
