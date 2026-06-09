// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Org Full UI Test", () => {

  it("tests org role chiropractor", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /offices/clinical/roles/chiropractor/dashboard (ChiropractorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for ChiropractorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractordashboard-screen").should("be.visible");
  cy.getCy("chiropractordashboard-title").should("be.visible");
  cy.getCy("chiropractordashboard-content").should("be.visible");
  cy.getCy("chiropractor-btn-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-treatment").should("be.visible");
  cy.getCy("chiropractor-btn-adjust").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for ChiropractorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified ChiropractorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /offices/clinical/roles/chiropractor/analytics (ChiropractorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for ChiropractorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractoranalytics-screen").should("be.visible");
  cy.getCy("chiropractoranalytics-title").should("be.visible");
  cy.getCy("chiropractoranalytics-content").should("be.visible");
  cy.getCy("chiropractor-btn-add-patient").should("be.visible");
  cy.getCy("chiropractor-btn-update-treatment").should("be.visible");
  cy.getCy("chiropractor-btn-record-progress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for ChiropractorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified ChiropractorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /offices/clinical/roles/chiropractor/compliance (ChiropractorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for ChiropractorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcompliance-screen").should("be.visible");
  cy.getCy("chiropractorcompliance-title").should("be.visible");
  cy.getCy("chiropractorcompliance-content").should("be.visible");
  cy.getCy("chiropractor-btn-schedule-appointment").should("be.visible");
  cy.getCy("chiropractor-btn-generate-report").should("be.visible");
  cy.getCy("chiropractor-btn-update-treatment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for ChiropractorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified ChiropractorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /offices/clinical/roles/chiropractor/workflow (ChiropractorWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for ChiropractorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorworkflow-screen").should("be.visible");
  cy.getCy("chiropractorworkflow-title").should("be.visible");
  cy.getCy("chiropractorworkflow-content").should("be.visible");
  cy.getCy("chiropractor-btn-schedule-appointment").should("be.visible");
  cy.getCy("chiropractor-btn-modify-treatment").should("be.visible");
  cy.getCy("chiropractor-btn-record-progress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for ChiropractorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified ChiropractorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /offices/clinical/roles/chiropractor/command-center (ChiropractorCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for ChiropractorCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
  cy.getCy("chiropractorcommandcenter-title").should("be.visible");
  cy.getCy("chiropractorcommandcenter-content").should("be.visible");
  cy.getCy("chiropractor-btn-add-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-update-plan").should("be.visible");
  cy.getCy("chiropractor-btn-record-adjustment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for ChiropractorCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified ChiropractorCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /offices/clinical/roles/chiropractor/appointments (ChiropractorAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for ChiropractorAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorappointments-screen").should("be.visible");
  cy.getCy("chiropractorappointments-title").should("be.visible");
  cy.getCy("chiropractorappointments-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-schedule").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-compliance").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for ChiropractorAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified ChiropractorAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /offices/clinical/roles/chiropractor/client-intake (ChiropractorClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for ChiropractorClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorclientintake-screen").should("be.visible");
  cy.getCy("chiropractorclientintake-title").should("be.visible");
  cy.getCy("chiropractorclientintake-content").should("be.visible");
  cy.getCy("chiropractor-btn-submit-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-review-history").should("be.visible");
  cy.getCy("chiropractor-btn-perform-examination").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for ChiropractorClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified ChiropractorClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /offices/clinical/roles/chiropractor/assessment (ChiropractorAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for ChiropractorAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorassessment-screen").should("be.visible");
  cy.getCy("chiropractorassessment-title").should("be.visible");
  cy.getCy("chiropractorassessment-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-active-operations").should("be.visible");
  cy.getCy("chiropractor-dashboard-security-status").should("be.visible");
  cy.getCy("chiropractor-dashboard-telemetry-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for ChiropractorAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified ChiropractorAssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /offices/clinical/roles/chiropractor/treatment-notes (ChiropractorTreatmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/treatment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for ChiropractorTreatmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-view-feedback").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-generate-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for ChiropractorTreatmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_treatment_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified ChiropractorTreatmentNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /offices/clinical/roles/chiropractor/exercise-plan (ChiropractorExercisePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/exercise-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for ChiropractorExercisePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
  cy.getCy("chiropractorexerciseplan-title").should("be.visible");
  cy.getCy("chiropractorexerciseplan-content").should("be.visible");
  cy.getCy("chiropractor-btn-add-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-update-plan").should("be.visible");
  cy.getCy("chiropractor-btn-record-adjustment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for ChiropractorExercisePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_exercise_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified ChiropractorExercisePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /offices/clinical/roles/chiropractor/billing-link (ChiropractorBillingLinkScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/billing-link");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for ChiropractorBillingLinkScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorbillinglink-screen").should("be.visible");
  cy.getCy("chiropractorbillinglink-title").should("be.visible");
  cy.getCy("chiropractorbillinglink-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-operational-action").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-view-patient-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for ChiropractorBillingLinkScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_billing_link");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified ChiropractorBillingLinkScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /offices/clinical/roles/chiropractor/reports (ChiropractorReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for ChiropractorReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorreports-screen").should("be.visible");
  cy.getCy("chiropractorreports-title").should("be.visible");
  cy.getCy("chiropractorreports-content").should("be.visible");
  cy.getCy("chiropractor-btn-compliance-scan").should("be.visible");
  cy.getCy("chiropractor-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for ChiropractorReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified ChiropractorReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /offices/clinical/roles/chiropractor/chiropractic-assessment (ChiropracticAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for ChiropracticAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticassessment-screen").should("be.visible");
  cy.getCy("chiropracticassessment-title").should("be.visible");
  cy.getCy("chiropracticassessment-content").should("be.visible");
  cy.getCy("chiropractic-assessment-save").should("be.visible");
  cy.getCy("chiropractic-treatment-update").should("be.visible");
  cy.getCy("chiropractic-adjustment-record").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for ChiropracticAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractic_assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified ChiropracticAssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /offices/clinical/roles/chiropractor/adjustment-notes (AdjustmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/adjustment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for AdjustmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adjustmentnotes-screen").should("be.visible");
  cy.getCy("adjustmentnotes-title").should("be.visible");
  cy.getCy("adjustmentnotes-content").should("be.visible");
  cy.getCy("dashboard-btn-view-records").should("be.visible");
  cy.getCy("dashboard-btn-generate-report").should("be.visible");
  cy.getCy("dashboard-btn-update-treatment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for AdjustmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("adjustment_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified AdjustmentNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /offices/clinical/roles/chiropractor/xray-review (XrayReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/xray-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for XrayReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("xrayreview-screen").should("be.visible");
  cy.getCy("xrayreview-title").should("be.visible");
  cy.getCy("xrayreview-content").should("be.visible");
  cy.getCy("xrayreview-btn-save").should("be.visible");
  cy.getCy("xrayreview-btn-review").should("be.visible");
  cy.getCy("xrayreview-btn-logprogress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for XrayReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("xray_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified XrayReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /offices/clinical/roles/chiropractor/chiropractic-progress-tracking (ChiropracticProgressTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-progress-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for ChiropracticProgressTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
  cy.getCy("chiropracticprogresstracking-title").should("be.visible");
  cy.getCy("chiropracticprogresstracking-content").should("be.visible");
  cy.getCy("chiropractic-btn-save-assessment").should("be.visible");
  cy.getCy("chiropractic-btn-update-treatment").should("be.visible");
  cy.getCy("chiropractic-btn-record-progress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for ChiropracticProgressTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractic_progress_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified ChiropracticProgressTrackingScreen successfully!\n");
  });

  it("tests org role physio", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Navigating to /offices/clinical/roles/physiotherapist/dashboard (PhysiotherapistDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Checking shell & content for PhysiotherapistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistdashboard-screen").should("be.visible");
  cy.getCy("physiotherapistdashboard-title").should("be.visible");
  cy.getCy("physiotherapistdashboard-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-sync").should("be.visible");
  cy.getCy("physio-dashboard-btn-export").should("be.visible");
  cy.getCy("physio-dashboard-btn-educational-resources").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Saving screenshot for PhysiotherapistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/15 | 6%] - Verified PhysiotherapistDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Navigating to /offices/clinical/roles/physiotherapist/analytics (PhysiotherapistAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Checking shell & content for PhysiotherapistAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistanalytics-screen").should("be.visible");
  cy.getCy("physiotherapistanalytics-title").should("be.visible");
  cy.getCy("physiotherapistanalytics-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-save").should("be.visible");
  cy.getCy("physio-dashboard-btn-update").should("be.visible");
  cy.getCy("physio-dashboard-btn-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Saving screenshot for PhysiotherapistAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/15 | 13%] - Verified PhysiotherapistAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Navigating to /offices/clinical/roles/physiotherapist/compliance (PhysiotherapistComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Checking shell & content for PhysiotherapistComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcompliance-screen").should("be.visible");
  cy.getCy("physiotherapistcompliance-title").should("be.visible");
  cy.getCy("physiotherapistcompliance-content").should("be.visible");
  cy.getCy("physio-btn-save-treatment").should("be.visible");
  cy.getCy("physio-btn-monitor-progress").should("be.visible");
  cy.getCy("physio-btn-educate-patient").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Saving screenshot for PhysiotherapistComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/15 | 20%] - Verified PhysiotherapistComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Navigating to /offices/clinical/roles/physiotherapist/workflow (PhysiotherapistWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Checking shell & content for PhysiotherapistWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistworkflow-screen").should("be.visible");
  cy.getCy("physiotherapistworkflow-title").should("be.visible");
  cy.getCy("physiotherapistworkflow-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-records").should("be.visible");
  cy.getCy("physio-dashboard-btn-alert-redflag").should("be.visible");
  cy.getCy("physio-dashboard-btn-track-progress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Saving screenshot for PhysiotherapistWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/15 | 26%] - Verified PhysiotherapistWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Navigating to /offices/clinical/roles/physiotherapist/command-center (PhysiotherapistCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Checking shell & content for PhysiotherapistCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcommandcenter-screen").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-title").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-content").should("be.visible");
  cy.getCy("physio-btn-save-treatment").should("be.visible");
  cy.getCy("physio-btn-update-progress").should("be.visible");
  cy.getCy("physio-btn-send-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Saving screenshot for PhysiotherapistCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/15 | 33%] - Verified PhysiotherapistCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Navigating to /offices/clinical/roles/physiotherapist/appointments (PhysiotherapistAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Checking shell & content for PhysiotherapistAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistappointments-screen").should("be.visible");
  cy.getCy("physiotherapistappointments-title").should("be.visible");
  cy.getCy("physiotherapistappointments-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-appointment").should("be.visible");
  cy.getCy("physio-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-kpis").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Saving screenshot for PhysiotherapistAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/15 | 40%] - Verified PhysiotherapistAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Navigating to /offices/clinical/roles/physiotherapist/client-intake (PhysiotherapistClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Checking shell & content for PhysiotherapistClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistclientintake-screen").should("be.visible");
  cy.getCy("physiotherapistclientintake-title").should("be.visible");
  cy.getCy("physiotherapistclientintake-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-save").should("be.visible");
  cy.getCy("physio-dashboard-btn-update").should("be.visible");
  cy.getCy("physio-dashboard-btn-emergency").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Saving screenshot for PhysiotherapistClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/15 | 46%] - Verified PhysiotherapistClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Navigating to /offices/clinical/roles/physiotherapist/assessment (PhysiotherapistAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Checking shell & content for PhysiotherapistAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistassessment-screen").should("be.visible");
  cy.getCy("physiotherapistassessment-title").should("be.visible");
  cy.getCy("physiotherapistassessment-content").should("be.visible");
  cy.getCy("physio-assessment-save").should("be.visible");
  cy.getCy("physio-treatment-update").should("be.visible");
  cy.getCy("physio-progress-monitor").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Saving screenshot for PhysiotherapistAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/15 | 53%] - Verified PhysiotherapistAssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Navigating to /offices/clinical/roles/physiotherapist/treatment-notes (PhysiotherapistTreatmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Checking shell & content for PhysiotherapistTreatmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapisttreatmentnotes-screen").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-title").should("be.visible");
  cy.getCy("physiotherapisttreatmentnotes-content").should("be.visible");
  cy.getCy("physio-btn-save-treatment").should("be.visible");
  cy.getCy("physio-btn-update-progress").should("be.visible");
  cy.getCy("physio-btn-refer-specialist").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Saving screenshot for PhysiotherapistTreatmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_treatment_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/15 | 60%] - Verified PhysiotherapistTreatmentNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Navigating to /offices/clinical/roles/physiotherapist/exercise-plan (PhysiotherapistExercisePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Checking shell & content for PhysiotherapistExercisePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistexerciseplan-screen").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-title").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-add-exercise").should("be.visible");
  cy.getCy("physio-dashboard-btn-monitor-progress").should("be.visible");
  cy.getCy("physio-dashboard-btn-update-record").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Saving screenshot for PhysiotherapistExercisePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_exercise_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/15 | 66%] - Verified PhysiotherapistExercisePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Navigating to /offices/clinical/roles/physiotherapist/billing-link (PhysiotherapistBillingLinkScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/billing-link");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Checking shell & content for PhysiotherapistBillingLinkScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistbillinglink-screen").should("be.visible");
  cy.getCy("physiotherapistbillinglink-title").should("be.visible");
  cy.getCy("physiotherapistbillinglink-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-update-treatment").should("be.visible");
  cy.getCy("physio-dashboard-btn-log-progress").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Saving screenshot for PhysiotherapistBillingLinkScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_billing_link");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/15 | 73%] - Verified PhysiotherapistBillingLinkScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Navigating to /offices/clinical/roles/physiotherapist/reports (PhysiotherapistReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Checking shell & content for PhysiotherapistReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistreports-screen").should("be.visible");
  cy.getCy("physiotherapistreports-title").should("be.visible");
  cy.getCy("physiotherapistreports-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-update-treatment").should("be.visible");
  cy.getCy("physio-dashboard-btn-log-progress").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Saving screenshot for PhysiotherapistReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/15 | 80%] - Verified PhysiotherapistReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Navigating to /offices/clinical/roles/physiotherapist/treatment-plan (TreatmentPlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/treatment-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Checking shell & content for TreatmentPlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentplan-screen").should("be.visible");
  cy.getCy("treatmentplan-title").should("be.visible");
  cy.getCy("treatmentplan-content").should("be.visible");
  cy.getCy("treatmentplan-btn-save").should("be.visible");
  cy.getCy("treatmentplan-btn-adjust").should("be.visible");
  cy.getCy("treatmentplan-btn-loginteraction").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Saving screenshot for TreatmentPlanScreen...");
  cy.waitAndSee();
  cy.screenshot("treatment_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/15 | 86%] - Verified TreatmentPlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Navigating to /offices/clinical/roles/physiotherapist/exercise-prescription (ExercisePrescriptionScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-prescription");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Checking shell & content for ExercisePrescriptionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("exerciseprescription-screen").should("be.visible");
  cy.getCy("exerciseprescription-title").should("be.visible");
  cy.getCy("exerciseprescription-content").should("be.visible");
  cy.getCy("pswdashboard-btn-update-status").should("be.visible");
  cy.getCy("pswdashboard-btn-log-compliance").should("be.visible");
  cy.getCy("pswdashboard-btn-view-kpis").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Saving screenshot for ExercisePrescriptionScreen...");
  cy.waitAndSee();
  cy.screenshot("exercise_prescription");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [14/15 | 93%] - Verified ExercisePrescriptionScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Navigating to /offices/clinical/roles/physiotherapist/progress-tracking (ProgressTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/progress-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Checking shell & content for ProgressTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("progresstracking-screen").should("be.visible");
  cy.getCy("progresstracking-title").should("be.visible");
  cy.getCy("progresstracking-content").should("be.visible");
  cy.getCy("progress-tracking-btn-add-task").should("be.visible");
  cy.getCy("progress-tracking-btn-update-treatment").should("be.visible");
  cy.getCy("progress-tracking-btn-monitor").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Saving screenshot for ProgressTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("progress_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [15/15 | 100%] - Verified ProgressTrackingScreen successfully!\n");
  });

  it("tests org role rmt", () => {
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

  it("tests org role social_worker", () => {
    cy.loginAsRole("social_worker");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/clinical/roles/social_worker/dashboard (SocialWorkerDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for SocialWorkerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerdashboard-screen").should("be.visible");
  cy.getCy("socialworkerdashboard-title").should("be.visible");
  cy.getCy("socialworkerdashboard-content").should("be.visible");
  cy.getCy("sw-dashboard-btn-add-task").should("be.visible");
  cy.getCy("sw-dashboard-btn-update-progress").should("be.visible");
  cy.getCy("sw-dashboard-btn-view-resources").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for SocialWorkerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified SocialWorkerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /offices/clinical/roles/social_worker/analytics (SocialWorkerAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for SocialWorkerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkeranalytics-screen").should("be.visible");
  cy.getCy("socialworkeranalytics-title").should("be.visible");
  cy.getCy("socialworkeranalytics-content").should("be.visible");
  cy.getCy("socialworker-btn-add-assessment").should("be.visible");
  cy.getCy("socialworker-btn-schedule-appointment").should("be.visible");
  cy.getCy("socialworker-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for SocialWorkerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified SocialWorkerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /offices/clinical/roles/social_worker/compliance (SocialWorkerComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for SocialWorkerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkercompliance-screen").should("be.visible");
  cy.getCy("socialworkercompliance-title").should("be.visible");
  cy.getCy("socialworkercompliance-content").should("be.visible");
  cy.getCy("socialworker-btn-report-incident").should("be.visible");
  cy.getCy("socialworker-btn-update-security").should("be.visible");
  cy.getCy("socialworker-btn-access-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for SocialWorkerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified SocialWorkerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /offices/clinical/roles/social_worker/workflow (SocialWorkerWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for SocialWorkerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerworkflow-screen").should("be.visible");
  cy.getCy("socialworkerworkflow-title").should("be.visible");
  cy.getCy("socialworkerworkflow-content").should("be.visible");
  cy.getCy("socialworker-btn-add-task").should("be.visible");
  cy.getCy("socialworker-btn-view-client").should("be.visible");
  cy.getCy("socialworker-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for SocialWorkerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified SocialWorkerWorkflowScreen successfully!\n");
  });

  it("tests org role therapist", () => {
    cy.loginAsRole("therapist");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /offices/clinical/roles/therapist/dashboard (TherapistDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/therapist/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for TherapistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistdashboard-screen").should("be.visible");
  cy.getCy("therapistdashboard-title").should("be.visible");
  cy.getCy("therapistdashboard-content").should("be.visible");
  cy.getCy("therapist-dashboard-btn-start-session").should("be.visible");
  cy.getCy("therapist-dashboard-btn-finalize-notes").should("be.visible");
  cy.getCy("therapist-dashboard-btn-run-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for TherapistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("therapist_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified TherapistDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /offices/clinical/roles/therapist/analytics (Therapist Analytics)...");
  cy.visitWithSemantics("/offices/clinical/roles/therapist/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Therapist Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistanalytics-screen").should("be.visible");
  cy.getCy("therapistanalytics-title").should("be.visible");
  cy.getCy("therapistanalytics-content").should("be.visible");
  cy.getCy("therapist-dashboard-caseload").should("be.visible");
  cy.getCy("therapist-dashboard-progress").should("be.visible");
  cy.getCy("therapist-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Therapist Analytics...");
  cy.waitAndSee();
  cy.screenshot("therapist_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Therapist Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /offices/clinical/roles/therapist/workflow (Therapist Compliance Workflow)...");
  cy.visitWithSemantics("/offices/clinical/roles/therapist/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Therapist Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistworkflow-screen").should("be.visible");
  cy.getCy("therapistworkflow-title").should("be.visible");
  cy.getCy("therapistworkflow-content").should("be.visible");
  cy.getCy("therapist-dashboard-btn-quality-sweep").should("be.visible");
  cy.getCy("therapist-dashboard-btn-view-progress").should("be.visible");
  cy.getCy("therapist-dashboard-btn-respond-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Therapist Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("therapist_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Therapist Compliance Workflow successfully!\n");
  });

  it("tests org role clinical_director", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Navigating to /offices/clinical/roles/clinical_director/dashboard (ClinicalDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Checking shell & content for ClinicalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldashboard-screen").should("be.visible");
  cy.getCy("clinicaldashboard-title").should("be.visible");
  cy.getCy("clinicaldashboard-content").should("be.visible");
  cy.getCy("clinical-dashboard-compliance-status").should("be.visible");
  cy.getCy("clinical-dashboard-performance-metrics").should("be.visible");
  cy.getCy("clinical-dashboard-activity-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Saving screenshot for ClinicalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Verified ClinicalDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Navigating to /offices/clinical/roles/clinical_director/clinic-dashboard (ClinicDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Checking shell & content for ClinicDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicdashboard-screen").should("be.visible");
  cy.getCy("clinicdashboard-title").should("be.visible");
  cy.getCy("clinicdashboard-content").should("be.visible");
  cy.getCy("clinic-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinic-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinic-dashboard-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Saving screenshot for ClinicDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Verified ClinicDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Navigating to /offices/clinical/roles/clinical_director/analytics (ClinicalAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Checking shell & content for ClinicalAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalanalytics-screen").should("be.visible");
  cy.getCy("clinicalanalytics-title").should("be.visible");
  cy.getCy("clinicalanalytics-content").should("be.visible");
  cy.getCy("clinical-analytics-kpi-chart").should("be.visible");
  cy.getCy("clinical-analytics-staff-performance").should("be.visible");
  cy.getCy("clinical-analytics-compliance-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Saving screenshot for ClinicalAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Verified ClinicalAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Navigating to /offices/clinical/roles/clinical_director/compliance (ClinicalComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Checking shell & content for ClinicalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalcompliance-screen").should("be.visible");
  cy.getCy("clinicalcompliance-title").should("be.visible");
  cy.getCy("clinicalcompliance-content").should("be.visible");
  cy.getCy("clinical-compliance-audit-results").should("be.visible");
  cy.getCy("clinical-compliance-alert").should("be.visible");
  cy.getCy("clinical-training-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Saving screenshot for ClinicalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Verified ClinicalComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Navigating to /offices/clinical/roles/clinical_director/workflow (ClinicalWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Checking shell & content for ClinicalWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalworkflow-screen").should("be.visible");
  cy.getCy("clinicalworkflow-title").should("be.visible");
  cy.getCy("clinicalworkflow-content").should("be.visible");
  cy.getCy("clinical-dashboard-kpi").should("be.visible");
  cy.getCy("clinical-dashboard-policies").should("be.visible");
  cy.getCy("clinical-dashboard-budgets").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Saving screenshot for ClinicalWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Verified ClinicalWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Navigating to /offices/clinical/roles/clinical_director/clinic-analytics (ClinicAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Checking shell & content for ClinicAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicanalytics-screen").should("be.visible");
  cy.getCy("clinicanalytics-title").should("be.visible");
  cy.getCy("clinicanalytics-content").should("be.visible");
  cy.getCy("clinic-analytics-btn-view-reports").should("be.visible");
  cy.getCy("clinic-analytics-btn-manage-budgets").should("be.visible");
  cy.getCy("clinic-analytics-btn-staff-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Saving screenshot for ClinicAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Verified ClinicAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Navigating to /offices/clinical/roles/clinical_director/clinic-compliance (ClinicComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Checking shell & content for ClinicComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cliniccompliance-screen").should("be.visible");
  cy.getCy("cliniccompliance-title").should("be.visible");
  cy.getCy("cliniccompliance-content").should("be.visible");
  cy.getCy("clinic-compliance-audit-results").should("be.visible");
  cy.getCy("clinic-patient-satisfaction").should("be.visible");
  cy.getCy("clinic-staff-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Saving screenshot for ClinicComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Verified ClinicComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Navigating to /offices/clinical/roles/clinical_director/clinic-workflow (ClinicWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Checking shell & content for ClinicWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicworkflow-screen").should("be.visible");
  cy.getCy("clinicworkflow-title").should("be.visible");
  cy.getCy("clinicworkflow-content").should("be.visible");
  cy.getCy("clinic-dashboard-kpi").should("be.visible");
  cy.getCy("clinic-dashboard-budget").should("be.visible");
  cy.getCy("clinic-dashboard-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Saving screenshot for ClinicWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Verified ClinicWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Navigating to /offices/clinical/roles/clinical_director/staff-quality (ClinicalDirectorStaffQualityScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Checking shell & content for ClinicalDirectorStaffQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorstaffquality-screen").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-title").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Saving screenshot for ClinicalDirectorStaffQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_staff_quality");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Verified ClinicalDirectorStaffQualityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Navigating to /offices/clinical/roles/clinical_director/incident-review (ClinicalDirectorIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Checking shell & content for ClinicalDirectorIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorincidentreview-screen").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-title").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-incidents").should("be.visible");
  cy.getCy("clinical-dashboard-btn-conduct-audit").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Saving screenshot for ClinicalDirectorIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_incident_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Verified ClinicalDirectorIncidentReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Navigating to /offices/clinical/roles/clinical_director/compliance-director (ClinicalDirectorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-director");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Checking shell & content for ClinicalDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorcompliance-screen").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-title").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-content").should("be.visible");
  cy.getCy("clinical-dashboard-compliance-status").should("be.visible");
  cy.getCy("clinical-dashboard-performance-metrics").should("be.visible");
  cy.getCy("clinical-dashboard-audit-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Saving screenshot for ClinicalDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Verified ClinicalDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Navigating to /offices/clinical/roles/clinical_director/reports (ClinicalDirectorReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Checking shell & content for ClinicalDirectorReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorreports-screen").should("be.visible");
  cy.getCy("clinicaldirectorreports-title").should("be.visible");
  cy.getCy("clinicaldirectorreports-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Saving screenshot for ClinicalDirectorReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Verified ClinicalDirectorReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Navigating to /offices/clinical/roles/clinical_director/approvals (ClinicalDirectorApprovalsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/approvals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Checking shell & content for ClinicalDirectorApprovalsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorapprovals-screen").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-title").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-content").should("be.visible");
  cy.getCy("clinical-director-btn-approve-protocols").should("be.visible");
  cy.getCy("clinical-director-btn-conduct-audit").should("be.visible");
  cy.getCy("clinical-director-btn-view-reports").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Saving screenshot for ClinicalDirectorApprovalsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_approvals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Verified ClinicalDirectorApprovalsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Navigating to /offices/clinical/roles/clinical_director/performance (ClinicalDirectorPerformanceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Checking shell & content for ClinicalDirectorPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorperformance-screen").should("be.visible");
  cy.getCy("clinicaldirectorperformance-title").should("be.visible");
  cy.getCy("clinicaldirectorperformance-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Saving screenshot for ClinicalDirectorPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_performance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Verified ClinicalDirectorPerformanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Navigating to /offices/clinical/roles/clinical_director/quality (ClinicalQualityScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Checking shell & content for ClinicalQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalquality-screen").should("be.visible");
  cy.getCy("clinicalquality-title").should("be.visible");
  cy.getCy("clinicalquality-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Saving screenshot for ClinicalQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_quality");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Verified ClinicalQualityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Navigating to /offices/clinical/roles/clinical_director/staff-performance (StaffPerformanceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Checking shell & content for StaffPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffperformance-screen").should("be.visible");
  cy.getCy("staffperformance-title").should("be.visible");
  cy.getCy("staffperformance-content").should("be.visible");
  cy.getCy("staffperformance-kpi-widget").should("be.visible");
  cy.getCy("staffperformance-compliance-card").should("be.visible");
  cy.getCy("staffperformance-satisfaction-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Saving screenshot for StaffPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_performance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Verified StaffPerformanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Navigating to /offices/clinical/roles/clinical_director/compliance-review (ComplianceReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Checking shell & content for ComplianceReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereview-screen").should("be.visible");
  cy.getCy("compliancereview-title").should("be.visible");
  cy.getCy("compliancereview-content").should("be.visible");
  cy.getCy("compliance-status-card").should("be.visible");
  cy.getCy("audit-results-chart").should("be.visible");
  cy.getCy("kpi-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Saving screenshot for ComplianceReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Verified ComplianceReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Navigating to /offices/clinical/roles/clinical_director/incident-oversight (IncidentOversightScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-oversight");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Checking shell & content for IncidentOversightScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentoversight-screen").should("be.visible");
  cy.getCy("incidentoversight-title").should("be.visible");
  cy.getCy("incidentoversight-content").should("be.visible");
  cy.getCy("incident-report-widget").should("be.visible");
  cy.getCy("compliance-scan-results-widget").should("be.visible");
  cy.getCy("kpi-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Saving screenshot for IncidentOversightScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_oversight");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Verified IncidentOversightScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Navigating to /offices/clinical/roles/clinical_director/operations4k (ClinicalOperations4KScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/operations4k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Checking shell & content for ClinicalOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaloperations4k-screen").should("be.visible");
  cy.getCy("clinicaloperations4k-title").should("be.visible");
  cy.getCy("clinicaloperations4k-content").should("be.visible");
  cy.getCy("clinical-dashboard-compliance-status").should("be.visible");
  cy.getCy("clinical-dashboard-performance-metrics").should("be.visible");
  cy.getCy("clinical-dashboard-staff-engagement").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Saving screenshot for ClinicalOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Verified ClinicalOperations4KScreen successfully!\n");
  });

  it("tests org role intake", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Navigating to /offices/clinical/roles/intake_coordinator/dashboard (IntakeDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Checking shell & content for IntakeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakedashboard-screen").should("be.visible");
  cy.getCy("intakedashboard-title").should("be.visible");
  cy.getCy("intakedashboard-content").should("be.visible");
  cy.getCy("intake-dashboard-active-requests").should("be.visible");
  cy.getCy("intake-dashboard-appointment-metrics").should("be.visible");
  cy.getCy("intake-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Saving screenshot for IntakeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Verified IntakeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Navigating to /offices/clinical/roles/intake_coordinator/dashboard (IntakeCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Checking shell & content for IntakeCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
  cy.getCy("intakecoordinatordashboard-title").should("be.visible");
  cy.getCy("intakecoordinatordashboard-content").should("be.visible");
  cy.getCy("intake-dashboard-active-operations").should("be.visible");
  cy.getCy("intake-dashboard-security-clearance").should("be.visible");
  cy.getCy("intake-dashboard-system-latency").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Saving screenshot for IntakeCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Verified IntakeCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Navigating to /offices/clinical/roles/intake_coordinator/analytics (IntakeAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Checking shell & content for IntakeAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeanalytics-screen").should("be.visible");
  cy.getCy("intakeanalytics-title").should("be.visible");
  cy.getCy("intakeanalytics-content").should("be.visible");
  cy.getCy("intake-dashboard-btn-schedule").should("be.visible");
  cy.getCy("intake-dashboard-btn-verify").should("be.visible");
  cy.getCy("intake-dashboard-btn-submitFollowUp").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Saving screenshot for IntakeAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Verified IntakeAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Navigating to /offices/clinical/roles/intake_coordinator/compliance (IntakeComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Checking shell & content for IntakeComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecompliance-screen").should("be.visible");
  cy.getCy("intakecompliance-title").should("be.visible");
  cy.getCy("intakecompliance-content").should("be.visible");
  cy.getCy("compliance-status-indicator").should("be.visible");
  cy.getCy("audit-log-table").should("be.visible");
  cy.getCy("compliance-alert-banner").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Saving screenshot for IntakeComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Verified IntakeComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Navigating to /offices/clinical/roles/intake_coordinator/workflow (IntakeWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Checking shell & content for IntakeWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeworkflow-screen").should("be.visible");
  cy.getCy("intakeworkflow-title").should("be.visible");
  cy.getCy("intakeworkflow-content").should("be.visible");
  cy.getCy("intake-dashboard-referral-status").should("be.visible");
  cy.getCy("intake-dashboard-appointment-calendar").should("be.visible");
  cy.getCy("intake-dashboard-patient-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Saving screenshot for IntakeWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Verified IntakeWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-analytics (IntakeCoordinatorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Checking shell & content for IntakeCoordinatorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatoranalytics-screen").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-title").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-content").should("be.visible");
  cy.getCy("intake-coordinator-btn-schedule").should("be.visible");
  cy.getCy("intake-coordinator-btn-follow-up").should("be.visible");
  cy.getCy("intake-coordinator-btn-view-patient").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Saving screenshot for IntakeCoordinatorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Verified IntakeCoordinatorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-compliance (IntakeCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Checking shell & content for IntakeCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorcompliance-screen").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-title").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-content").should("be.visible");
  cy.getCy("compliance-audit-status-card").should("be.visible");
  cy.getCy("operational-log-widget").should("be.visible");
  cy.getCy("compliance-violation-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Saving screenshot for IntakeCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Verified IntakeCoordinatorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-workflow (IntakeCoordinatorWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Checking shell & content for IntakeCoordinatorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorworkflow-screen").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-title").should("be.visible");
  cy.getCy("intakecoordinatorworkflow-content").should("be.visible");
  cy.getCy("intake-coordinator-btn-schedule").should("be.visible");
  cy.getCy("intake-coordinator-btn-verify").should("be.visible");
  cy.getCy("intake-coordinator-btn-communicate").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Saving screenshot for IntakeCoordinatorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Verified IntakeCoordinatorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Navigating to /offices/clinical/roles/intake_coordinator/referral-management (ReferralManagementScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/referral-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Checking shell & content for ReferralManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("referralmanagement-screen").should("be.visible");
  cy.getCy("referralmanagement-title").should("be.visible");
  cy.getCy("referralmanagement-content").should("be.visible");
  cy.getCy("referral-dashboard-btn-schedule").should("be.visible");
  cy.getCy("referral-dashboard-btn-reminder").should("be.visible");
  cy.getCy("referral-dashboard-btn-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Saving screenshot for ReferralManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("referral_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Verified ReferralManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Navigating to /offices/clinical/roles/intake_coordinator/client-intake (ClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Checking shell & content for ClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientintake-screen").should("be.visible");
  cy.getCy("clientintake-title").should("be.visible");
  cy.getCy("clientintake-content").should("be.visible");
  cy.getCy("client-intake-status-card").should("be.visible");
  cy.getCy("compliance-scan-results-table").should("be.visible");
  cy.getCy("operational-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Saving screenshot for ClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Verified ClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Navigating to /offices/clinical/roles/intake_coordinator/booking (BookingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/booking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Checking shell & content for BookingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("booking-screen").should("be.visible");
  cy.getCy("booking-title").should("be.visible");
  cy.getCy("booking-content").should("be.visible");
  cy.getCy("booking-btn-schedule").should("be.visible");
  cy.getCy("booking-btn-verify").should("be.visible");
  cy.getCy("booking-btn-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Saving screenshot for BookingScreen...");
  cy.waitAndSee();
  cy.screenshot("booking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Verified BookingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Navigating to /offices/clinical/roles/intake_coordinator/followup (FollowupScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/followup");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Checking shell & content for FollowupScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("followup-screen").should("be.visible");
  cy.getCy("followup-title").should("be.visible");
  cy.getCy("followup-content").should("be.visible");
  cy.getCy("followup-btn-schedule").should("be.visible");
  cy.getCy("followup-btn-verify").should("be.visible");
  cy.getCy("followup-btn-send").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Saving screenshot for FollowupScreen...");
  cy.waitAndSee();
  cy.screenshot("followup");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Verified FollowupScreen successfully!\n");
  });

  it("tests org role rn", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/39 | 2%] - Navigating to /common/system-dashboard (SystemDashboardScreen)...");
  cy.visitWithSemantics("/common/system-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/39 | 2%] - Checking shell & content for SystemDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemdashboard-screen").should("be.visible");
  cy.getCy("systemdashboard-title").should("be.visible");
  cy.getCy("systemdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-refresh").should("be.visible");
  cy.getCy("govdashboard-btn-view-audit").should("be.visible");
  cy.getCy("govdashboard-btn-download-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/39 | 2%] - Saving screenshot for SystemDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("system_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/39 | 2%] - Verified SystemDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/39 | 5%] - Navigating to /management/governance-officer-dashboard (GovernanceOfficerDashboardScreen)...");
  cy.visitWithSemantics("/management/governance-officer-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/39 | 5%] - Checking shell & content for GovernanceOfficerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-execute-compliance-scan").should("be.visible");
  cy.getCy("govdashboard-btn-export-audit-logs").should("be.visible");
  cy.getCy("govdashboard-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/39 | 5%] - Saving screenshot for GovernanceOfficerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/39 | 5%] - Verified GovernanceOfficerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/39 | 7%] - Navigating to /offices/clinical/roles/rn/dashboard (RnDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/39 | 7%] - Checking shell & content for RnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rndashboard-screen").should("be.visible");
  cy.getCy("rndashboard-title").should("be.visible");
  cy.getCy("rndashboard-content").should("be.visible");
  cy.getCy("rn-dashboard-btn-view-status").should("be.visible");
  cy.getCy("rn-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("rn-dashboard-btn-log-interaction").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/39 | 7%] - Saving screenshot for RnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/39 | 7%] - Verified RnDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/39 | 10%] - Navigating to /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/39 | 10%] - Checking shell & content for RnFieldSupervisorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");
  cy.getCy("rnfdashboard-btn-submit-audit").should("be.visible");
  cy.getCy("rnfdashboard-btn-update-policy").should("be.visible");
  cy.getCy("rnfdashboard-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/39 | 10%] - Saving screenshot for RnFieldSupervisorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/39 | 10%] - Verified RnFieldSupervisorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/39 | 12%] - Navigating to /management/governance-officer-analytics (GovernanceOfficerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/governance-officer-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/39 | 12%] - Checking shell & content for GovernanceOfficerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficeranalytics-screen").should("be.visible");
  cy.getCy("governanceofficeranalytics-title").should("be.visible");
  cy.getCy("governanceofficeranalytics-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-send-alert").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/39 | 12%] - Saving screenshot for GovernanceOfficerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/39 | 12%] - Verified GovernanceOfficerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/39 | 15%] - Navigating to /management/governance-officer-compliance (GovernanceOfficerComplianceScreen)...");
  cy.visitWithSemantics("/management/governance-officer-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/39 | 15%] - Checking shell & content for GovernanceOfficerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");
  cy.getCy("govdashboard-btn-start-audit").should("be.visible");
  cy.getCy("govdashboard-btn-view-reports").should("be.visible");
  cy.getCy("govdashboard-btn-generate-training-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/39 | 15%] - Saving screenshot for GovernanceOfficerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/39 | 15%] - Verified GovernanceOfficerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/39 | 17%] - Navigating to /management/governance-officer-workflow (GovernanceOfficerWorkflowScreen)...");
  cy.visitWithSemantics("/management/governance-officer-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/39 | 17%] - Checking shell & content for GovernanceOfficerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerworkflow-screen").should("be.visible");
  cy.getCy("governanceofficerworkflow-title").should("be.visible");
  cy.getCy("governanceofficerworkflow-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-submit-incident").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/39 | 17%] - Saving screenshot for GovernanceOfficerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/39 | 17%] - Verified GovernanceOfficerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/39 | 20%] - Navigating to /offices/clinical/roles/rn/rn-analytics (RnAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/39 | 20%] - Checking shell & content for RnAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnanalytics-screen").should("be.visible");
  cy.getCy("rnanalytics-title").should("be.visible");
  cy.getCy("rnanalytics-content").should("be.visible");
  cy.getCy("rn-dashboard-mmse-score").should("be.visible");
  cy.getCy("rn-dashboard-completed-intakes").should("be.visible");
  cy.getCy("rn-dashboard-active-care-plans").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/39 | 20%] - Saving screenshot for RnAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/39 | 20%] - Verified RnAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/39 | 23%] - Navigating to /offices/clinical/roles/rn/rn-assessments (RnAssessmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-assessments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/39 | 23%] - Checking shell & content for RnAssessmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnassessments-screen").should("be.visible");
  cy.getCy("rnassessments-title").should("be.visible");
  cy.getCy("rnassessments-content").should("be.visible");
  cy.getCy("rn-assessment-btn-submit").should("be.visible");
  cy.getCy("rn-assessment-btn-view-history").should("be.visible");
  cy.getCy("rn-assessment-btn-send-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/39 | 23%] - Saving screenshot for RnAssessmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_assessments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/39 | 23%] - Verified RnAssessmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/39 | 25%] - Navigating to /offices/clinical/roles/rn/rn-care-plans (RnCarePlansScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-care-plans");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/39 | 25%] - Checking shell & content for RnCarePlansScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplans-screen").should("be.visible");
  cy.getCy("rncareplans-title").should("be.visible");
  cy.getCy("rncareplans-content").should("be.visible");
  cy.getCy("rn-dashboard-careplan-overview").should("be.visible");
  cy.getCy("rn-dashboard-patient-demographics").should("be.visible");
  cy.getCy("rn-dashboard-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/39 | 25%] - Saving screenshot for RnCarePlansScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_care_plans");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/39 | 25%] - Verified RnCarePlansScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [11/39 | 28%] - Navigating to /offices/clinical/roles/rn/rn-compliance (RnComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [11/39 | 28%] - Checking shell & content for RnComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncompliance-screen").should("be.visible");
  cy.getCy("rncompliance-title").should("be.visible");
  cy.getCy("rncompliance-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-status").should("be.visible");
  cy.getCy("rn-dashboard-medication-record").should("be.visible");
  cy.getCy("rn-dashboard-compliance-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [11/39 | 28%] - Saving screenshot for RnComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [11/39 | 28%] - Verified RnComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/39 | 30%] - Navigating to /offices/clinical/roles/rn/rn-workflow (RnWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/39 | 30%] - Checking shell & content for RnWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnworkflow-screen").should("be.visible");
  cy.getCy("rnworkflow-title").should("be.visible");
  cy.getCy("rnworkflow-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-list").should("be.visible");
  cy.getCy("rn-dashboard-medication-records").should("be.visible");
  cy.getCy("rn-dashboard-care-plan-editor").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/39 | 30%] - Saving screenshot for RnWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/39 | 30%] - Verified RnWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/39 | 33%] - Navigating to /offices/clinical/roles/rn/rn-command-center (RnCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/39 | 33%] - Checking shell & content for RnCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncommandcenter-screen").should("be.visible");
  cy.getCy("rncommandcenter-title").should("be.visible");
  cy.getCy("rncommandcenter-content").should("be.visible");
  cy.getCy("rn-dashboard-btn-view-status").should("be.visible");
  cy.getCy("rn-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("rn-dashboard-btn-view-kpis").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/39 | 33%] - Saving screenshot for RnCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/39 | 33%] - Verified RnCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/39 | 35%] - Navigating to /offices/clinical/roles/rn/patient-charting (RnPatientChartingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/patient-charting");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/39 | 35%] - Checking shell & content for RnPatientChartingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnpatientcharting-screen").should("be.visible");
  cy.getCy("rnpatientcharting-title").should("be.visible");
  cy.getCy("rnpatientcharting-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-health-status").should("be.visible");
  cy.getCy("rn-dashboard-compliance-audit").should("be.visible");
  cy.getCy("rn-dashboard-operations-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/39 | 35%] - Saving screenshot for RnPatientChartingScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_patient_charting");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/39 | 35%] - Verified RnPatientChartingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [15/39 | 38%] - Navigating to /offices/clinical/roles/rn/medications (RnMedicationsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/medications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [15/39 | 38%] - Checking shell & content for RnMedicationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnmedications-screen").should("be.visible");
  cy.getCy("rnmedications-title").should("be.visible");
  cy.getCy("rnmedications-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-status").should("be.visible");
  cy.getCy("rn-dashboard-medication-compliance").should("be.visible");
  cy.getCy("rn-dashboard-assessment-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [15/39 | 38%] - Saving screenshot for RnMedicationsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_medications");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [15/39 | 38%] - Verified RnMedicationsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/39 | 41%] - Navigating to /offices/clinical/roles/rn/vitals (RnVitalsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/vitals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/39 | 41%] - Checking shell & content for RnVitalsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnvitals-screen").should("be.visible");
  cy.getCy("rnvitals-title").should("be.visible");
  cy.getCy("rnvitals-content").should("be.visible");
  cy.getCy("rn-vitals-monitor").should("be.visible");
  cy.getCy("rn-medication-admin").should("be.visible");
  cy.getCy("rn-document-care").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/39 | 41%] - Saving screenshot for RnVitalsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_vitals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/39 | 41%] - Verified RnVitalsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/39 | 43%] - Navigating to /offices/clinical/roles/rn/rn-care-plan-review (RnCarePlanReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-care-plan-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/39 | 43%] - Checking shell & content for RnCarePlanReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplanreview-screen").should("be.visible");
  cy.getCy("rncareplanreview-title").should("be.visible");
  cy.getCy("rncareplanreview-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-status").should("be.visible");
  cy.getCy("rn-dashboard-compliance-audit").should("be.visible");
  cy.getCy("rn-dashboard-medication-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/39 | 43%] - Saving screenshot for RnCarePlanReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_care_plan_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/39 | 43%] - Verified RnCarePlanReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [18/39 | 46%] - Navigating to /offices/clinical/roles/rn/rn-incident-review (RnIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [18/39 | 46%] - Checking shell & content for RnIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnincidentreview-screen").should("be.visible");
  cy.getCy("rnincidentreview-title").should("be.visible");
  cy.getCy("rnincidentreview-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-health").should("be.visible");
  cy.getCy("rn-dashboard-compliance-audit").should("be.visible");
  cy.getCy("rn-dashboard-medication-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [18/39 | 46%] - Saving screenshot for RnIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_incident_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [18/39 | 46%] - Verified RnIncidentReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [19/39 | 48%] - Navigating to /offices/clinical/roles/rn/rn-tasks (RnTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [19/39 | 48%] - Checking shell & content for RnTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rntasks-screen").should("be.visible");
  cy.getCy("rntasks-title").should("be.visible");
  cy.getCy("rntasks-content").should("be.visible");
  cy.getCy("rn-dashboard-btn-refresh").should("be.visible");
  cy.getCy("rn-dashboard-btn-view-incident").should("be.visible");
  cy.getCy("rn-dashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [19/39 | 48%] - Saving screenshot for RnTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [19/39 | 48%] - Verified RnTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/39 | 51%] - Navigating to /offices/clinical/roles/rn/rn-reports (RnReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/39 | 51%] - Checking shell & content for RnReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnreports-screen").should("be.visible");
  cy.getCy("rnreports-title").should("be.visible");
  cy.getCy("rnreports-content").should("be.visible");
  cy.getCy("rn-dashboard-btn-submit-medication").should("be.visible");
  cy.getCy("rn-dashboard-btn-report-incident").should("be.visible");
  cy.getCy("rn-dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/39 | 51%] - Saving screenshot for RnReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/39 | 51%] - Verified RnReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/39 | 53%] - Navigating to /offices/clinical/roles/rn/medication-administration (MedicationAdministrationScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/medication-administration");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/39 | 53%] - Checking shell & content for MedicationAdministrationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medicationadministration-screen").should("be.visible");
  cy.getCy("medicationadministration-title").should("be.visible");
  cy.getCy("medicationadministration-content").should("be.visible");
  cy.getCy("medication-log-widget").should("be.visible");
  cy.getCy("vital-signs-monitor").should("be.visible");
  cy.getCy("compliance-audit-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/39 | 53%] - Saving screenshot for MedicationAdministrationScreen...");
  cy.waitAndSee();
  cy.screenshot("medication_administration");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/39 | 53%] - Verified MedicationAdministrationScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [22/39 | 56%] - Navigating to /offices/clinical/roles/rn/care-plan-review (CarePlanReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/care-plan-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [22/39 | 56%] - Checking shell & content for CarePlanReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplanreview-screen").should("be.visible");
  cy.getCy("careplanreview-title").should("be.visible");
  cy.getCy("careplanreview-content").should("be.visible");
  cy.getCy("dashboard-btn-view-patient").should("be.visible");
  cy.getCy("dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("dashboard-btn-record-medication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [22/39 | 56%] - Saving screenshot for CarePlanReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("care_plan_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [22/39 | 56%] - Verified CarePlanReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [23/39 | 58%] - Navigating to /offices/clinical/roles/rn/incident-review (IncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [23/39 | 58%] - Checking shell & content for IncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreview-screen").should("be.visible");
  cy.getCy("incidentreview-title").should("be.visible");
  cy.getCy("incidentreview-content").should("be.visible");
  cy.getCy("incidentreview-btn-view-records").should("be.visible");
  cy.getCy("incidentreview-btn-log-medication").should("be.visible");
  cy.getCy("incidentreview-btn-track-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [23/39 | 58%] - Saving screenshot for IncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [23/39 | 58%] - Verified IncidentReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/39 | 61%] - Navigating to /offices/clinical/roles/rn/shift-report (ShiftReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/shift-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/39 | 61%] - Checking shell & content for ShiftReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shiftreport-screen").should("be.visible");
  cy.getCy("shiftreport-title").should("be.visible");
  cy.getCy("shiftreport-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-health-status").should("be.visible");
  cy.getCy("rn-dashboard-compliance-metrics").should("be.visible");
  cy.getCy("rn-dashboard-patient-satisfaction").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/39 | 61%] - Saving screenshot for ShiftReportScreen...");
  cy.waitAndSee();
  cy.screenshot("shift_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/39 | 61%] - Verified ShiftReportScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/39 | 64%] - Navigating to /common/governance-control-room (GovernanceControlRoomScreen)...");
  cy.visitWithSemantics("/common/governance-control-room");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/39 | 64%] - Checking shell & content for GovernanceControlRoomScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governancecontrolroom-screen").should("be.visible");
  cy.getCy("governancecontrolroom-title").should("be.visible");
  cy.getCy("governancecontrolroom-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-compliance").should("be.visible");
  cy.getCy("gov-dashboard-btn-notify-stakeholders").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/39 | 64%] - Saving screenshot for GovernanceControlRoomScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_control_room");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/39 | 64%] - Verified GovernanceControlRoomScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [26/39 | 66%] - Navigating to /common/runtime-verification (RuntimeVerificationScreen)...");
  cy.visitWithSemantics("/common/runtime-verification");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [26/39 | 66%] - Checking shell & content for RuntimeVerificationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("runtimeverification-screen").should("be.visible");
  cy.getCy("runtimeverification-title").should("be.visible");
  cy.getCy("runtimeverification-content").should("be.visible");
  cy.getCy("gov-dashboard-compliance-status").should("be.visible");
  cy.getCy("gov-dashboard-audit-log").should("be.visible");
  cy.getCy("gov-dashboard-risk-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [26/39 | 66%] - Saving screenshot for RuntimeVerificationScreen...");
  cy.waitAndSee();
  cy.screenshot("runtime_verification");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [26/39 | 66%] - Verified RuntimeVerificationScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [27/39 | 69%] - Navigating to /common/drift-findings (DriftFindingsScreen)...");
  cy.visitWithSemantics("/common/drift-findings");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [27/39 | 69%] - Checking shell & content for DriftFindingsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("driftfindings-screen").should("be.visible");
  cy.getCy("driftfindings-title").should("be.visible");
  cy.getCy("driftfindings-content").should("be.visible");
  cy.getCy("gov-dashboard-compliance-status").should("be.visible");
  cy.getCy("gov-dashboard-audit-logs").should("be.visible");
  cy.getCy("gov-dashboard-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [27/39 | 69%] - Saving screenshot for DriftFindingsScreen...");
  cy.waitAndSee();
  cy.screenshot("drift_findings");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [27/39 | 69%] - Verified DriftFindingsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/39 | 71%] - Navigating to /common/pending-task-queue (PendingTaskQueueScreen)...");
  cy.visitWithSemantics("/common/pending-task-queue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/39 | 71%] - Checking shell & content for PendingTaskQueueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pendingtaskqueue-screen").should("be.visible");
  cy.getCy("pendingtaskqueue-title").should("be.visible");
  cy.getCy("pendingtaskqueue-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-refresh").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-download-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/39 | 71%] - Saving screenshot for PendingTaskQueueScreen...");
  cy.waitAndSee();
  cy.screenshot("pending_task_queue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/39 | 71%] - Verified PendingTaskQueueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [29/39 | 74%] - Navigating to /common/agent-dispatch (AgentDispatchScreen)...");
  cy.visitWithSemantics("/common/agent-dispatch");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [29/39 | 74%] - Checking shell & content for AgentDispatchScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("agentdispatch-screen").should("be.visible");
  cy.getCy("agentdispatch-title").should("be.visible");
  cy.getCy("agentdispatch-content").should("be.visible");
  cy.getCy("gov-dashboard-compliance-status").should("be.visible");
  cy.getCy("gov-dashboard-audit-log").should("be.visible");
  cy.getCy("gov-dashboard-risk-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [29/39 | 74%] - Saving screenshot for AgentDispatchScreen...");
  cy.waitAndSee();
  cy.screenshot("agent_dispatch");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [29/39 | 74%] - Verified AgentDispatchScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [30/39 | 76%] - Navigating to /common/audit (ScreenAuditScreen)...");
  cy.visitWithSemantics("/common/audit");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [30/39 | 76%] - Checking shell & content for ScreenAuditScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audit-screen").should("be.visible");
  cy.getCy("audit-title").should("be.visible");
  cy.getCy("audit-content").should("be.visible");
  cy.getCy("gov-dashboard-refresh-data").should("be.visible");
  cy.getCy("gov-dashboard-generate-audit-report").should("be.visible");
  cy.getCy("gov-dashboard-send-compliance-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [30/39 | 76%] - Saving screenshot for ScreenAuditScreen...");
  cy.waitAndSee();
  cy.screenshot("audit");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [30/39 | 76%] - Verified ScreenAuditScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [31/39 | 79%] - Navigating to /common/api-health-dashboard (ApiHealthDashboardScreen)...");
  cy.visitWithSemantics("/common/api-health-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [31/39 | 79%] - Checking shell & content for ApiHealthDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("govdashboard-btn-generate-report").should("be.visible");
  cy.getCy("govdashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [31/39 | 79%] - Saving screenshot for ApiHealthDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [31/39 | 79%] - Verified ApiHealthDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/39 | 82%] - Navigating to /common/release-operations (ReleaseOperationsScreen)...");
  cy.visitWithSemantics("/common/release-operations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/39 | 82%] - Checking shell & content for ReleaseOperationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releaseoperations-screen").should("be.visible");
  cy.getCy("releaseoperations-title").should("be.visible");
  cy.getCy("releaseoperations-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-filter-logs").should("be.visible");
  cy.getCy("gov-dashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/39 | 82%] - Saving screenshot for ReleaseOperationsScreen...");
  cy.waitAndSee();
  cy.screenshot("release_operations");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/39 | 82%] - Verified ReleaseOperationsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [33/39 | 84%] - Navigating to /common/file-verification-dashboard (FileVerificationDashboardScreen)...");
  cy.visitWithSemantics("/common/file-verification-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [33/39 | 84%] - Checking shell & content for FileVerificationDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("govdashboard-btn-generate-report").should("be.visible");
  cy.getCy("govdashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [33/39 | 84%] - Saving screenshot for FileVerificationDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [33/39 | 84%] - Verified FileVerificationDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [34/39 | 87%] - Navigating to /common/role-coverage-dashboard (RoleCoverageDashboardScreen)...");
  cy.visitWithSemantics("/common/role-coverage-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [34/39 | 87%] - Checking shell & content for RoleCoverageDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rolecoveragedashboard-screen").should("be.visible");
  cy.getCy("rolecoveragedashboard-title").should("be.visible");
  cy.getCy("rolecoveragedashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-generate-report").should("be.visible");
  cy.getCy("govdashboard-btn-update-doc").should("be.visible");
  cy.getCy("govdashboard-btn-conduct-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [34/39 | 87%] - Saving screenshot for RoleCoverageDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("role_coverage_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [34/39 | 87%] - Verified RoleCoverageDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [35/39 | 89%] - Navigating to /common/responsive-preview (ResponsivePreviewScreen)...");
  cy.visitWithSemantics("/common/responsive-preview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [35/39 | 89%] - Checking shell & content for ResponsivePreviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsivepreview-screen").should("be.visible");
  cy.getCy("responsivepreview-title").should("be.visible");
  cy.getCy("responsivepreview-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-compliance").should("be.visible");
  cy.getCy("gov-dashboard-btn-export-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-assess-risk").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [35/39 | 89%] - Saving screenshot for ResponsivePreviewScreen...");
  cy.waitAndSee();
  cy.screenshot("responsive_preview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [35/39 | 89%] - Verified ResponsivePreviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [36/39 | 92%] - Navigating to /common/workflow-execution (WorkflowExecutionScreen)...");
  cy.visitWithSemantics("/common/workflow-execution");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [36/39 | 92%] - Checking shell & content for WorkflowExecutionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowexecution-screen").should("be.visible");
  cy.getCy("workflowexecution-title").should("be.visible");
  cy.getCy("workflowexecution-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-request-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [36/39 | 92%] - Saving screenshot for WorkflowExecutionScreen...");
  cy.waitAndSee();
  cy.screenshot("workflow_execution");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [36/39 | 92%] - Verified WorkflowExecutionScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [37/39 | 94%] - Navigating to /common/governance-operations4-k (GovernanceOperations4KScreen)...");
  cy.visitWithSemantics("/common/governance-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [37/39 | 94%] - Checking shell & content for GovernanceOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceoperations4k-screen").should("be.visible");
  cy.getCy("governanceoperations4k-title").should("be.visible");
  cy.getCy("governanceoperations4k-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-conduct-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-docs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [37/39 | 94%] - Saving screenshot for GovernanceOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [37/39 | 94%] - Verified GovernanceOperations4KScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [38/39 | 97%] - Navigating to /rn/rn-field-supervisor-analytics (Registered Nurse (RN) Field Supervisor Analytics)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [38/39 | 97%] - Checking shell & content for Registered Nurse (RN) Field Supervisor Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisoranalytics-screen").should("be.visible");
  cy.getCy("rnfieldsupervisoranalytics-title").should("be.visible");
  cy.getCy("rnfieldsupervisoranalytics-content").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-view-metrics").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-report-incident").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-log-visit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [38/39 | 97%] - Saving screenshot for Registered Nurse (RN) Field Supervisor Analytics...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [38/39 | 97%] - Verified Registered Nurse (RN) Field Supervisor Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [39/39 | 100%] - Navigating to /rn/rn-field-supervisor-workflow (Registered Nurse (RN) Field Supervisor Compliance Workflow)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [39/39 | 100%] - Checking shell & content for Registered Nurse (RN) Field Supervisor Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisorworkflow-screen").should("be.visible");
  cy.getCy("rnfieldsupervisorworkflow-title").should("be.visible");
  cy.getCy("rnfieldsupervisorworkflow-content").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-submit-compliance").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-request-training").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-log-field-visit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [39/39 | 100%] - Saving screenshot for Registered Nurse (RN) Field Supervisor Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [39/39 | 100%] - Verified Registered Nurse (RN) Field Supervisor Compliance Workflow successfully!\n");
  });

  it("tests org role physician", () => {
    cy.loginAsRole("physician");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /clinical/physician-dashboard (PhysicianDashboardScreen)...");
  cy.visitWithSemantics("/clinical/physician-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for PhysicianDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciandashboard-screen").should("be.visible");
  cy.getCy("physiciandashboard-title").should("be.visible");
  cy.getCy("physiciandashboard-content").should("be.visible");
  cy.getCy("physician-dashboard-btn-submit-prescription").should("be.visible");
  cy.getCy("physician-dashboard-btn-authorize-lab-order").should("be.visible");
  cy.getCy("physician-dashboard-btn-run-compliance-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for PhysicianDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("physician_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified PhysicianDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /clinical/physician-analytics (Physician Analytics)...");
  cy.visitWithSemantics("/clinical/physician-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Physician Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciananalytics-screen").should("be.visible");
  cy.getCy("physiciananalytics-title").should("be.visible");
  cy.getCy("physiciananalytics-content").should("be.visible");
  cy.getCy("physician-dashboard-healthmetrics").should("be.visible");
  cy.getCy("physician-dashboard-compliance").should("be.visible");
  cy.getCy("physician-dashboard-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Physician Analytics...");
  cy.waitAndSee();
  cy.screenshot("physician_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Physician Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /clinical/physician-workflow (Physician Compliance Workflow)...");
  cy.visitWithSemantics("/clinical/physician-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Physician Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physicianworkflow-screen").should("be.visible");
  cy.getCy("physicianworkflow-title").should("be.visible");
  cy.getCy("physicianworkflow-content").should("be.visible");
  cy.getCy("physician-dashboard-btn-update-status").should("be.visible");
  cy.getCy("physician-dashboard-btn-view-compliance").should("be.visible");
  cy.getCy("physician-dashboard-btn-log-activity").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Physician Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("physician_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Physician Compliance Workflow successfully!\n");
  });

  it("tests org role cns", () => {
    cy.loginAsRole("cns");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /clinical/cns-dashboard (CnsDashboardScreen)...");
  cy.visitWithSemantics("/clinical/cns-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for CnsDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsdashboard-screen").should("be.visible");
  cy.getCy("cnsdashboard-title").should("be.visible");
  cy.getCy("cnsdashboard-content").should("be.visible");
  cy.getCy("cns-dashboard-btn-update-care-plan").should("be.visible");
  cy.getCy("cns-dashboard-btn-send-alert").should("be.visible");
  cy.getCy("cns-dashboard-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for CnsDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cns_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified CnsDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /rn/cns-analytics (Clinical Nurse Specialist Analytics)...");
  cy.visitWithSemantics("/rn/cns-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Clinical Nurse Specialist Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsanalytics-screen").should("be.visible");
  cy.getCy("cnsanalytics-title").should("be.visible");
  cy.getCy("cnsanalytics-content").should("be.visible");
  cy.getCy("cns-dashboard-btn-update-care-plan").should("be.visible");
  cy.getCy("cns-dashboard-btn-submit-feedback").should("be.visible");
  cy.getCy("cns-dashboard-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Clinical Nurse Specialist Analytics...");
  cy.waitAndSee();
  cy.screenshot("cns_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Clinical Nurse Specialist Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /rn/cns-workflow (Clinical Nurse Specialist Compliance Workflow)...");
  cy.visitWithSemantics("/rn/cns-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Clinical Nurse Specialist Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsworkflow-screen").should("be.visible");
  cy.getCy("cnsworkflow-title").should("be.visible");
  cy.getCy("cnsworkflow-content").should("be.visible");
  cy.getCy("cns-dashboard-btn-update-care-plan").should("be.visible");
  cy.getCy("cns-dashboard-btn-report-red-flag").should("be.visible");
  cy.getCy("cns-dashboard-btn-training-resources").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Clinical Nurse Specialist Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("cns_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Clinical Nurse Specialist Compliance Workflow successfully!\n");
  });

  it("tests org role pediatric", () => {
    cy.loginAsRole("pediatric");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /clinical/pediatric-dashboard (PediatricDashboardScreen)...");
  cy.visitWithSemantics("/clinical/pediatric-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for PediatricDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricdashboard-screen").should("be.visible");
  cy.getCy("pediatricdashboard-title").should("be.visible");
  cy.getCy("pediatricdashboard-content").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-record-growth").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-administer-vaccination").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-schedule-appointment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for PediatricDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("pediatric_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified PediatricDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /clinical/pediatric-analytics (Pediatric Specialist Analytics)...");
  cy.visitWithSemantics("/clinical/pediatric-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Pediatric Specialist Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricanalytics-screen").should("be.visible");
  cy.getCy("pediatricanalytics-title").should("be.visible");
  cy.getCy("pediatricanalytics-content").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-schedule").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-view-records").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-send-reminder").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Pediatric Specialist Analytics...");
  cy.waitAndSee();
  cy.screenshot("pediatric_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Pediatric Specialist Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /clinical/pediatric-workflow (Pediatric Specialist Compliance Workflow)...");
  cy.visitWithSemantics("/clinical/pediatric-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Pediatric Specialist Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricworkflow-screen").should("be.visible");
  cy.getCy("pediatricworkflow-title").should("be.visible");
  cy.getCy("pediatricworkflow-content").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-schedule").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-record-immunization").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-submit-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Pediatric Specialist Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("pediatric_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Pediatric Specialist Compliance Workflow successfully!\n");
  });

  it("tests org role caregiver", () => {
    cy.loginAsRole("caregiver");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Navigating to /offices/clinical/roles/caregiver/dashboard (CaregiverDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Checking shell & content for CaregiverDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverdashboard-screen").should("be.visible");
  cy.getCy("caregiverdashboard-title").should("be.visible");
  cy.getCy("caregiverdashboard-content").should("be.visible");
  cy.getCy("caregiver-dashboard-btn-record-activities").should("be.visible");
  cy.getCy("caregiver-dashboard-btn-acknowledge-medications").should("be.visible");
  cy.getCy("caregiver-dashboard-btn-run-compliance-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Saving screenshot for CaregiverDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Verified CaregiverDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Navigating to /offices/clinical/roles/caregiver/tasks (CaregiverTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Checking shell & content for CaregiverTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivertasks-screen").should("be.visible");
  cy.getCy("caregivertasks-title").should("be.visible");
  cy.getCy("caregivertasks-content").should("be.visible");
  cy.getCy("caregiver-btn-execute-compliance-scan").should("be.visible");
  cy.getCy("caregiver-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Saving screenshot for CaregiverTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Verified CaregiverTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Navigating to /offices/clinical/roles/caregiver/client-profile (CaregiverClientProfileScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/client-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Checking shell & content for CaregiverClientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverclientprofile-screen").should("be.visible");
  cy.getCy("caregiverclientprofile-title").should("be.visible");
  cy.getCy("caregiverclientprofile-content").should("be.visible");
  cy.getCy("caregiver-task-list").should("be.visible");
  cy.getCy("client-health-status").should("be.visible");
  cy.getCy("medication-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Saving screenshot for CaregiverClientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_client_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Verified CaregiverClientProfileScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Navigating to /offices/clinical/roles/caregiver/visit-notes (CaregiverVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Checking shell & content for CaregiverVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivervisitnotes-screen").should("be.visible");
  cy.getCy("caregivervisitnotes-title").should("be.visible");
  cy.getCy("caregivervisitnotes-content").should("be.visible");
  cy.getCy("caregiver-visit-notes-submit").should("be.visible");
  cy.getCy("caregiver-compliance-scan").should("be.visible");
  cy.getCy("caregiver-logs-view").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Saving screenshot for CaregiverVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Verified CaregiverVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Navigating to /offices/clinical/roles/caregiver/schedule (CaregiverScheduleScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Checking shell & content for CaregiverScheduleScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverschedule-screen").should("be.visible");
  cy.getCy("caregiverschedule-title").should("be.visible");
  cy.getCy("caregiverschedule-content").should("be.visible");
  cy.getCy("caregiver-btn-log-health-update").should("be.visible");
  cy.getCy("caregiver-btn-report-issue").should("be.visible");
  cy.getCy("caregiver-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Saving screenshot for CaregiverScheduleScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Verified CaregiverScheduleScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Navigating to /offices/clinical/roles/caregiver/incident-report (CaregiverIncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Checking shell & content for CaregiverIncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverincidentreport-screen").should("be.visible");
  cy.getCy("caregiverincidentreport-title").should("be.visible");
  cy.getCy("caregiverincidentreport-content").should("be.visible");
  cy.getCy("dashboard-btn-report-incident").should("be.visible");
  cy.getCy("dashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Saving screenshot for CaregiverIncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Verified CaregiverIncidentReportScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Navigating to /offices/clinical/roles/caregiver/psw-schedule (ScheduleScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/psw-schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Checking shell & content for ScheduleScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedule-screen").should("be.visible");
  cy.getCy("schedule-title").should("be.visible");
  cy.getCy("schedule-content").should("be.visible");
  cy.getCy("schedule-visit-btn").should("be.visible");
  cy.getCy("report-health-btn").should("be.visible");
  cy.getCy("administer-medication-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Saving screenshot for ScheduleScreen...");
  cy.waitAndSee();
  cy.screenshot("schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Verified ScheduleScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Navigating to /clinic/messaging (MessagingScreen)...");
  cy.visitWithSemantics("/clinic/messaging");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Checking shell & content for MessagingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("messaging-screen").should("be.visible");
  cy.getCy("messaging-title").should("be.visible");
  cy.getCy("messaging-content").should("be.visible");
  cy.getCy("msg-dashboard-btn-view-client-profile").should("be.visible");
  cy.getCy("msg-dashboard-btn-log-communication").should("be.visible");
  cy.getCy("msg-dashboard-btn-report-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Saving screenshot for MessagingScreen...");
  cy.waitAndSee();
  cy.screenshot("messaging");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Verified MessagingScreen successfully!\n");
  });

  it("tests org role guest", () => {
    cy.loginAsRole("guest");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Navigating to /common/dynamic-dashboard (DynamicScreenDashboardScreen)...");
  cy.visitWithSemantics("/common/dynamic-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Checking shell & content for DynamicScreenDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicscreendashboard-screen").should("be.visible");
  cy.getCy("dynamicscreendashboard-title").should("be.visible");
  cy.getCy("dynamicscreendashboard-content").should("be.visible");
  cy.getCy("dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("dashboard-btn-sync-security-posture").should("be.visible");
  cy.getCy("dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Saving screenshot for DynamicScreenDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_screen_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Verified DynamicScreenDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Navigating to /common/guest-dashboard (GuestDashboardScreen)...");
  cy.visitWithSemantics("/common/guest-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Checking shell & content for GuestDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestdashboard-screen").should("be.visible");
  cy.getCy("guestdashboard-title").should("be.visible");
  cy.getCy("guestdashboard-content").should("be.visible");
  cy.getCy("guestdashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("guestdashboard-btn-sync-security").should("be.visible");
  cy.getCy("guestdashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Saving screenshot for GuestDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Verified GuestDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Navigating to /common/guest-analytics (GuestAnalyticsScreen)...");
  cy.visitWithSemantics("/common/guest-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Checking shell & content for GuestAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestanalytics-screen").should("be.visible");
  cy.getCy("guestanalytics-title").should("be.visible");
  cy.getCy("guestanalytics-content").should("be.visible");
  cy.getCy("analytics-refresh-btn").should("be.visible");
  cy.getCy("analytics-execute-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Saving screenshot for GuestAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Verified GuestAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Navigating to /common/guest-compliance (GuestComplianceScreen)...");
  cy.visitWithSemantics("/common/guest-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Checking shell & content for GuestComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestcompliance-screen").should("be.visible");
  cy.getCy("guestcompliance-title").should("be.visible");
  cy.getCy("guestcompliance-content").should("be.visible");
  cy.getCy("compliance-scan-btn").should("be.visible");
  cy.getCy("audit-logs-btn").should("be.visible");
  cy.getCy("governance-update-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Saving screenshot for GuestComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Verified GuestComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Navigating to /common/guest-workflow (GuestWorkflowScreen)...");
  cy.visitWithSemantics("/common/guest-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Checking shell & content for GuestWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestworkflow-screen").should("be.visible");
  cy.getCy("guestworkflow-title").should("be.visible");
  cy.getCy("guestworkflow-content").should("be.visible");
  cy.getCy("guestworkflow-btn-trigger-sweep").should("be.visible");
  cy.getCy("guestworkflow-btn-refresh-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Saving screenshot for GuestWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Verified GuestWorkflowScreen successfully!\n");
  });

  it("tests org role portal", () => {
    cy.loginAsRole("portal");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /common/portal-dashboard (PortalDashboardScreen)...");
  cy.visitWithSemantics("/common/portal-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for PortalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portaldashboard-screen").should("be.visible");
  cy.getCy("portaldashboard-title").should("be.visible");
  cy.getCy("portaldashboard-content").should("be.visible");
  cy.getCy("portal-dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("portal-dashboard-btn-sync-security-posture").should("be.visible");
  cy.getCy("portal-dashboard-btn-update-security-policy").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for PortalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified PortalDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /common/portal-analytics (PortalAnalyticsScreen)...");
  cy.visitWithSemantics("/common/portal-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for PortalAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalanalytics-screen").should("be.visible");
  cy.getCy("portalanalytics-title").should("be.visible");
  cy.getCy("portalanalytics-content").should("be.visible");
  cy.getCy("portal-analytics-btn-execute-sweep").should("be.visible");
  cy.getCy("portal-analytics-btn-refresh-logs").should("be.visible");
  cy.getCy("portal-analytics-btn-trigger-manual-sweep").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for PortalAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified PortalAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /common/portal-compliance (PortalComplianceScreen)...");
  cy.visitWithSemantics("/common/portal-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for PortalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalcompliance-screen").should("be.visible");
  cy.getCy("portalcompliance-title").should("be.visible");
  cy.getCy("portalcompliance-content").should("be.visible");
  cy.getCy("portal-compliance-btn-execute-audit").should("be.visible");
  cy.getCy("portal-compliance-btn-trigger-action").should("be.visible");
  cy.getCy("portal-compliance-btn-manage-directives").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for PortalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified PortalComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /common/portal-workflow (PortalWorkflowScreen)...");
  cy.visitWithSemantics("/common/portal-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for PortalWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalworkflow-screen").should("be.visible");
  cy.getCy("portalworkflow-title").should("be.visible");
  cy.getCy("portalworkflow-content").should("be.visible");
  cy.getCy("portal-session-monitor").should("be.visible");
  cy.getCy("workflow-sync-indicator").should("be.visible");
  cy.getCy("manual-refresh-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for PortalWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified PortalWorkflowScreen successfully!\n");
  });

  it("tests org role patient", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /common/family-member-dashboard (FamilyMemberDashboardScreen)...");
  cy.visitWithSemantics("/common/family-member-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for FamilyMemberDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberdashboard-screen").should("be.visible");
  cy.getCy("familymemberdashboard-title").should("be.visible");
  cy.getCy("familymemberdashboard-content").should("be.visible");
  cy.getCy("family_member_dashboard-btn-execute-audit").should("be.visible");
  cy.getCy("family_member_dashboard-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for FamilyMemberDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified FamilyMemberDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /offices/client/roles/client/dashboard (PatientDashboardScreen)...");
  cy.visitWithSemantics("/offices/client/roles/client/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for PatientDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdashboard-screen").should("be.visible");
  cy.getCy("patientdashboard-title").should("be.visible");
  cy.getCy("patientdashboard-content").should("be.visible");
  cy.getCy("patientdashboard-btn-refresh").should("be.visible");
  cy.getCy("patientdashboard-btn-audit").should("be.visible");
  cy.getCy("patientdashboard-btn-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for PatientDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified PatientDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /common/patient-analytics (PatientAnalyticsScreen)...");
  cy.visitWithSemantics("/common/patient-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for PatientAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientanalytics-screen").should("be.visible");
  cy.getCy("patientanalytics-title").should("be.visible");
  cy.getCy("patientanalytics-content").should("be.visible");
  cy.getCy("patient-analytics-btn-complete-assessment").should("be.visible");
  cy.getCy("patient-analytics-btn-schedule-appointment").should("be.visible");
  cy.getCy("patient-analytics-btn-report-concern").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for PatientAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified PatientAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /common/patient-compliance (PatientComplianceScreen)...");
  cy.visitWithSemantics("/common/patient-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for PatientComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcompliance-screen").should("be.visible");
  cy.getCy("patientcompliance-title").should("be.visible");
  cy.getCy("patientcompliance-content").should("be.visible");
  cy.getCy("compliance-status-overview").should("be.visible");
  cy.getCy("audit-results-chart").should("be.visible");
  cy.getCy("governance-directives-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for PatientComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified PatientComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /common/patient-workflow (PatientWorkflowScreen)...");
  cy.visitWithSemantics("/common/patient-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for PatientWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientworkflow-screen").should("be.visible");
  cy.getCy("patientworkflow-title").should("be.visible");
  cy.getCy("patientworkflow-content").should("be.visible");
  cy.getCy("patient-workflow-btn-complete-assessment").should("be.visible");
  cy.getCy("patient-workflow-btn-sign-consent").should("be.visible");
  cy.getCy("patient-workflow-btn-schedule-appointment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for PatientWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified PatientWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /common/patient-command-center (PatientCommandCenterScreen)...");
  cy.visitWithSemantics("/common/patient-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for PatientCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcommandcenter-screen").should("be.visible");
  cy.getCy("patientcommandcenter-title").should("be.visible");
  cy.getCy("patientcommandcenter-content").should("be.visible");
  cy.getCy("patient-command-center-btn-trigger-audit").should("be.visible");
  cy.getCy("patient-command-center-btn-refresh-telemetry").should("be.visible");
  cy.getCy("patient-command-center-btn-execute-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for PatientCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified PatientCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /common/patient-appointments (PatientAppointmentsScreen)...");
  cy.visitWithSemantics("/common/patient-appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for PatientAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientappointments-screen").should("be.visible");
  cy.getCy("patientappointments-title").should("be.visible");
  cy.getCy("patientappointments-content").should("be.visible");
  cy.getCy("patientappointments-btn-review").should("be.visible");
  cy.getCy("patientappointments-btn-attend").should("be.visible");
  cy.getCy("patientappointments-btn-submit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for PatientAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified PatientAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /common/patient-care-plan (PatientCarePlanScreen)...");
  cy.visitWithSemantics("/common/patient-care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for PatientCarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcareplan-screen").should("be.visible");
  cy.getCy("patientcareplan-title").should("be.visible");
  cy.getCy("patientcareplan-content").should("be.visible");
  cy.getCy("patientcareplan-btn-execute-compliance-scan").should("be.visible");
  cy.getCy("patientcareplan-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for PatientCarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_care_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified PatientCarePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /common/patient-messages (PatientMessagesScreen)...");
  cy.visitWithSemantics("/common/patient-messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for PatientMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientmessages-screen").should("be.visible");
  cy.getCy("patientmessages-title").should("be.visible");
  cy.getCy("patientmessages-content").should("be.visible");
  cy.getCy("patientmessages-btn-trigger-audit").should("be.visible");
  cy.getCy("patientmessages-btn-refresh-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for PatientMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified PatientMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /common/patient-documents (PatientDocumentsScreen)...");
  cy.visitWithSemantics("/common/patient-documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for PatientDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdocuments-screen").should("be.visible");
  cy.getCy("patientdocuments-title").should("be.visible");
  cy.getCy("patientdocuments-content").should("be.visible");
  cy.getCy("patient-documents-btn-run-scan").should("be.visible");
  cy.getCy("patient-documents-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for PatientDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified PatientDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /common/patient-billing (PatientBillingScreen)...");
  cy.visitWithSemantics("/common/patient-billing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for PatientBillingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientbilling-screen").should("be.visible");
  cy.getCy("patientbilling-title").should("be.visible");
  cy.getCy("patientbilling-content").should("be.visible");
  cy.getCy("billing-overview-card").should("be.visible");
  cy.getCy("billing-statement-list").should("be.visible");
  cy.getCy("notification-banner").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for PatientBillingScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_billing");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified PatientBillingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /offices/client/roles/client/profile (PatientProfileScreen)...");
  cy.visitWithSemantics("/offices/client/roles/client/profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for PatientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientprofile-screen").should("be.visible");
  cy.getCy("patientprofile-title").should("be.visible");
  cy.getCy("patientprofile-content").should("be.visible");
  cy.getCy("patientprofile-btn-trigger-compliance-scan").should("be.visible");
  cy.getCy("patientprofile-btn-refresh-dashboard").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for PatientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified PatientProfileScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /common/appointment (AppointmentScreen)...");
  cy.visitWithSemantics("/common/appointment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for AppointmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointment-screen").should("be.visible");
  cy.getCy("appointment-title").should("be.visible");
  cy.getCy("appointment-content").should("be.visible");
  cy.getCy("appointment-btn-schedule").should("be.visible");
  cy.getCy("appointment-btn-confirm").should("be.visible");
  cy.getCy("appointment-btn-complete-paperwork").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for AppointmentScreen...");
  cy.waitAndSee();
  cy.screenshot("appointment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified AppointmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /clinic/care-plan (CarePlanScreen)...");
  cy.visitWithSemantics("/clinic/care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for CarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplan-screen").should("be.visible");
  cy.getCy("careplan-title").should("be.visible");
  cy.getCy("careplan-content").should("be.visible");
  cy.getCy("careplan-btn-refresh").should("be.visible");
  cy.getCy("careplan-btn-execute-compliance").should("be.visible");
  cy.getCy("careplan-btn-execute-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for CarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("care_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified CarePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /common/billing (BillingScreen)...");
  cy.visitWithSemantics("/common/billing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for BillingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billing-screen").should("be.visible");
  cy.getCy("billing-title").should("be.visible");
  cy.getCy("billing-content").should("be.visible");
  cy.getCy("billing-overview").should("be.visible");
  cy.getCy("billing-detail-table").should("be.visible");
  cy.getCy("payment-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for BillingScreen...");
  cy.waitAndSee();
  cy.screenshot("billing");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified BillingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /common/documents (DocumentsScreen)...");
  cy.visitWithSemantics("/common/documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for DocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("documents-screen").should("be.visible");
  cy.getCy("documents-title").should("be.visible");
  cy.getCy("documents-content").should("be.visible");
  cy.getCy("docmanager-btn-review").should("be.visible");
  cy.getCy("compliance-btn-scan").should("be.visible");
  cy.getCy("audit-btn-participate").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for DocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified DocumentsScreen successfully!\n");
  });

  it("tests org role dynamic", () => {
    cy.loginAsRole("dynamic");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Navigating to /common/customer-support-dashboard (CustomerSupportDashboardScreen)...");
  cy.visitWithSemantics("/common/customer-support-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Checking shell & content for CustomerSupportDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportdashboard-screen").should("be.visible");
  cy.getCy("customersupportdashboard-title").should("be.visible");
  cy.getCy("customersupportdashboard-content").should("be.visible");
  cy.getCy("csdashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("csdashboard-btn-manual-sync").should("be.visible");
  cy.getCy("csdashboard-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Saving screenshot for CustomerSupportDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("customer_support_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Verified CustomerSupportDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Navigating to /common/support-dashboard (SupportDashboardScreen)...");
  cy.visitWithSemantics("/common/support-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Checking shell & content for SupportDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportdashboard-screen").should("be.visible");
  cy.getCy("supportdashboard-title").should("be.visible");
  cy.getCy("supportdashboard-content").should("be.visible");
  cy.getCy("support-dashboard-loading").should("be.visible");
  cy.getCy("support-dashboard-error").should("be.visible");
  cy.getCy("support-dashboard-compliance-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Saving screenshot for SupportDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("support_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Verified SupportDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Navigating to /common/dynamic-analytics (DynamicScreenAnalyticsScreen)...");
  cy.visitWithSemantics("/common/dynamic-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Checking shell & content for DynamicScreenAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicanalytics-screen").should("be.visible");
  cy.getCy("dynamicanalytics-title").should("be.visible");
  cy.getCy("dynamicanalytics-content").should("be.visible");
  cy.getCy("dynamic-analytics-btn-refresh").should("be.visible");
  cy.getCy("dynamic-analytics-btn-customize").should("be.visible");
  cy.getCy("dynamic-analytics-btn-search").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Saving screenshot for DynamicScreenAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Verified DynamicScreenAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Navigating to /common/dynamic-compliance (DynamicScreenComplianceScreen)...");
  cy.visitWithSemantics("/common/dynamic-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Checking shell & content for DynamicScreenComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamiccompliance-screen").should("be.visible");
  cy.getCy("dynamiccompliance-title").should("be.visible");
  cy.getCy("dynamiccompliance-content").should("be.visible");
  cy.getCy("dynamic-compliance-btn-execute-scan").should("be.visible");
  cy.getCy("dynamic-compliance-btn-trigger-action").should("be.visible");
  cy.getCy("dynamic-compliance-btn-refresh-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Saving screenshot for DynamicScreenComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Verified DynamicScreenComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Navigating to /common/dynamic-workflow (DynamicScreenWorkflowScreen)...");
  cy.visitWithSemantics("/common/dynamic-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Checking shell & content for DynamicScreenWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicworkflow-screen").should("be.visible");
  cy.getCy("dynamicworkflow-title").should("be.visible");
  cy.getCy("dynamicworkflow-content").should("be.visible");
  cy.getCy("dynamic-workflow-btn-start").should("be.visible");
  cy.getCy("dynamic-workflow-btn-stop").should("be.visible");
  cy.getCy("dynamic-workflow-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Saving screenshot for DynamicScreenWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Verified DynamicScreenWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Navigating to /common/shared-stubs (SharedScreenStubs)...");
  cy.visitWithSemantics("/common/shared-stubs");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Checking shell & content for SharedScreenStubs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("sharedstubs-screen").should("be.visible");
  cy.getCy("sharedstubs-title").should("be.visible");
  cy.getCy("sharedstubs-content").should("be.visible");
  cy.getCy("sharedstubs-btn-trigger-scan").should("be.visible");
  cy.getCy("sharedstubs-btn-manual-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Saving screenshot for SharedScreenStubs...");
  cy.waitAndSee();
  cy.screenshot("shared_stubs");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Verified SharedScreenStubs successfully!\n");
  });

  it("tests org role infrastructure", () => {
    cy.loginAsRole("infrastructure");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Navigating to /common/infrastructure-dashboard (InfrastructureDashboardScreen)...");
  cy.visitWithSemantics("/common/infrastructure-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Checking shell & content for InfrastructureDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructuredashboard-screen").should("be.visible");
  cy.getCy("infrastructuredashboard-title").should("be.visible");
  cy.getCy("infrastructuredashboard-content").should("be.visible");
  cy.getCy("infrastructure-dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("infrastructure-dashboard-btn-sync-posture").should("be.visible");
  cy.getCy("infrastructure-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Saving screenshot for InfrastructureDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("infrastructure_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Verified InfrastructureDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Navigating to /common/architecture-planning-analytics (ArchitecturePlanningAnalyticsScreen)...");
  cy.visitWithSemantics("/common/architecture-planning-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Checking shell & content for ArchitecturePlanningAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanninganalytics-screen").should("be.visible");
  cy.getCy("architectureplanninganalytics-title").should("be.visible");
  cy.getCy("architectureplanninganalytics-content").should("be.visible");
  cy.getCy("infrastructure-health-overview").should("be.visible");
  cy.getCy("security-alerts").should("be.visible");
  cy.getCy("uptime-downtime-visualization").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Saving screenshot for ArchitecturePlanningAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Verified ArchitecturePlanningAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Navigating to /common/architecture-planning-compliance (ArchitecturePlanningComplianceScreen)...");
  cy.visitWithSemantics("/common/architecture-planning-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Checking shell & content for ArchitecturePlanningComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningcompliance-screen").should("be.visible");
  cy.getCy("architectureplanningcompliance-title").should("be.visible");
  cy.getCy("architectureplanningcompliance-content").should("be.visible");
  cy.getCy("compliance-status-indicator").should("be.visible");
  cy.getCy("audit-logs-table").should("be.visible");
  cy.getCy("alerts-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Saving screenshot for ArchitecturePlanningComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Verified ArchitecturePlanningComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Navigating to /common/architecture-planning-workflow (ArchitecturePlanningWorkflowScreen)...");
  cy.visitWithSemantics("/common/architecture-planning-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Checking shell & content for ArchitecturePlanningWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningworkflow-screen").should("be.visible");
  cy.getCy("architectureplanningworkflow-title").should("be.visible");
  cy.getCy("architectureplanningworkflow-content").should("be.visible");
  cy.getCy("infrastructure-health-overview").should("be.visible");
  cy.getCy("compliance-status-card").should("be.visible");
  cy.getCy("alerts-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Saving screenshot for ArchitecturePlanningWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Verified ArchitecturePlanningWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Navigating to /common/infrastructure-analytics (InfrastructureAnalyticsScreen)...");
  cy.visitWithSemantics("/common/infrastructure-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Checking shell & content for InfrastructureAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureanalytics-screen").should("be.visible");
  cy.getCy("infrastructureanalytics-title").should("be.visible");
  cy.getCy("infrastructureanalytics-content").should("be.visible");
  cy.getCy("infrastructure-dashboard-health").should("be.visible");
  cy.getCy("infrastructure-dashboard-compliance").should("be.visible");
  cy.getCy("infrastructure-dashboard-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Saving screenshot for InfrastructureAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("infrastructure_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Verified InfrastructureAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Navigating to /common/infrastructure-compliance (InfrastructureComplianceScreen)...");
  cy.visitWithSemantics("/common/infrastructure-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Checking shell & content for InfrastructureComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructurecompliance-screen").should("be.visible");
  cy.getCy("infrastructurecompliance-title").should("be.visible");
  cy.getCy("infrastructurecompliance-content").should("be.visible");
  cy.getCy("infrastructure-compliance-status").should("be.visible");
  cy.getCy("infrastructure-audit-logs").should("be.visible");
  cy.getCy("infrastructure-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Saving screenshot for InfrastructureComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("infrastructure_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Verified InfrastructureComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Navigating to /common/infrastructure-workflow (InfrastructureWorkflowScreen)...");
  cy.visitWithSemantics("/common/infrastructure-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Checking shell & content for InfrastructureWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureworkflow-screen").should("be.visible");
  cy.getCy("infrastructureworkflow-title").should("be.visible");
  cy.getCy("infrastructureworkflow-content").should("be.visible");
  cy.getCy("infrastructure-audit-btn-generate-report").should("be.visible");
  cy.getCy("infrastructure-audit-btn-update-compliance").should("be.visible");
  cy.getCy("infrastructure-audit-btn-view-findings").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Saving screenshot for InfrastructureWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("infrastructure_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Verified InfrastructureWorkflowScreen successfully!\n");
  });

  it("tests org role system_verification", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/9 | 11%] - Navigating to /offices/support/roles/quality_assurance/dashboard (QaDashboardScreen)...");
  cy.visitWithSemantics("/offices/support/roles/quality_assurance/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/9 | 11%] - Checking shell & content for QaDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qadashboard-screen").should("be.visible");
  cy.getCy("qadashboard-title").should("be.visible");
  cy.getCy("qadashboard-content").should("be.visible");
  cy.getCy("qa_dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("qa_dashboard-btn-sync-posture").should("be.visible");
  cy.getCy("qa_dashboard-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/9 | 11%] - Saving screenshot for QaDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/9 | 11%] - Verified QaDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/9 | 22%] - Navigating to /common/system-verification-dashboard (SystemVerificationDashboardScreen)...");
  cy.visitWithSemantics("/common/system-verification-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/9 | 22%] - Checking shell & content for SystemVerificationDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationdashboard-screen").should("be.visible");
  cy.getCy("systemverificationdashboard-title").should("be.visible");
  cy.getCy("systemverificationdashboard-content").should("be.visible");
  cy.getCy("sysver-dashboard-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/9 | 22%] - Saving screenshot for SystemVerificationDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/9 | 22%] - Verified SystemVerificationDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/9 | 33%] - Navigating to /staff/quality-assurance-dashboard (QualityAssuranceDashboardScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/9 | 33%] - Checking shell & content for QualityAssuranceDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancedashboard-screen").should("be.visible");
  cy.getCy("qualityassurancedashboard-title").should("be.visible");
  cy.getCy("qualityassurancedashboard-content").should("be.visible");
  cy.getCy("qa-dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("qa-dashboard-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/9 | 33%] - Saving screenshot for QualityAssuranceDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/9 | 33%] - Verified QualityAssuranceDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/9 | 44%] - Navigating to /common/system-analytics (SystemAnalyticsScreen)...");
  cy.visitWithSemantics("/common/system-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/9 | 44%] - Checking shell & content for SystemAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemanalytics-screen").should("be.visible");
  cy.getCy("systemanalytics-title").should("be.visible");
  cy.getCy("systemanalytics-content").should("be.visible");
  cy.getCy("sysanalytics-btn-generate-report").should("be.visible");
  cy.getCy("sysanalytics-btn-update-system").should("be.visible");
  cy.getCy("sysanalytics-btn-train-users").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/9 | 44%] - Saving screenshot for SystemAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("system_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/9 | 44%] - Verified SystemAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/9 | 55%] - Navigating to /common/system-compliance (SystemComplianceScreen)...");
  cy.visitWithSemantics("/common/system-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/9 | 55%] - Checking shell & content for SystemComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemcompliance-screen").should("be.visible");
  cy.getCy("systemcompliance-title").should("be.visible");
  cy.getCy("systemcompliance-content").should("be.visible");
  cy.getCy("compliance-status-overview").should("be.visible");
  cy.getCy("audit-log-list").should("be.visible");
  cy.getCy("compliance-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/9 | 55%] - Saving screenshot for SystemComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("system_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/9 | 55%] - Verified SystemComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/9 | 66%] - Navigating to /common/system-verification-analytics (SystemVerificationAnalyticsScreen)...");
  cy.visitWithSemantics("/common/system-verification-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/9 | 66%] - Checking shell & content for SystemVerificationAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationanalytics-screen").should("be.visible");
  cy.getCy("systemverificationanalytics-title").should("be.visible");
  cy.getCy("systemverificationanalytics-content").should("be.visible");
  cy.getCy("sysverif-dashboard-performance").should("be.visible");
  cy.getCy("sysverif-dashboard-status").should("be.visible");
  cy.getCy("sysverif-dashboard-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/9 | 66%] - Saving screenshot for SystemVerificationAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/9 | 66%] - Verified SystemVerificationAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/9 | 77%] - Navigating to /common/system-verification-compliance (SystemVerificationComplianceScreen)...");
  cy.visitWithSemantics("/common/system-verification-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/9 | 77%] - Checking shell & content for SystemVerificationComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationcompliance-screen").should("be.visible");
  cy.getCy("systemverificationcompliance-title").should("be.visible");
  cy.getCy("systemverificationcompliance-content").should("be.visible");
  cy.getCy("compliance-audit-status-card").should("be.visible");
  cy.getCy("security-incident-summary").should("be.visible");
  cy.getCy("governance-directive-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/9 | 77%] - Saving screenshot for SystemVerificationComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/9 | 77%] - Verified SystemVerificationComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/9 | 88%] - Navigating to /common/system-verification-workflow (SystemVerificationWorkflowScreen)...");
  cy.visitWithSemantics("/common/system-verification-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/9 | 88%] - Checking shell & content for SystemVerificationWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationworkflow-screen").should("be.visible");
  cy.getCy("systemverificationworkflow-title").should("be.visible");
  cy.getCy("systemverificationworkflow-content").should("be.visible");
  cy.getCy("sysverif-btn-review").should("be.visible");
  cy.getCy("sysverif-btn-validate").should("be.visible");
  cy.getCy("sysverif-btn-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/9 | 88%] - Saving screenshot for SystemVerificationWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/9 | 88%] - Verified SystemVerificationWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [9/9 | 100%] - Navigating to /common/system-workflow (SystemWorkflowScreen)...");
  cy.visitWithSemantics("/common/system-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [9/9 | 100%] - Checking shell & content for SystemWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemworkflow-screen").should("be.visible");
  cy.getCy("systemworkflow-title").should("be.visible");
  cy.getCy("systemworkflow-content").should("be.visible");
  cy.getCy("sysworkflow-btn-generate-report").should("be.visible");
  cy.getCy("sysworkflow-btn-request-support").should("be.visible");
  cy.getCy("sysworkflow-btn-update-docs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [9/9 | 100%] - Saving screenshot for SystemWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("system_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [9/9 | 100%] - Verified SystemWorkflowScreen successfully!\n");
  });

  it("tests org role training", () => {
    cy.loginAsRole("training");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Navigating to /common/course-architect-dashboard (CourseArchitectDashboardScreen)...");
  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Checking shell & content for CourseArchitectDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");
  cy.getCy("dashboard-participation-metric").should("be.visible");
  cy.getCy("dashboard-feedback-score").should("be.visible");
  cy.getCy("dashboard-effectiveness-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Saving screenshot for CourseArchitectDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Verified CourseArchitectDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Navigating to /common/training-hub-dashboard (TrainingHubDashboardScreen)...");
  cy.visitWithSemantics("/common/training-hub-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Checking shell & content for TrainingHubDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubdashboard-screen").should("be.visible");
  cy.getCy("traininghubdashboard-title").should("be.visible");
  cy.getCy("traininghubdashboard-content").should("be.visible");
  cy.getCy("traininghub-btn-run-compliance-scan").should("be.visible");
  cy.getCy("traininghub-btn-sync-security").should("be.visible");
  cy.getCy("traininghub-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Saving screenshot for TrainingHubDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Verified TrainingHubDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Navigating to /offices/corporate/roles/training_director/dashboard (TrainingDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Checking shell & content for TrainingDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("training-dashboard-btn-adjust-program").should("be.visible");
  cy.getCy("training-dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Saving screenshot for TrainingDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Verified TrainingDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Navigating to /offices/support/roles/training_coordinator/dashboard (TrainingCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/support/roles/training_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Checking shell & content for TrainingCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-update-progress").should("be.visible");
  cy.getCy("training-dashboard-btn-submit-feedback").should("be.visible");
  cy.getCy("training-dashboard-btn-access-materials").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Saving screenshot for TrainingCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Verified TrainingCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Navigating to /common/course-architect-analytics (CourseArchitectAnalyticsScreen)...");
  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Checking shell & content for CourseArchitectAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");
  cy.getCy("training-participation-metric").should("be.visible");
  cy.getCy("feedback-score-card").should("be.visible");
  cy.getCy("effectiveness-metric-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Saving screenshot for CourseArchitectAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Verified CourseArchitectAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Navigating to /common/course-architect-compliance (CourseArchitectComplianceScreen)...");
  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Checking shell & content for CourseArchitectComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");
  cy.getCy("trainingprogram-card").should("be.visible");
  cy.getCy("feedback-chart").should("be.visible");
  cy.getCy("compliance-status-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Saving screenshot for CourseArchitectComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Verified CourseArchitectComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Navigating to /common/course-architect-workflow (CourseArchitectWorkflowScreen)...");
  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Checking shell & content for CourseArchitectWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");
  cy.getCy("trainingprogram-card").should("be.visible");
  cy.getCy("feedbackscore-chart").should("be.visible");
  cy.getCy("completionrate-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Saving screenshot for CourseArchitectWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Verified CourseArchitectWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Navigating to /common/training-hub-analytics (TrainingHubAnalyticsScreen)...");
  cy.visitWithSemantics("/common/training-hub-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Checking shell & content for TrainingHubAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubanalytics-screen").should("be.visible");
  cy.getCy("traininghubanalytics-title").should("be.visible");
  cy.getCy("traininghubanalytics-content").should("be.visible");
  cy.getCy("training-progress-tracker").should("be.visible");
  cy.getCy("training-engagement-stats").should("be.visible");
  cy.getCy("training-assessment-scores").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Saving screenshot for TrainingHubAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Verified TrainingHubAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Navigating to /common/training-hub-compliance (TrainingHubComplianceScreen)...");
  cy.visitWithSemantics("/common/training-hub-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Checking shell & content for TrainingHubComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubcompliance-screen").should("be.visible");
  cy.getCy("traininghubcompliance-title").should("be.visible");
  cy.getCy("traininghubcompliance-content").should("be.visible");
  cy.getCy("training-hub-compliance-status").should("be.visible");
  cy.getCy("training-hub-training-modules").should("be.visible");
  cy.getCy("training-hub-audit-results").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Saving screenshot for TrainingHubComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Verified TrainingHubComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Navigating to /common/training-hub-workflow (TrainingHubWorkflowScreen)...");
  cy.visitWithSemantics("/common/training-hub-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Checking shell & content for TrainingHubWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubworkflow-screen").should("be.visible");
  cy.getCy("traininghubworkflow-title").should("be.visible");
  cy.getCy("traininghubworkflow-content").should("be.visible");
  cy.getCy("training-progress-tracker").should("be.visible");
  cy.getCy("training-assessment-score").should("be.visible");
  cy.getCy("training-event-calendar").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Saving screenshot for TrainingHubWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Verified TrainingHubWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Navigating to /offices/corporate/roles/training_director/analytics (TrainingDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Checking shell & content for TrainingDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectoranalytics-screen").should("be.visible");
  cy.getCy("trainingdirectoranalytics-title").should("be.visible");
  cy.getCy("trainingdirectoranalytics-content").should("be.visible");
  cy.getCy("training-progress-tracker").should("be.visible");
  cy.getCy("training-assessment-submit").should("be.visible");
  cy.getCy("training-attendance-record").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Saving screenshot for TrainingDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Verified TrainingDirectorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Navigating to /executive/training-director-compliance (TrainingDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/training-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Checking shell & content for TrainingDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcompliance-screen").should("be.visible");
  cy.getCy("trainingdirectorcompliance-title").should("be.visible");
  cy.getCy("trainingdirectorcompliance-content").should("be.visible");
  cy.getCy("training-dashboard-btn-feedback").should("be.visible");
  cy.getCy("training-dashboard-btn-resources").should("be.visible");
  cy.getCy("training-dashboard-btn-register").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Saving screenshot for TrainingDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Verified TrainingDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Navigating to /executive/training-director-workflow (TrainingDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/training-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Checking shell & content for TrainingDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorworkflow-screen").should("be.visible");
  cy.getCy("trainingdirectorworkflow-title").should("be.visible");
  cy.getCy("trainingdirectorworkflow-content").should("be.visible");
  cy.getCy("training-dashboard-btn-trigger-sweep").should("be.visible");
  cy.getCy("training-dashboard-btn-refresh-logs").should("be.visible");
  cy.getCy("training-dashboard-btn-view-historical").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Saving screenshot for TrainingDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Verified TrainingDirectorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Navigating to /staff/training-coordinator-analytics (TrainingCoordinatorAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/training-coordinator-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Checking shell & content for TrainingCoordinatorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatoranalytics-screen").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-title").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-content").should("be.visible");
  cy.getCy("training-analytics-btn-attendance").should("be.visible");
  cy.getCy("training-analytics-btn-assessment").should("be.visible");
  cy.getCy("training-analytics-btn-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Saving screenshot for TrainingCoordinatorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Verified TrainingCoordinatorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Navigating to /staff/training-coordinator-compliance (TrainingCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/staff/training-coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Checking shell & content for TrainingCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorcompliance-screen").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-title").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-content").should("be.visible");
  cy.getCy("training-completion-overview").should("be.visible");
  cy.getCy("training-session-schedule").should("be.visible");
  cy.getCy("compliance-audit-results").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Saving screenshot for TrainingCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Verified TrainingCoordinatorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Navigating to /staff/training-coordinator-workflow (TrainingCoordinatorWorkflowScreen)...");
  cy.visitWithSemantics("/staff/training-coordinator-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Checking shell & content for TrainingCoordinatorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorworkflow-screen").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-title").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-content").should("be.visible");
  cy.getCy("training-progress-tracker").should("be.visible");
  cy.getCy("training-session-calendar").should("be.visible");
  cy.getCy("training-notification-panel").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Saving screenshot for TrainingCoordinatorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Verified TrainingCoordinatorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Navigating to /staff/training-dashboard (TrainingDashboardScreen)...");
  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Checking shell & content for TrainingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-add-session").should("be.visible");
  cy.getCy("training-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("training-dashboard-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Saving screenshot for TrainingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Verified TrainingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Navigating to /staff/course-assignment (CourseAssignmentScreen)...");
  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Checking shell & content for CourseAssignmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");
  cy.getCy("training-dashboard-metrics").should("be.visible");
  cy.getCy("training-feedback-submit").should("be.visible");
  cy.getCy("training-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Saving screenshot for CourseAssignmentScreen...");
  cy.waitAndSee();
  cy.screenshot("course_assignment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Verified CourseAssignmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Navigating to /staff/certification-tracking (CertificationTrackingScreen)...");
  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Checking shell & content for CertificationTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");
  cy.getCy("training-session-overview").should("be.visible");
  cy.getCy("participation-metrics-chart").should("be.visible");
  cy.getCy("feedback-evaluation-card").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Saving screenshot for CertificationTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("certification_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Verified CertificationTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Navigating to /staff/staff-progress (StaffProgressScreen)...");
  cy.visitWithSemantics("/staff/staff-progress");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Checking shell & content for StaffProgressScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");
  cy.getCy("training-overview").should("be.visible");
  cy.getCy("engagement-metrics").should("be.visible");
  cy.getCy("feedback-results").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Saving screenshot for StaffProgressScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_progress");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Verified StaffProgressScreen successfully!\n");
  });

  it("tests org role ceo", () => {
    cy.loginAsRole("ceo");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Navigating to /executive/executive-command-center (ExecutiveCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/executive-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Checking shell & content for ExecutiveCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("executivecommandcenter-screen").should("be.visible");
  cy.getCy("executivecommandcenter-title").should("be.visible");
  cy.getCy("executivecommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Saving screenshot for ExecutiveCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("executive_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Verified ExecutiveCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Navigating to /executive/enterprise-health (EnterpriseHealthScreen)...");
  cy.visitWithSemantics("/executive/enterprise-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Checking shell & content for EnterpriseHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("enterprisehealth-screen").should("be.visible");
  cy.getCy("enterprisehealth-title").should("be.visible");
  cy.getCy("enterprisehealth-content").should("be.visible");
  cy.getCy("dashboard-kpi-financial").should("be.visible");
  cy.getCy("dashboard-metrics-operational").should("be.visible");
  cy.getCy("dashboard-engagement-employee").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Saving screenshot for EnterpriseHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("enterprise_health");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Verified EnterpriseHealthScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Navigating to /executive/revenue-analytics (RevenueAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/revenue-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Checking shell & content for RevenueAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenueanalytics-screen").should("be.visible");
  cy.getCy("revenueanalytics-title").should("be.visible");
  cy.getCy("revenueanalytics-content").should("be.visible");
  cy.getCy("revenue-analytics-btn-view-reports").should("be.visible");
  cy.getCy("revenue-analytics-btn-export-data").should("be.visible");
  cy.getCy("revenue-analytics-btn-set-goals").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Saving screenshot for RevenueAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("revenue_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Verified RevenueAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Navigating to /executive/risk-management (RiskManagementScreen)...");
  cy.visitWithSemantics("/executive/risk-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Checking shell & content for RiskManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("riskmanagement-screen").should("be.visible");
  cy.getCy("riskmanagement-title").should("be.visible");
  cy.getCy("riskmanagement-content").should("be.visible");
  cy.getCy("dashboard-kpi-view").should("be.visible");
  cy.getCy("dashboard-employee-engagement").should("be.visible");
  cy.getCy("dashboard-customer-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Saving screenshot for RiskManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("risk_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Verified RiskManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Navigating to /executive/franchise-overview (FranchiseOverviewScreen)...");
  cy.visitWithSemantics("/executive/franchise-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Checking shell & content for FranchiseOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseoverview-screen").should("be.visible");
  cy.getCy("franchiseoverview-title").should("be.visible");
  cy.getCy("franchiseoverview-content").should("be.visible");
  cy.getCy("franchise-overview-btn-refresh").should("be.visible");
  cy.getCy("franchise-overview-btn-report").should("be.visible");
  cy.getCy("franchise-overview-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Saving screenshot for FranchiseOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Verified FranchiseOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Navigating to /executive/enterprise-command-center4-k (EnterpriseCommandCenter4KScreen)...");
  cy.visitWithSemantics("/executive/enterprise-command-center4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Checking shell & content for EnterpriseCommandCenter4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("enterprisecommandcenter4k-screen").should("be.visible");
  cy.getCy("enterprisecommandcenter4k-title").should("be.visible");
  cy.getCy("enterprisecommandcenter4k-content").should("be.visible");
  cy.getCy("dashboard-kpi-refresh").should("be.visible");
  cy.getCy("dashboard-employee-satisfaction").should("be.visible");
  cy.getCy("dashboard-customer-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Saving screenshot for EnterpriseCommandCenter4KScreen...");
  cy.waitAndSee();
  cy.screenshot("enterprise_command_center4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Verified EnterpriseCommandCenter4KScreen successfully!\n");
  });

  it("tests org role cfo", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/17 | 5%] - Navigating to /offices/corporate/roles/cfo/dashboard (CfoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/17 | 5%] - Checking shell & content for CfoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfodashboard-screen").should("be.visible");
  cy.getCy("cfodashboard-title").should("be.visible");
  cy.getCy("cfodashboard-content").should("be.visible");
  cy.getCy("cfo-dashboard-cash-balance").should("be.visible");
  cy.getCy("cfo-dashboard-growth-rate").should("be.visible");
  cy.getCy("cfo-dashboard-expense-buffer").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/17 | 5%] - Saving screenshot for CfoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/17 | 5%] - Verified CfoDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/17 | 11%] - Navigating to /executive/cfo-analytics (CfoAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/cfo-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/17 | 11%] - Checking shell & content for CfoAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoanalytics-screen").should("be.visible");
  cy.getCy("cfoanalytics-title").should("be.visible");
  cy.getCy("cfoanalytics-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-financial-statement").should("be.visible");
  cy.getCy("cfo-dashboard-budget-actual").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/17 | 11%] - Saving screenshot for CfoAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/17 | 11%] - Verified CfoAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/17 | 17%] - Navigating to /executive/cfo-compliance (CfoComplianceScreen)...");
  cy.visitWithSemantics("/executive/cfo-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/17 | 17%] - Checking shell & content for CfoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocompliance-screen").should("be.visible");
  cy.getCy("cfocompliance-title").should("be.visible");
  cy.getCy("cfocompliance-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi-overview").should("be.visible");
  cy.getCy("cfo-dashboard-financial-health").should("be.visible");
  cy.getCy("cfo-dashboard-budget-actual").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/17 | 17%] - Saving screenshot for CfoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/17 | 17%] - Verified CfoComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/17 | 23%] - Navigating to /executive/cfo-workflow (CfoWorkflowScreen)...");
  cy.visitWithSemantics("/executive/cfo-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/17 | 23%] - Checking shell & content for CfoWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoworkflow-screen").should("be.visible");
  cy.getCy("cfoworkflow-title").should("be.visible");
  cy.getCy("cfoworkflow-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi-widget").should("be.visible");
  cy.getCy("cfo-dashboard-budget-analysis").should("be.visible");
  cy.getCy("cfo-dashboard-cash-flow").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/17 | 23%] - Saving screenshot for CfoWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/17 | 23%] - Verified CfoWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/17 | 29%] - Navigating to /offices/corporate/roles/cfo/revenue (CfoRevenueScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/revenue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/17 | 29%] - Checking shell & content for CfoRevenueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cforevenue-screen").should("be.visible");
  cy.getCy("cforevenue-title").should("be.visible");
  cy.getCy("cforevenue-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-compliance").should("be.visible");
  cy.getCy("cfo-dashboard-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/17 | 29%] - Saving screenshot for CfoRevenueScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_revenue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/17 | 29%] - Verified CfoRevenueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/17 | 35%] - Navigating to /offices/corporate/roles/cfo/expenses (CfoExpensesScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/expenses");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/17 | 35%] - Checking shell & content for CfoExpensesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoexpenses-screen").should("be.visible");
  cy.getCy("cfoexpenses-title").should("be.visible");
  cy.getCy("cfoexpenses-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi-overview").should("be.visible");
  cy.getCy("cfo-dashboard-financial-metrics").should("be.visible");
  cy.getCy("cfo-dashboard-budget-analysis").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/17 | 35%] - Saving screenshot for CfoExpensesScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_expenses");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/17 | 35%] - Verified CfoExpensesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/17 | 41%] - Navigating to /offices/corporate/roles/cfo/payroll (CfoPayrollScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/payroll");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/17 | 41%] - Checking shell & content for CfoPayrollScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfopayroll-screen").should("be.visible");
  cy.getCy("cfopayroll-title").should("be.visible");
  cy.getCy("cfopayroll-content").should("be.visible");
  cy.getCy("cfo-dashboard-btn-refresh").should("be.visible");
  cy.getCy("cfo-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("cfo-dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/17 | 41%] - Saving screenshot for CfoPayrollScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_payroll");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/17 | 41%] - Verified CfoPayrollScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/17 | 47%] - Navigating to /offices/corporate/roles/cfo/invoices (CfoInvoicesScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/invoices");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/17 | 47%] - Checking shell & content for CfoInvoicesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoinvoices-screen").should("be.visible");
  cy.getCy("cfoinvoices-title").should("be.visible");
  cy.getCy("cfoinvoices-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-cashflow").should("be.visible");
  cy.getCy("cfo-dashboard-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/17 | 47%] - Saving screenshot for CfoInvoicesScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_invoices");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/17 | 47%] - Verified CfoInvoicesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/17 | 52%] - Navigating to /executive/cfo-tax (CfoTaxScreen)...");
  cy.visitWithSemantics("/executive/cfo-tax");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/17 | 52%] - Checking shell & content for CfoTaxScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfotax-screen").should("be.visible");
  cy.getCy("cfotax-title").should("be.visible");
  cy.getCy("cfotax-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi-overview").should("be.visible");
  cy.getCy("cfo-dashboard-revenue-expense-trend").should("be.visible");
  cy.getCy("cfo-dashboard-cash-flow-projection").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/17 | 52%] - Saving screenshot for CfoTaxScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_tax");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/17 | 52%] - Verified CfoTaxScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/17 | 58%] - Navigating to /offices/corporate/roles/cfo/profitability (CfoProfitabilityScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/profitability");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/17 | 58%] - Checking shell & content for CfoProfitabilityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoprofitability-screen").should("be.visible");
  cy.getCy("cfoprofitability-title").should("be.visible");
  cy.getCy("cfoprofitability-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/17 | 58%] - Saving screenshot for CfoProfitabilityScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_profitability");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/17 | 58%] - Verified CfoProfitabilityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/17 | 64%] - Navigating to /executive/cfo-cashflow (CfoCashflowScreen)...");
  cy.visitWithSemantics("/executive/cfo-cashflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/17 | 64%] - Checking shell & content for CfoCashflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocashflow-screen").should("be.visible");
  cy.getCy("cfocashflow-title").should("be.visible");
  cy.getCy("cfocashflow-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi-widget").should("be.visible");
  cy.getCy("cfo-dashboard-cashflow-chart").should("be.visible");
  cy.getCy("cfo-dashboard-budget-comparison").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/17 | 64%] - Saving screenshot for CfoCashflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_cashflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/17 | 64%] - Verified CfoCashflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/17 | 70%] - Navigating to /executive/financial-dashboard (FinancialDashboardScreen)...");
  cy.visitWithSemantics("/executive/financial-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/17 | 70%] - Checking shell & content for FinancialDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialdashboard-screen").should("be.visible");
  cy.getCy("financialdashboard-title").should("be.visible");
  cy.getCy("financialdashboard-content").should("be.visible");
  cy.getCy("financial-dashboard-kpi-overview").should("be.visible");
  cy.getCy("financial-dashboard-revenue-expense-trend").should("be.visible");
  cy.getCy("financial-dashboard-cash-flow").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/17 | 70%] - Saving screenshot for FinancialDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("financial_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/17 | 70%] - Verified FinancialDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/17 | 76%] - Navigating to /executive/revenue (RevenueScreen)...");
  cy.visitWithSemantics("/executive/revenue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/17 | 76%] - Checking shell & content for RevenueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenue-screen").should("be.visible");
  cy.getCy("revenue-title").should("be.visible");
  cy.getCy("revenue-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/17 | 76%] - Saving screenshot for RevenueScreen...");
  cy.waitAndSee();
  cy.screenshot("revenue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/17 | 76%] - Verified RevenueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/17 | 82%] - Navigating to /executive/expense-management (ExpenseManagementScreen)...");
  cy.visitWithSemantics("/executive/expense-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/17 | 82%] - Checking shell & content for ExpenseManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("expensemanagement-screen").should("be.visible");
  cy.getCy("expensemanagement-title").should("be.visible");
  cy.getCy("expensemanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/17 | 82%] - Saving screenshot for ExpenseManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("expense_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/17 | 82%] - Verified ExpenseManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/17 | 88%] - Navigating to /executive/payroll (PayrollScreen)...");
  cy.visitWithSemantics("/executive/payroll");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/17 | 88%] - Checking shell & content for PayrollScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("payroll-screen").should("be.visible");
  cy.getCy("payroll-title").should("be.visible");
  cy.getCy("payroll-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-financial-statements").should("be.visible");
  cy.getCy("cfo-dashboard-budget-vs-actual").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/17 | 88%] - Saving screenshot for PayrollScreen...");
  cy.waitAndSee();
  cy.screenshot("payroll");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/17 | 88%] - Verified PayrollScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [16/17 | 94%] - Navigating to /executive/tax-compliance (TaxComplianceScreen)...");
  cy.visitWithSemantics("/executive/tax-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [16/17 | 94%] - Checking shell & content for TaxComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("taxcompliance-screen").should("be.visible");
  cy.getCy("taxcompliance-title").should("be.visible");
  cy.getCy("taxcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [16/17 | 94%] - Saving screenshot for TaxComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("tax_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [16/17 | 94%] - Verified TaxComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [17/17 | 100%] - Navigating to /executive/financial-operations4-k (FinancialOperations4KScreen)...");
  cy.visitWithSemantics("/executive/financial-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [17/17 | 100%] - Checking shell & content for FinancialOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialoperations4k-screen").should("be.visible");
  cy.getCy("financialoperations4k-title").should("be.visible");
  cy.getCy("financialoperations4k-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-financial-statements").should("be.visible");
  cy.getCy("cfo-dashboard-budget-comparison").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [17/17 | 100%] - Saving screenshot for FinancialOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("financial_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [17/17 | 100%] - Verified FinancialOperations4KScreen successfully!\n");
  });

  it("tests org role ciso", () => {
    cy.loginAsRole("ciso");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/corporate/roles/ciso/dashboard (CisoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/ciso/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for CisoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisodashboard-screen").should("be.visible");
  cy.getCy("cisodashboard-title").should("be.visible");
  cy.getCy("cisodashboard-content").should("be.visible");
  cy.getCy("ciso-dashboard-btn-refresh").should("be.visible");
  cy.getCy("ciso-dashboard-btn-view-report").should("be.visible");
  cy.getCy("ciso-dashboard-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for CisoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified CisoDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /executive/ciso-analytics (CisoAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/ciso-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for CisoAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoanalytics-screen").should("be.visible");
  cy.getCy("cisoanalytics-title").should("be.visible");
  cy.getCy("cisoanalytics-content").should("be.visible");
  cy.getCy("ciso-dashboard-btn-refresh").should("be.visible");
  cy.getCy("ciso-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("ciso-dashboard-btn-view-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for CisoAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified CisoAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /executive/ciso-compliance (CisoComplianceScreen)...");
  cy.visitWithSemantics("/executive/ciso-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for CisoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisocompliance-screen").should("be.visible");
  cy.getCy("cisocompliance-title").should("be.visible");
  cy.getCy("cisocompliance-content").should("be.visible");
  cy.getCy("ciso-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("ciso-dashboard-btn-initiate-risk-assessment").should("be.visible");
  cy.getCy("ciso-dashboard-btn-start-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for CisoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified CisoComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /executive/ciso-workflow (CisoWorkflowScreen)...");
  cy.visitWithSemantics("/executive/ciso-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for CisoWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoworkflow-screen").should("be.visible");
  cy.getCy("cisoworkflow-title").should("be.visible");
  cy.getCy("cisoworkflow-content").should("be.visible");
  cy.getCy("ciso-dashboard-btn-refresh").should("be.visible");
  cy.getCy("ciso-dashboard-btn-view-reports").should("be.visible");
  cy.getCy("ciso-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for CisoWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified CisoWorkflowScreen successfully!\n");
  });

  it("tests org role coo", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/26 | 3%] - Navigating to /offices/corporate/roles/coo/dashboard (CooDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/26 | 3%] - Checking shell & content for CooDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coodashboard-screen").should("be.visible");
  cy.getCy("coodashboard-title").should("be.visible");
  cy.getCy("coodashboard-content").should("be.visible");
  cy.getCy("coo-dashboard-active-operations").should("be.visible");
  cy.getCy("coo-dashboard-productivity-metric").should("be.visible");
  cy.getCy("coo-dashboard-security-clearance").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/26 | 3%] - Saving screenshot for CooDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/26 | 3%] - Verified CooDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/26 | 7%] - Navigating to /offices/corporate/roles/volunteer_coordinator/dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/volunteer_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/26 | 7%] - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");
  cy.getCy("volunteer-dashboard-add-volunteer").should("be.visible");
  cy.getCy("volunteer-dashboard-schedule-shift").should("be.visible");
  cy.getCy("volunteer-dashboard-send-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/26 | 7%] - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/26 | 7%] - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/26 | 11%] - Navigating to /executive/coo-analytics (CooAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/coo-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/26 | 11%] - Checking shell & content for CooAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooanalytics-screen").should("be.visible");
  cy.getCy("cooanalytics-title").should("be.visible");
  cy.getCy("cooanalytics-content").should("be.visible");
  cy.getCy("coo-dashboard-refresh").should("be.visible");
  cy.getCy("coo-dashboard-view-report").should("be.visible");
  cy.getCy("coo-dashboard-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/26 | 11%] - Saving screenshot for CooAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/26 | 11%] - Verified CooAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/26 | 15%] - Navigating to /offices/corporate/roles/coo/compliance-view (CooComplianceScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/compliance-view");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/26 | 15%] - Checking shell & content for CooComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocompliance-screen").should("be.visible");
  cy.getCy("coocompliance-title").should("be.visible");
  cy.getCy("coocompliance-content").should("be.visible");
  cy.getCy("coo-dashboard-kpi-widget").should("be.visible");
  cy.getCy("coo-dashboard-financial-metrics").should("be.visible");
  cy.getCy("coo-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/26 | 15%] - Saving screenshot for CooComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/26 | 15%] - Verified CooComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/26 | 19%] - Navigating to /executive/coo-workflow (CooWorkflowScreen)...");
  cy.visitWithSemantics("/executive/coo-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/26 | 19%] - Checking shell & content for CooWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflow-screen").should("be.visible");
  cy.getCy("cooworkflow-title").should("be.visible");
  cy.getCy("cooworkflow-content").should("be.visible");
  cy.getCy("coo-dashboard-refresh-data").should("be.visible");
  cy.getCy("coo-dashboard-export-report").should("be.visible");
  cy.getCy("coo-dashboard-set-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/26 | 19%] - Saving screenshot for CooWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/26 | 19%] - Verified CooWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/26 | 23%] - Navigating to /executive/coo-command-center (CooCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/coo-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/26 | 23%] - Checking shell & content for CooCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocommandcenter-screen").should("be.visible");
  cy.getCy("coocommandcenter-title").should("be.visible");
  cy.getCy("coocommandcenter-content").should("be.visible");
  cy.getCy("coo-dashboard-refresh-metrics").should("be.visible");
  cy.getCy("coo-dashboard-view-audit").should("be.visible");
  cy.getCy("coo-dashboard-export-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/26 | 23%] - Saving screenshot for CooCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/26 | 23%] - Verified CooCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/26 | 26%] - Navigating to /offices/corporate/roles/coo/operations-overview (CooOperationsOverviewScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/operations-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/26 | 26%] - Checking shell & content for CooOperationsOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coooperationsoverview-screen").should("be.visible");
  cy.getCy("coooperationsoverview-title").should("be.visible");
  cy.getCy("coooperationsoverview-content").should("be.visible");
  cy.getCy("coo-dashboard-kpi-overview").should("be.visible");
  cy.getCy("coo-dashboard-efficiency-metrics").should("be.visible");
  cy.getCy("coo-dashboard-financial-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/26 | 26%] - Saving screenshot for CooOperationsOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_operations_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/26 | 26%] - Verified CooOperationsOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/26 | 30%] - Navigating to /executive/coo-staffing (CooStaffingScreen)...");
  cy.visitWithSemantics("/executive/coo-staffing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/26 | 30%] - Checking shell & content for CooStaffingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coostaffing-screen").should("be.visible");
  cy.getCy("coostaffing-title").should("be.visible");
  cy.getCy("coostaffing-content").should("be.visible");
  cy.getCy("coo-dashboard-refresh-metrics").should("be.visible");
  cy.getCy("coo-dashboard-view-report").should("be.visible");
  cy.getCy("coo-dashboard-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/26 | 30%] - Saving screenshot for CooStaffingScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_staffing");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/26 | 30%] - Verified CooStaffingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/26 | 34%] - Navigating to /offices/corporate/roles/coo/scheduling-health (CooSchedulingHealthScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/scheduling-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/26 | 34%] - Checking shell & content for CooSchedulingHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooschedulinghealth-screen").should("be.visible");
  cy.getCy("cooschedulinghealth-title").should("be.visible");
  cy.getCy("cooschedulinghealth-content").should("be.visible");
  cy.getCy("dashboard-btn-refresh").should("be.visible");
  cy.getCy("dashboard-btn-view-report").should("be.visible");
  cy.getCy("dashboard-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/26 | 34%] - Saving screenshot for CooSchedulingHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_scheduling_health");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/26 | 34%] - Verified CooSchedulingHealthScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [10/26 | 38%] - Navigating to /executive/coo-workflow-issues (CooWorkflowIssuesScreen)...");
  cy.visitWithSemantics("/executive/coo-workflow-issues");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [10/26 | 38%] - Checking shell & content for CooWorkflowIssuesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflowissues-screen").should("be.visible");
  cy.getCy("cooworkflowissues-title").should("be.visible");
  cy.getCy("cooworkflowissues-content").should("be.visible");
  cy.getCy("coo-dashboard-kpi-overview").should("be.visible");
  cy.getCy("coo-dashboard-metrics").should("be.visible");
  cy.getCy("coo-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [10/26 | 38%] - Saving screenshot for CooWorkflowIssuesScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_workflow_issues");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [10/26 | 38%] - Verified CooWorkflowIssuesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/26 | 42%] - Navigating to /offices/corporate/roles/coo/branch-comparison (CooBranchComparisonScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/branch-comparison");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/26 | 42%] - Checking shell & content for CooBranchComparisonScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coobranchcomparison-screen").should("be.visible");
  cy.getCy("coobranchcomparison-title").should("be.visible");
  cy.getCy("coobranchcomparison-content").should("be.visible");
  cy.getCy("dashboard-kpi-widget").should("be.visible");
  cy.getCy("dashboard-financial-metrics").should("be.visible");
  cy.getCy("dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/26 | 42%] - Saving screenshot for CooBranchComparisonScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_branch_comparison");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/26 | 42%] - Verified CooBranchComparisonScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/26 | 46%] - Navigating to /executive/intake-coordinator-referrals (IntakeCoordinatorReferralsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/26 | 46%] - Checking shell & content for IntakeCoordinatorReferralsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-track-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/26 | 46%] - Saving screenshot for IntakeCoordinatorReferralsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/26 | 46%] - Verified IntakeCoordinatorReferralsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/26 | 50%] - Navigating to /executive/intake-coordinator-new-client-intake (IntakeCoordinatorNewClientIntakeScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/26 | 50%] - Checking shell & content for IntakeCoordinatorNewClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-recruit").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-log-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/26 | 50%] - Saving screenshot for IntakeCoordinatorNewClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/26 | 50%] - Verified IntakeCoordinatorNewClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/26 | 53%] - Navigating to /executive/intake-coordinator-assessment-queue (IntakeCoordinatorAssessmentQueueScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/26 | 53%] - Checking shell & content for IntakeCoordinatorAssessmentQueueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/26 | 53%] - Saving screenshot for IntakeCoordinatorAssessmentQueueScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/26 | 53%] - Verified IntakeCoordinatorAssessmentQueueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [15/26 | 57%] - Navigating to /executive/intake-coordinator-booking (IntakeCoordinatorBookingScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [15/26 | 57%] - Checking shell & content for IntakeCoordinatorBookingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-log-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [15/26 | 57%] - Saving screenshot for IntakeCoordinatorBookingScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [15/26 | 57%] - Verified IntakeCoordinatorBookingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/26 | 61%] - Navigating to /executive/intake-coordinator-documents (IntakeCoordinatorDocumentsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/26 | 61%] - Checking shell & content for IntakeCoordinatorDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-recruit").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/26 | 61%] - Saving screenshot for IntakeCoordinatorDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/26 | 61%] - Verified IntakeCoordinatorDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/26 | 65%] - Navigating to /executive/intake-coordinator-follow-up (IntakeCoordinatorFollowUpScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/26 | 65%] - Checking shell & content for IntakeCoordinatorFollowUpScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-update").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/26 | 65%] - Saving screenshot for IntakeCoordinatorFollowUpScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/26 | 65%] - Verified IntakeCoordinatorFollowUpScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [18/26 | 69%] - Navigating to /executive/operations-command-center (OperationsCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/operations-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [18/26 | 69%] - Checking shell & content for OperationsCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationscommandcenter-screen").should("be.visible");
  cy.getCy("operationscommandcenter-title").should("be.visible");
  cy.getCy("operationscommandcenter-content").should("be.visible");
  cy.getCy("operations-dashboard-kpi").should("be.visible");
  cy.getCy("operations-dashboard-metrics").should("be.visible");
  cy.getCy("operations-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [18/26 | 69%] - Saving screenshot for OperationsCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [18/26 | 69%] - Verified OperationsCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/26 | 73%] - Navigating to /executive/staffing-overview (StaffingOverviewScreen)...");
  cy.visitWithSemantics("/executive/staffing-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/26 | 73%] - Checking shell & content for StaffingOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffingoverview-screen").should("be.visible");
  cy.getCy("staffingoverview-title").should("be.visible");
  cy.getCy("staffingoverview-content").should("be.visible");
  cy.getCy("dashboard-kpi-overview").should("be.visible");
  cy.getCy("dashboard-efficiency-chart").should("be.visible");
  cy.getCy("dashboard-financial-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/26 | 73%] - Saving screenshot for StaffingOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("staffing_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/26 | 73%] - Verified StaffingOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [20/26 | 76%] - Navigating to /executive/workflow-issue (WorkflowIssueScreen)...");
  cy.visitWithSemantics("/executive/workflow-issue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [20/26 | 76%] - Checking shell & content for WorkflowIssueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowissue-screen").should("be.visible");
  cy.getCy("workflowissue-title").should("be.visible");
  cy.getCy("workflowissue-content").should("be.visible");
  cy.getCy("coo-dashboard-kpi").should("be.visible");
  cy.getCy("coo-dashboard-financials").should("be.visible");
  cy.getCy("coo-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [20/26 | 76%] - Saving screenshot for WorkflowIssueScreen...");
  cy.waitAndSee();
  cy.screenshot("workflow_issue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [20/26 | 76%] - Verified WorkflowIssueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/26 | 80%] - Navigating to /executive/service-quality (ServiceQualityScreen)...");
  cy.visitWithSemantics("/executive/service-quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/26 | 80%] - Checking shell & content for ServiceQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("servicequality-screen").should("be.visible");
  cy.getCy("servicequality-title").should("be.visible");
  cy.getCy("servicequality-content").should("be.visible");
  cy.getCy("c-dashboard-btn-refresh").should("be.visible");
  cy.getCy("c-dashboard-btn-export").should("be.visible");
  cy.getCy("c-dashboard-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/26 | 80%] - Saving screenshot for ServiceQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("service_quality");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/26 | 80%] - Verified ServiceQualityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/26 | 84%] - Navigating to /executive/branch-performance (BranchPerformanceScreen)...");
  cy.visitWithSemantics("/executive/branch-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/26 | 84%] - Checking shell & content for BranchPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("branchperformance-screen").should("be.visible");
  cy.getCy("branchperformance-title").should("be.visible");
  cy.getCy("branchperformance-content").should("be.visible");
  cy.getCy("dashboard-btn-refresh").should("be.visible");
  cy.getCy("dashboard-btn-report").should("be.visible");
  cy.getCy("dashboard-btn-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/26 | 84%] - Saving screenshot for BranchPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("branch_performance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/26 | 84%] - Verified BranchPerformanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [23/26 | 88%] - Navigating to /staff/training-dashboard (TrainingDashboardScreen)...");
  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [23/26 | 88%] - Checking shell & content for TrainingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-add-session").should("be.visible");
  cy.getCy("training-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("training-dashboard-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [23/26 | 88%] - Saving screenshot for TrainingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [23/26 | 88%] - Verified TrainingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/26 | 92%] - Navigating to /staff/course-assignment (CourseAssignmentScreen)...");
  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/26 | 92%] - Checking shell & content for CourseAssignmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");
  cy.getCy("training-dashboard-metrics").should("be.visible");
  cy.getCy("training-feedback-submit").should("be.visible");
  cy.getCy("training-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/26 | 92%] - Saving screenshot for CourseAssignmentScreen...");
  cy.waitAndSee();
  cy.screenshot("course_assignment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/26 | 92%] - Verified CourseAssignmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [25/26 | 96%] - Navigating to /staff/certification-tracking (CertificationTrackingScreen)...");
  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [25/26 | 96%] - Checking shell & content for CertificationTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");
  cy.getCy("training-session-overview").should("be.visible");
  cy.getCy("participation-metrics-chart").should("be.visible");
  cy.getCy("feedback-evaluation-card").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [25/26 | 96%] - Saving screenshot for CertificationTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("certification_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [25/26 | 96%] - Verified CertificationTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [26/26 | 100%] - Navigating to /staff/staff-progress (StaffProgressScreen)...");
  cy.visitWithSemantics("/staff/staff-progress");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [26/26 | 100%] - Checking shell & content for StaffProgressScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");
  cy.getCy("training-overview").should("be.visible");
  cy.getCy("engagement-metrics").should("be.visible");
  cy.getCy("feedback-results").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [26/26 | 100%] - Saving screenshot for StaffProgressScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_progress");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [26/26 | 100%] - Verified StaffProgressScreen successfully!\n");
  });

  it("tests org role cto", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/76 | 1%] - Navigating to /offices/clinical/roles/clinical_director/dashboard (ClinicalDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/76 | 1%] - Checking shell & content for ClinicalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldashboard-screen").should("be.visible");
  cy.getCy("clinicaldashboard-title").should("be.visible");
  cy.getCy("clinicaldashboard-content").should("be.visible");
  cy.getCy("clinical-dashboard-compliance-status").should("be.visible");
  cy.getCy("clinical-dashboard-performance-metrics").should("be.visible");
  cy.getCy("clinical-dashboard-activity-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/76 | 1%] - Saving screenshot for ClinicalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/76 | 1%] - Verified ClinicalDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/76 | 2%] - Navigating to /common/architecture-planning-dashboard (ArchitecturePlanningDashboardScreen)...");
  cy.visitWithSemantics("/common/architecture-planning-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/76 | 2%] - Checking shell & content for ArchitecturePlanningDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningdashboard-screen").should("be.visible");
  cy.getCy("architectureplanningdashboard-title").should("be.visible");
  cy.getCy("architectureplanningdashboard-content").should("be.visible");
  cy.getCy("ctodashboard-btn-refresh").should("be.visible");
  cy.getCy("ctodashboard-btn-view-report").should("be.visible");
  cy.getCy("ctodashboard-btn-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/76 | 2%] - Saving screenshot for ArchitecturePlanningDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/76 | 2%] - Verified ArchitecturePlanningDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/76 | 3%] - Navigating to /offices/clinical/roles/chiropractor/dashboard (ChiropractorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/76 | 3%] - Checking shell & content for ChiropractorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractordashboard-screen").should("be.visible");
  cy.getCy("chiropractordashboard-title").should("be.visible");
  cy.getCy("chiropractordashboard-content").should("be.visible");
  cy.getCy("chiropractor-btn-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-treatment").should("be.visible");
  cy.getCy("chiropractor-btn-adjust").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/76 | 3%] - Saving screenshot for ChiropractorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/76 | 3%] - Verified ChiropractorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/76 | 5%] - Navigating to /offices/clinical/roles/clinical_director/clinic-dashboard (ClinicDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/76 | 5%] - Checking shell & content for ClinicDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicdashboard-screen").should("be.visible");
  cy.getCy("clinicdashboard-title").should("be.visible");
  cy.getCy("clinicdashboard-content").should("be.visible");
  cy.getCy("clinic-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinic-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinic-dashboard-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/76 | 5%] - Saving screenshot for ClinicDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/76 | 5%] - Verified ClinicDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/76 | 6%] - Navigating to /common/course-architect-dashboard (CourseArchitectDashboardScreen)...");
  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/76 | 6%] - Checking shell & content for CourseArchitectDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");
  cy.getCy("dashboard-participation-metric").should("be.visible");
  cy.getCy("dashboard-feedback-score").should("be.visible");
  cy.getCy("dashboard-effectiveness-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/76 | 6%] - Saving screenshot for CourseArchitectDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/76 | 6%] - Verified CourseArchitectDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/76 | 7%] - Navigating to /offices/corporate/roles/cto/dashboard (CtoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/76 | 7%] - Checking shell & content for CtoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctodashboard-screen").should("be.visible");
  cy.getCy("ctodashboard-title").should("be.visible");
  cy.getCy("ctodashboard-content").should("be.visible");
  cy.getCy("cto-dashboard-kpi-widget").should("be.visible");
  cy.getCy("cto-dashboard-performance-chart").should("be.visible");
  cy.getCy("cto-dashboard-security-card").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/76 | 7%] - Saving screenshot for CtoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/76 | 7%] - Verified CtoDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/76 | 9%] - Navigating to /offices/corporate/roles/cx_director/dashboard (CxDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cx_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/76 | 9%] - Checking shell & content for CxDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");
  cy.getCy("cxdashboard-widget-customer-satisfaction").should("be.visible");
  cy.getCy("cxdashboard-widget-feedback-trends").should("be.visible");
  cy.getCy("cxdashboard-widget-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/76 | 9%] - Saving screenshot for CxDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/76 | 9%] - Verified CxDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/76 | 10%] - Navigating to /offices/corporate/roles/finance_director/dashboard (FinanceDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/finance_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/76 | 10%] - Checking shell & content for FinanceDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectordashboard-screen").should("be.visible");
  cy.getCy("financedirectordashboard-title").should("be.visible");
  cy.getCy("financedirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/76 | 10%] - Saving screenshot for FinanceDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/76 | 10%] - Verified FinanceDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/76 | 11%] - Navigating to /offices/corporate/roles/hr_director/dashboard (HrDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/76 | 11%] - Checking shell & content for HrDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectordashboard-screen").should("be.visible");
  cy.getCy("hrdirectordashboard-title").should("be.visible");
  cy.getCy("hrdirectordashboard-content").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-feedback").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/76 | 11%] - Saving screenshot for HrDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/76 | 11%] - Verified HrDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/76 | 13%] - Navigating to /offices/corporate/roles/training_director/dashboard (TrainingDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/76 | 13%] - Checking shell & content for TrainingDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("training-dashboard-btn-adjust-program").should("be.visible");
  cy.getCy("training-dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/76 | 13%] - Saving screenshot for TrainingDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/76 | 13%] - Verified TrainingDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/76 | 14%] - Navigating to /offices/corporate/roles/hr_manager/dashboard (HrManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/76 | 14%] - Checking shell & content for HrManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerdashboard-screen").should("be.visible");
  cy.getCy("hrmanagerdashboard-title").should("be.visible");
  cy.getCy("hrmanagerdashboard-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-reports").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");
  cy.getCy("hrdashboard-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/76 | 14%] - Saving screenshot for HrManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/76 | 14%] - Verified HrManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/76 | 15%] - Navigating to /offices/clinical/roles/clinical_director/analytics (ClinicalAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/76 | 15%] - Checking shell & content for ClinicalAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalanalytics-screen").should("be.visible");
  cy.getCy("clinicalanalytics-title").should("be.visible");
  cy.getCy("clinicalanalytics-content").should("be.visible");
  cy.getCy("clinical-analytics-kpi-chart").should("be.visible");
  cy.getCy("clinical-analytics-staff-performance").should("be.visible");
  cy.getCy("clinical-analytics-compliance-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/76 | 15%] - Saving screenshot for ClinicalAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/76 | 15%] - Verified ClinicalAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/76 | 17%] - Navigating to /offices/clinical/roles/clinical_director/compliance (ClinicalComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/76 | 17%] - Checking shell & content for ClinicalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalcompliance-screen").should("be.visible");
  cy.getCy("clinicalcompliance-title").should("be.visible");
  cy.getCy("clinicalcompliance-content").should("be.visible");
  cy.getCy("clinical-compliance-audit-results").should("be.visible");
  cy.getCy("clinical-compliance-alert").should("be.visible");
  cy.getCy("clinical-training-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/76 | 17%] - Saving screenshot for ClinicalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/76 | 17%] - Verified ClinicalComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/76 | 18%] - Navigating to /offices/clinical/roles/clinical_director/workflow (ClinicalWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/76 | 18%] - Checking shell & content for ClinicalWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalworkflow-screen").should("be.visible");
  cy.getCy("clinicalworkflow-title").should("be.visible");
  cy.getCy("clinicalworkflow-content").should("be.visible");
  cy.getCy("clinical-dashboard-kpi").should("be.visible");
  cy.getCy("clinical-dashboard-policies").should("be.visible");
  cy.getCy("clinical-dashboard-budgets").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/76 | 18%] - Saving screenshot for ClinicalWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/76 | 18%] - Verified ClinicalWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [15/76 | 19%] - Navigating to /offices/clinical/roles/chiropractor/analytics (ChiropractorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [15/76 | 19%] - Checking shell & content for ChiropractorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractoranalytics-screen").should("be.visible");
  cy.getCy("chiropractoranalytics-title").should("be.visible");
  cy.getCy("chiropractoranalytics-content").should("be.visible");
  cy.getCy("chiropractor-btn-add-patient").should("be.visible");
  cy.getCy("chiropractor-btn-update-treatment").should("be.visible");
  cy.getCy("chiropractor-btn-record-progress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [15/76 | 19%] - Saving screenshot for ChiropractorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [15/76 | 19%] - Verified ChiropractorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [16/76 | 21%] - Navigating to /offices/clinical/roles/chiropractor/compliance (ChiropractorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [16/76 | 21%] - Checking shell & content for ChiropractorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcompliance-screen").should("be.visible");
  cy.getCy("chiropractorcompliance-title").should("be.visible");
  cy.getCy("chiropractorcompliance-content").should("be.visible");
  cy.getCy("chiropractor-btn-schedule-appointment").should("be.visible");
  cy.getCy("chiropractor-btn-generate-report").should("be.visible");
  cy.getCy("chiropractor-btn-update-treatment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [16/76 | 21%] - Saving screenshot for ChiropractorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [16/76 | 21%] - Verified ChiropractorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/76 | 22%] - Navigating to /offices/clinical/roles/chiropractor/workflow (ChiropractorWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/76 | 22%] - Checking shell & content for ChiropractorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorworkflow-screen").should("be.visible");
  cy.getCy("chiropractorworkflow-title").should("be.visible");
  cy.getCy("chiropractorworkflow-content").should("be.visible");
  cy.getCy("chiropractor-btn-schedule-appointment").should("be.visible");
  cy.getCy("chiropractor-btn-modify-treatment").should("be.visible");
  cy.getCy("chiropractor-btn-record-progress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/76 | 22%] - Saving screenshot for ChiropractorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/76 | 22%] - Verified ChiropractorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/76 | 23%] - Navigating to /offices/clinical/roles/clinical_director/clinic-analytics (ClinicAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/76 | 23%] - Checking shell & content for ClinicAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicanalytics-screen").should("be.visible");
  cy.getCy("clinicanalytics-title").should("be.visible");
  cy.getCy("clinicanalytics-content").should("be.visible");
  cy.getCy("clinic-analytics-btn-view-reports").should("be.visible");
  cy.getCy("clinic-analytics-btn-manage-budgets").should("be.visible");
  cy.getCy("clinic-analytics-btn-staff-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/76 | 23%] - Saving screenshot for ClinicAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/76 | 23%] - Verified ClinicAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/76 | 25%] - Navigating to /offices/clinical/roles/clinical_director/clinic-compliance (ClinicComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/76 | 25%] - Checking shell & content for ClinicComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cliniccompliance-screen").should("be.visible");
  cy.getCy("cliniccompliance-title").should("be.visible");
  cy.getCy("cliniccompliance-content").should("be.visible");
  cy.getCy("clinic-compliance-audit-results").should("be.visible");
  cy.getCy("clinic-patient-satisfaction").should("be.visible");
  cy.getCy("clinic-staff-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/76 | 25%] - Saving screenshot for ClinicComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/76 | 25%] - Verified ClinicComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/76 | 26%] - Navigating to /offices/clinical/roles/clinical_director/clinic-workflow (ClinicWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/76 | 26%] - Checking shell & content for ClinicWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicworkflow-screen").should("be.visible");
  cy.getCy("clinicworkflow-title").should("be.visible");
  cy.getCy("clinicworkflow-content").should("be.visible");
  cy.getCy("clinic-dashboard-kpi").should("be.visible");
  cy.getCy("clinic-dashboard-budget").should("be.visible");
  cy.getCy("clinic-dashboard-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/76 | 26%] - Saving screenshot for ClinicWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/76 | 26%] - Verified ClinicWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/76 | 27%] - Navigating to /common/course-architect-analytics (CourseArchitectAnalyticsScreen)...");
  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/76 | 27%] - Checking shell & content for CourseArchitectAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");
  cy.getCy("training-participation-metric").should("be.visible");
  cy.getCy("feedback-score-card").should("be.visible");
  cy.getCy("effectiveness-metric-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/76 | 27%] - Saving screenshot for CourseArchitectAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/76 | 27%] - Verified CourseArchitectAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/76 | 28%] - Navigating to /common/course-architect-compliance (CourseArchitectComplianceScreen)...");
  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/76 | 28%] - Checking shell & content for CourseArchitectComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");
  cy.getCy("trainingprogram-card").should("be.visible");
  cy.getCy("feedback-chart").should("be.visible");
  cy.getCy("compliance-status-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/76 | 28%] - Saving screenshot for CourseArchitectComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/76 | 28%] - Verified CourseArchitectComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [23/76 | 30%] - Navigating to /common/course-architect-workflow (CourseArchitectWorkflowScreen)...");
  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [23/76 | 30%] - Checking shell & content for CourseArchitectWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");
  cy.getCy("trainingprogram-card").should("be.visible");
  cy.getCy("feedbackscore-chart").should("be.visible");
  cy.getCy("completionrate-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [23/76 | 30%] - Saving screenshot for CourseArchitectWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [23/76 | 30%] - Verified CourseArchitectWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [24/76 | 31%] - Navigating to /executive/cto-analytics (CtoAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/cto-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [24/76 | 31%] - Checking shell & content for CtoAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoanalytics-screen").should("be.visible");
  cy.getCy("ctoanalytics-title").should("be.visible");
  cy.getCy("ctoanalytics-content").should("be.visible");
  cy.getCy("cto-dashboard-project-status").should("be.visible");
  cy.getCy("cto-dashboard-budget-utilization").should("be.visible");
  cy.getCy("cto-dashboard-team-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [24/76 | 31%] - Saving screenshot for CtoAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [24/76 | 31%] - Verified CtoAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [25/76 | 32%] - Navigating to /executive/cto-compliance (CtoComplianceScreen)...");
  cy.visitWithSemantics("/executive/cto-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [25/76 | 32%] - Checking shell & content for CtoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctocompliance-screen").should("be.visible");
  cy.getCy("ctocompliance-title").should("be.visible");
  cy.getCy("ctocompliance-content").should("be.visible");
  cy.getCy("cto-dashboard-btn-refresh").should("be.visible");
  cy.getCy("cto-dashboard-btn-audit-logs").should("be.visible");
  cy.getCy("cto-dashboard-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [25/76 | 32%] - Saving screenshot for CtoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [25/76 | 32%] - Verified CtoComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/76 | 34%] - Navigating to /executive/cto-workflow (CtoWorkflowScreen)...");
  cy.visitWithSemantics("/executive/cto-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/76 | 34%] - Checking shell & content for CtoWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoworkflow-screen").should("be.visible");
  cy.getCy("ctoworkflow-title").should("be.visible");
  cy.getCy("ctoworkflow-content").should("be.visible");
  cy.getCy("ctoworkflow-btn-refresh").should("be.visible");
  cy.getCy("ctoworkflow-btn-view-reports").should("be.visible");
  cy.getCy("ctoworkflow-btn-add-technology").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/76 | 34%] - Saving screenshot for CtoWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/76 | 34%] - Verified CtoWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/76 | 35%] - Navigating to /executive/cx-director-analytics (CxDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/cx-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/76 | 35%] - Checking shell & content for CxDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectoranalytics-screen").should("be.visible");
  cy.getCy("cxdirectoranalytics-title").should("be.visible");
  cy.getCy("cxdirectoranalytics-content").should("be.visible");
  cy.getCy("cxdashboard-btn-refresh").should("be.visible");
  cy.getCy("cxdashboard-btn-export").should("be.visible");
  cy.getCy("cxdashboard-btn-viewdetails").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/76 | 35%] - Saving screenshot for CxDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/76 | 35%] - Verified CxDirectorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/76 | 36%] - Navigating to /executive/cx-director-compliance (CxDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/cx-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/76 | 36%] - Checking shell & content for CxDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorcompliance-screen").should("be.visible");
  cy.getCy("cxdirectorcompliance-title").should("be.visible");
  cy.getCy("cxdirectorcompliance-content").should("be.visible");
  cy.getCy("cxdirector-btn-generate-report").should("be.visible");
  cy.getCy("cxdirector-btn-initiate-audit").should("be.visible");
  cy.getCy("cxdirector-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/76 | 36%] - Saving screenshot for CxDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/76 | 36%] - Verified CxDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/76 | 38%] - Navigating to /executive/cx-director-workflow (CxDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/cx-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/76 | 38%] - Checking shell & content for CxDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorworkflow-screen").should("be.visible");
  cy.getCy("cxdirectorworkflow-title").should("be.visible");
  cy.getCy("cxdirectorworkflow-content").should("be.visible");
  cy.getCy("cxdashboard-btn-generate-report").should("be.visible");
  cy.getCy("cxdashboard-btn-view-details").should("be.visible");
  cy.getCy("cxdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/76 | 38%] - Saving screenshot for CxDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/76 | 38%] - Verified CxDirectorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [30/76 | 39%] - Navigating to /executive/finance-director-analytics (FinanceDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/finance-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [30/76 | 39%] - Checking shell & content for FinanceDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectoranalytics-screen").should("be.visible");
  cy.getCy("financedirectoranalytics-title").should("be.visible");
  cy.getCy("financedirectoranalytics-content").should("be.visible");
  cy.getCy("finance-kpi-widget").should("be.visible");
  cy.getCy("finance-cashflow-monitor").should("be.visible");
  cy.getCy("finance-budget-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [30/76 | 39%] - Saving screenshot for FinanceDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [30/76 | 39%] - Verified FinanceDirectorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [31/76 | 40%] - Navigating to /executive/finance-director-compliance (FinanceDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/finance-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [31/76 | 40%] - Checking shell & content for FinanceDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorcompliance-screen").should("be.visible");
  cy.getCy("financedirectorcompliance-title").should("be.visible");
  cy.getCy("financedirectorcompliance-content").should("be.visible");
  cy.getCy("finance-kpi-widget").should("be.visible");
  cy.getCy("finance-cashflow-chart").should("be.visible");
  cy.getCy("finance-budget-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [31/76 | 40%] - Saving screenshot for FinanceDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [31/76 | 40%] - Verified FinanceDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [32/76 | 42%] - Navigating to /executive/finance-director-workflow (FinanceDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/finance-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [32/76 | 42%] - Checking shell & content for FinanceDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorworkflow-screen").should("be.visible");
  cy.getCy("financedirectorworkflow-title").should("be.visible");
  cy.getCy("financedirectorworkflow-content").should("be.visible");
  cy.getCy("finance-kpi-widget").should("be.visible");
  cy.getCy("finance-cashflow-monitor").should("be.visible");
  cy.getCy("finance-budget-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [32/76 | 42%] - Saving screenshot for FinanceDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [32/76 | 42%] - Verified FinanceDirectorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [33/76 | 43%] - Navigating to /executive/hr-director-analytics (HrDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/hr-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [33/76 | 43%] - Checking shell & content for HrDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoranalytics-screen").should("be.visible");
  cy.getCy("hrdirectoranalytics-title").should("be.visible");
  cy.getCy("hrdirectoranalytics-content").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [33/76 | 43%] - Saving screenshot for HrDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [33/76 | 43%] - Verified HrDirectorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/76 | 44%] - Navigating to /executive/hr-director-compliance (HrDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/hr-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/76 | 44%] - Checking shell & content for HrDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcompliance-screen").should("be.visible");
  cy.getCy("hrdirectorcompliance-title").should("be.visible");
  cy.getCy("hrdirectorcompliance-content").should("be.visible");
  cy.getCy("hrdirector-btn-generate-report").should("be.visible");
  cy.getCy("hrdirector-btn-view-audit").should("be.visible");
  cy.getCy("hrdirector-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/76 | 44%] - Saving screenshot for HrDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/76 | 44%] - Verified HrDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/76 | 46%] - Navigating to /executive/hr-director-workflow (HrDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/hr-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/76 | 46%] - Checking shell & content for HrDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorworkflow-screen").should("be.visible");
  cy.getCy("hrdirectorworkflow-title").should("be.visible");
  cy.getCy("hrdirectorworkflow-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-reports").should("be.visible");
  cy.getCy("hrdashboard-btn-manage-policies").should("be.visible");
  cy.getCy("hrdashboard-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/76 | 46%] - Saving screenshot for HrDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/76 | 46%] - Verified HrDirectorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/76 | 47%] - Navigating to /staff/hr-manager-analytics (HrManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/76 | 47%] - Checking shell & content for HrManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanageranalytics-screen").should("be.visible");
  cy.getCy("hrmanageranalytics-title").should("be.visible");
  cy.getCy("hrmanageranalytics-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/76 | 47%] - Saving screenshot for HrManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/76 | 47%] - Verified HrManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [37/76 | 48%] - Navigating to /staff/hr-manager-compliance (HrManagerComplianceScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [37/76 | 48%] - Checking shell & content for HrManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagercompliance-screen").should("be.visible");
  cy.getCy("hrmanagercompliance-title").should("be.visible");
  cy.getCy("hrmanagercompliance-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [37/76 | 48%] - Saving screenshot for HrManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [37/76 | 48%] - Verified HrManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [38/76 | 50%] - Navigating to /staff/hr-manager-workflow (HrManagerWorkflowScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [38/76 | 50%] - Checking shell & content for HrManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerworkflow-screen").should("be.visible");
  cy.getCy("hrmanagerworkflow-title").should("be.visible");
  cy.getCy("hrmanagerworkflow-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-reports").should("be.visible");
  cy.getCy("hr-dashboard-btn-manage-policies").should("be.visible");
  cy.getCy("hr-dashboard-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [38/76 | 50%] - Saving screenshot for HrManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [38/76 | 50%] - Verified HrManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [39/76 | 51%] - Navigating to /offices/clinical/roles/chiropractor/command-center (ChiropractorCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [39/76 | 51%] - Checking shell & content for ChiropractorCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
  cy.getCy("chiropractorcommandcenter-title").should("be.visible");
  cy.getCy("chiropractorcommandcenter-content").should("be.visible");
  cy.getCy("chiropractor-btn-add-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-update-plan").should("be.visible");
  cy.getCy("chiropractor-btn-record-adjustment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [39/76 | 51%] - Saving screenshot for ChiropractorCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [39/76 | 51%] - Verified ChiropractorCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [40/76 | 52%] - Navigating to /offices/clinical/roles/chiropractor/appointments (ChiropractorAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [40/76 | 52%] - Checking shell & content for ChiropractorAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorappointments-screen").should("be.visible");
  cy.getCy("chiropractorappointments-title").should("be.visible");
  cy.getCy("chiropractorappointments-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-schedule").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-compliance").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [40/76 | 52%] - Saving screenshot for ChiropractorAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [40/76 | 52%] - Verified ChiropractorAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [41/76 | 53%] - Navigating to /offices/clinical/roles/chiropractor/client-intake (ChiropractorClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [41/76 | 53%] - Checking shell & content for ChiropractorClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorclientintake-screen").should("be.visible");
  cy.getCy("chiropractorclientintake-title").should("be.visible");
  cy.getCy("chiropractorclientintake-content").should("be.visible");
  cy.getCy("chiropractor-btn-submit-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-review-history").should("be.visible");
  cy.getCy("chiropractor-btn-perform-examination").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [41/76 | 53%] - Saving screenshot for ChiropractorClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [41/76 | 53%] - Verified ChiropractorClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/76 | 55%] - Navigating to /offices/clinical/roles/chiropractor/assessment (ChiropractorAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/76 | 55%] - Checking shell & content for ChiropractorAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorassessment-screen").should("be.visible");
  cy.getCy("chiropractorassessment-title").should("be.visible");
  cy.getCy("chiropractorassessment-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-active-operations").should("be.visible");
  cy.getCy("chiropractor-dashboard-security-status").should("be.visible");
  cy.getCy("chiropractor-dashboard-telemetry-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/76 | 55%] - Saving screenshot for ChiropractorAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/76 | 55%] - Verified ChiropractorAssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/76 | 56%] - Navigating to /offices/clinical/roles/chiropractor/treatment-notes (ChiropractorTreatmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/treatment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/76 | 56%] - Checking shell & content for ChiropractorTreatmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-view-feedback").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-generate-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/76 | 56%] - Saving screenshot for ChiropractorTreatmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_treatment_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/76 | 56%] - Verified ChiropractorTreatmentNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/76 | 57%] - Navigating to /offices/clinical/roles/chiropractor/exercise-plan (ChiropractorExercisePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/exercise-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/76 | 57%] - Checking shell & content for ChiropractorExercisePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
  cy.getCy("chiropractorexerciseplan-title").should("be.visible");
  cy.getCy("chiropractorexerciseplan-content").should("be.visible");
  cy.getCy("chiropractor-btn-add-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-update-plan").should("be.visible");
  cy.getCy("chiropractor-btn-record-adjustment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/76 | 57%] - Saving screenshot for ChiropractorExercisePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_exercise_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/76 | 57%] - Verified ChiropractorExercisePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [45/76 | 59%] - Navigating to /offices/clinical/roles/chiropractor/billing-link (ChiropractorBillingLinkScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/billing-link");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [45/76 | 59%] - Checking shell & content for ChiropractorBillingLinkScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorbillinglink-screen").should("be.visible");
  cy.getCy("chiropractorbillinglink-title").should("be.visible");
  cy.getCy("chiropractorbillinglink-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-operational-action").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-view-patient-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [45/76 | 59%] - Saving screenshot for ChiropractorBillingLinkScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_billing_link");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [45/76 | 59%] - Verified ChiropractorBillingLinkScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [46/76 | 60%] - Navigating to /offices/clinical/roles/chiropractor/reports (ChiropractorReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [46/76 | 60%] - Checking shell & content for ChiropractorReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorreports-screen").should("be.visible");
  cy.getCy("chiropractorreports-title").should("be.visible");
  cy.getCy("chiropractorreports-content").should("be.visible");
  cy.getCy("chiropractor-btn-compliance-scan").should("be.visible");
  cy.getCy("chiropractor-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [46/76 | 60%] - Saving screenshot for ChiropractorReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [46/76 | 60%] - Verified ChiropractorReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [47/76 | 61%] - Navigating to /offices/clinical/roles/clinical_director/staff-quality (ClinicalDirectorStaffQualityScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [47/76 | 61%] - Checking shell & content for ClinicalDirectorStaffQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorstaffquality-screen").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-title").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [47/76 | 61%] - Saving screenshot for ClinicalDirectorStaffQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_staff_quality");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [47/76 | 61%] - Verified ClinicalDirectorStaffQualityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [48/76 | 63%] - Navigating to /offices/clinical/roles/clinical_director/incident-review (ClinicalDirectorIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [48/76 | 63%] - Checking shell & content for ClinicalDirectorIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorincidentreview-screen").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-title").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-incidents").should("be.visible");
  cy.getCy("clinical-dashboard-btn-conduct-audit").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [48/76 | 63%] - Saving screenshot for ClinicalDirectorIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_incident_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [48/76 | 63%] - Verified ClinicalDirectorIncidentReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [49/76 | 64%] - Navigating to /offices/clinical/roles/clinical_director/compliance-director (ClinicalDirectorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-director");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [49/76 | 64%] - Checking shell & content for ClinicalDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorcompliance-screen").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-title").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-content").should("be.visible");
  cy.getCy("clinical-dashboard-compliance-status").should("be.visible");
  cy.getCy("clinical-dashboard-performance-metrics").should("be.visible");
  cy.getCy("clinical-dashboard-audit-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [49/76 | 64%] - Saving screenshot for ClinicalDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [49/76 | 64%] - Verified ClinicalDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [50/76 | 65%] - Navigating to /offices/clinical/roles/clinical_director/reports (ClinicalDirectorReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [50/76 | 65%] - Checking shell & content for ClinicalDirectorReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorreports-screen").should("be.visible");
  cy.getCy("clinicaldirectorreports-title").should("be.visible");
  cy.getCy("clinicaldirectorreports-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [50/76 | 65%] - Saving screenshot for ClinicalDirectorReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [50/76 | 65%] - Verified ClinicalDirectorReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/76 | 67%] - Navigating to /offices/clinical/roles/clinical_director/approvals (ClinicalDirectorApprovalsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/approvals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/76 | 67%] - Checking shell & content for ClinicalDirectorApprovalsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorapprovals-screen").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-title").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-content").should("be.visible");
  cy.getCy("clinical-director-btn-approve-protocols").should("be.visible");
  cy.getCy("clinical-director-btn-conduct-audit").should("be.visible");
  cy.getCy("clinical-director-btn-view-reports").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/76 | 67%] - Saving screenshot for ClinicalDirectorApprovalsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_approvals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/76 | 67%] - Verified ClinicalDirectorApprovalsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [52/76 | 68%] - Navigating to /offices/clinical/roles/clinical_director/performance (ClinicalDirectorPerformanceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [52/76 | 68%] - Checking shell & content for ClinicalDirectorPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorperformance-screen").should("be.visible");
  cy.getCy("clinicaldirectorperformance-title").should("be.visible");
  cy.getCy("clinicaldirectorperformance-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [52/76 | 68%] - Saving screenshot for ClinicalDirectorPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_performance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [52/76 | 68%] - Verified ClinicalDirectorPerformanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [53/76 | 69%] - Navigating to /executive/hr-director-hiring-pipeline (HrDirectorHiringPipelineScreen)...");
  cy.visitWithSemantics("/executive/hr-director-hiring-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [53/76 | 69%] - Checking shell & content for HrDirectorHiringPipelineScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorhiringpipeline-screen").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-title").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-report").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");
  cy.getCy("hrdashboard-btn-refresh-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [53/76 | 69%] - Saving screenshot for HrDirectorHiringPipelineScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_hiring_pipeline");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [53/76 | 69%] - Verified HrDirectorHiringPipelineScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [54/76 | 71%] - Navigating to /executive/hr-director-staff-files (HrDirectorStaffFilesScreen)...");
  cy.visitWithSemantics("/executive/hr-director-staff-files");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [54/76 | 71%] - Checking shell & content for HrDirectorStaffFilesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorstafffiles-screen").should("be.visible");
  cy.getCy("hrdirectorstafffiles-title").should("be.visible");
  cy.getCy("hrdirectorstafffiles-content").should("be.visible");
  cy.getCy("hr-dashboard-tasklist").should("be.visible");
  cy.getCy("hr-dashboard-kpi").should("be.visible");
  cy.getCy("hr-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [54/76 | 71%] - Saving screenshot for HrDirectorStaffFilesScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_staff_files");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [54/76 | 71%] - Verified HrDirectorStaffFilesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [55/76 | 72%] - Navigating to /executive/hr-director-training (HrDirectorTrainingScreen)...");
  cy.visitWithSemantics("/executive/hr-director-training");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [55/76 | 72%] - Checking shell & content for HrDirectorTrainingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectortraining-screen").should("be.visible");
  cy.getCy("hrdirectortraining-title").should("be.visible");
  cy.getCy("hrdirectortraining-content").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [55/76 | 72%] - Saving screenshot for HrDirectorTrainingScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_training");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [55/76 | 72%] - Verified HrDirectorTrainingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [56/76 | 73%] - Navigating to /executive/hr-director-credential-expiry (HrDirectorCredentialExpiryScreen)...");
  cy.visitWithSemantics("/executive/hr-director-credential-expiry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [56/76 | 73%] - Checking shell & content for HrDirectorCredentialExpiryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcredentialexpiry-screen").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-title").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [56/76 | 73%] - Saving screenshot for HrDirectorCredentialExpiryScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_credential_expiry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [56/76 | 73%] - Verified HrDirectorCredentialExpiryScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [57/76 | 75%] - Navigating to /executive/hr-director-onboarding (HrDirectorOnboardingScreen)...");
  cy.visitWithSemantics("/executive/hr-director-onboarding");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [57/76 | 75%] - Checking shell & content for HrDirectorOnboardingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoronboarding-screen").should("be.visible");
  cy.getCy("hrdirectoronboarding-title").should("be.visible");
  cy.getCy("hrdirectoronboarding-content").should("be.visible");
  cy.getCy("hrdirector-btn-add-task").should("be.visible");
  cy.getCy("hrdirector-btn-generate-report").should("be.visible");
  cy.getCy("hrdirector-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [57/76 | 75%] - Saving screenshot for HrDirectorOnboardingScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_onboarding");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [57/76 | 75%] - Verified HrDirectorOnboardingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [58/76 | 76%] - Navigating to /executive/system-health (SystemHealthScreen)...");
  cy.visitWithSemantics("/executive/system-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [58/76 | 76%] - Checking shell & content for SystemHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemhealth-screen").should("be.visible");
  cy.getCy("systemhealth-title").should("be.visible");
  cy.getCy("systemhealth-content").should("be.visible");
  cy.getCy("ctodashboard-btn-refresh").should("be.visible");
  cy.getCy("ctodashboard-btn-view-report").should("be.visible");
  cy.getCy("ctodashboard-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [58/76 | 76%] - Saving screenshot for SystemHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("system_health");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [58/76 | 76%] - Verified SystemHealthScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/76 | 77%] - Navigating to /executive/api-monitoring (ApiMonitoringScreen)...");
  cy.visitWithSemantics("/executive/api-monitoring");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/76 | 77%] - Checking shell & content for ApiMonitoringScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apimonitoring-screen").should("be.visible");
  cy.getCy("apimonitoring-title").should("be.visible");
  cy.getCy("apimonitoring-content").should("be.visible");
  cy.getCy("ctodashboard-btn-refresh").should("be.visible");
  cy.getCy("ctodashboard-btn-export").should("be.visible");
  cy.getCy("ctodashboard-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/76 | 77%] - Saving screenshot for ApiMonitoringScreen...");
  cy.waitAndSee();
  cy.screenshot("api_monitoring");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/76 | 77%] - Verified ApiMonitoringScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [60/76 | 78%] - Navigating to /executive/deployment-center (DeploymentCenterScreen)...");
  cy.visitWithSemantics("/executive/deployment-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [60/76 | 78%] - Checking shell & content for DeploymentCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("deploymentcenter-screen").should("be.visible");
  cy.getCy("deploymentcenter-title").should("be.visible");
  cy.getCy("deploymentcenter-content").should("be.visible");
  cy.getCy("ctodashboard-kpi").should("be.visible");
  cy.getCy("ctodashboard-performance").should("be.visible");
  cy.getCy("ctodashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [60/76 | 78%] - Saving screenshot for DeploymentCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("deployment_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [60/76 | 78%] - Verified DeploymentCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [61/76 | 80%] - Navigating to /executive/security-audit (SecurityAuditScreen)...");
  cy.visitWithSemantics("/executive/security-audit");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [61/76 | 80%] - Checking shell & content for SecurityAuditScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securityaudit-screen").should("be.visible");
  cy.getCy("securityaudit-title").should("be.visible");
  cy.getCy("securityaudit-content").should("be.visible");
  cy.getCy("ctodashboard-btn-refresh").should("be.visible");
  cy.getCy("ctodashboard-btn-view-report").should("be.visible");
  cy.getCy("ctodashboard-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [61/76 | 80%] - Saving screenshot for SecurityAuditScreen...");
  cy.waitAndSee();
  cy.screenshot("security_audit");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [61/76 | 80%] - Verified SecurityAuditScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [62/76 | 81%] - Navigating to /executive/release-management (ReleaseManagementScreen)...");
  cy.visitWithSemantics("/executive/release-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [62/76 | 81%] - Checking shell & content for ReleaseManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releasemanagement-screen").should("be.visible");
  cy.getCy("releasemanagement-title").should("be.visible");
  cy.getCy("releasemanagement-content").should("be.visible");
  cy.getCy("ctodashboard-btn-refresh").should("be.visible");
  cy.getCy("ctodashboard-btn-view-report").should("be.visible");
  cy.getCy("ctodashboard-btn-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [62/76 | 81%] - Saving screenshot for ReleaseManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("release_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [62/76 | 81%] - Verified ReleaseManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [63/76 | 82%] - Navigating to /management/hiring-pipeline (HiringPipelineScreen)...");
  cy.visitWithSemantics("/management/hiring-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [63/76 | 82%] - Checking shell & content for HiringPipelineScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hiringpipeline-screen").should("be.visible");
  cy.getCy("hiringpipeline-title").should("be.visible");
  cy.getCy("hiringpipeline-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-report").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");
  cy.getCy("hrdashboard-btn-initiate-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [63/76 | 82%] - Saving screenshot for HiringPipelineScreen...");
  cy.waitAndSee();
  cy.screenshot("hiring_pipeline");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [63/76 | 82%] - Verified HiringPipelineScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [64/76 | 84%] - Navigating to /management/employee-records (EmployeeRecordsScreen)...");
  cy.visitWithSemantics("/management/employee-records");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [64/76 | 84%] - Checking shell & content for EmployeeRecordsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeerecords-screen").should("be.visible");
  cy.getCy("employeerecords-title").should("be.visible");
  cy.getCy("employeerecords-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [64/76 | 84%] - Saving screenshot for EmployeeRecordsScreen...");
  cy.waitAndSee();
  cy.screenshot("employee_records");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [64/76 | 84%] - Verified EmployeeRecordsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [65/76 | 85%] - Navigating to /management/credential-expiry (CredentialExpiryScreen)...");
  cy.visitWithSemantics("/management/credential-expiry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [65/76 | 85%] - Checking shell & content for CredentialExpiryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credentialexpiry-screen").should("be.visible");
  cy.getCy("credentialexpiry-title").should("be.visible");
  cy.getCy("credentialexpiry-content").should("be.visible");
  cy.getCy("hrdashboard-btn-refresh").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [65/76 | 85%] - Saving screenshot for CredentialExpiryScreen...");
  cy.waitAndSee();
  cy.screenshot("credential_expiry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [65/76 | 85%] - Verified CredentialExpiryScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [66/76 | 86%] - Navigating to /management/training-management (TrainingManagementScreen)...");
  cy.visitWithSemantics("/management/training-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [66/76 | 86%] - Checking shell & content for TrainingManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingmanagement-screen").should("be.visible");
  cy.getCy("trainingmanagement-title").should("be.visible");
  cy.getCy("trainingmanagement-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [66/76 | 86%] - Saving screenshot for TrainingManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("training_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [66/76 | 86%] - Verified TrainingManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [67/76 | 88%] - Navigating to /management/onboarding (OnboardingScreen)...");
  cy.visitWithSemantics("/management/onboarding");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [67/76 | 88%] - Checking shell & content for OnboardingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboarding-screen").should("be.visible");
  cy.getCy("onboarding-title").should("be.visible");
  cy.getCy("onboarding-content").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");
  cy.getCy("hrdashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [67/76 | 88%] - Saving screenshot for OnboardingScreen...");
  cy.waitAndSee();
  cy.screenshot("onboarding");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [67/76 | 88%] - Verified OnboardingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [68/76 | 89%] - Navigating to /offices/clinical/roles/chiropractor/chiropractic-assessment (ChiropracticAssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [68/76 | 89%] - Checking shell & content for ChiropracticAssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticassessment-screen").should("be.visible");
  cy.getCy("chiropracticassessment-title").should("be.visible");
  cy.getCy("chiropracticassessment-content").should("be.visible");
  cy.getCy("chiropractic-assessment-save").should("be.visible");
  cy.getCy("chiropractic-treatment-update").should("be.visible");
  cy.getCy("chiropractic-adjustment-record").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [68/76 | 89%] - Saving screenshot for ChiropracticAssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractic_assessment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [68/76 | 89%] - Verified ChiropracticAssessmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [69/76 | 90%] - Navigating to /offices/clinical/roles/chiropractor/adjustment-notes (AdjustmentNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/adjustment-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [69/76 | 90%] - Checking shell & content for AdjustmentNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adjustmentnotes-screen").should("be.visible");
  cy.getCy("adjustmentnotes-title").should("be.visible");
  cy.getCy("adjustmentnotes-content").should("be.visible");
  cy.getCy("dashboard-btn-view-records").should("be.visible");
  cy.getCy("dashboard-btn-generate-report").should("be.visible");
  cy.getCy("dashboard-btn-update-treatment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [69/76 | 90%] - Saving screenshot for AdjustmentNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("adjustment_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [69/76 | 90%] - Verified AdjustmentNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [70/76 | 92%] - Navigating to /offices/clinical/roles/chiropractor/xray-review (XrayReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/xray-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [70/76 | 92%] - Checking shell & content for XrayReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("xrayreview-screen").should("be.visible");
  cy.getCy("xrayreview-title").should("be.visible");
  cy.getCy("xrayreview-content").should("be.visible");
  cy.getCy("xrayreview-btn-save").should("be.visible");
  cy.getCy("xrayreview-btn-review").should("be.visible");
  cy.getCy("xrayreview-btn-logprogress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [70/76 | 92%] - Saving screenshot for XrayReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("xray_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [70/76 | 92%] - Verified XrayReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [71/76 | 93%] - Navigating to /offices/clinical/roles/chiropractor/chiropractic-progress-tracking (ChiropracticProgressTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/chiropractic-progress-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [71/76 | 93%] - Checking shell & content for ChiropracticProgressTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
  cy.getCy("chiropracticprogresstracking-title").should("be.visible");
  cy.getCy("chiropracticprogresstracking-content").should("be.visible");
  cy.getCy("chiropractic-btn-save-assessment").should("be.visible");
  cy.getCy("chiropractic-btn-update-treatment").should("be.visible");
  cy.getCy("chiropractic-btn-record-progress").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [71/76 | 93%] - Saving screenshot for ChiropracticProgressTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractic_progress_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [71/76 | 93%] - Verified ChiropracticProgressTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [72/76 | 94%] - Navigating to /offices/clinical/roles/clinical_director/quality (ClinicalQualityScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [72/76 | 94%] - Checking shell & content for ClinicalQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalquality-screen").should("be.visible");
  cy.getCy("clinicalquality-title").should("be.visible");
  cy.getCy("clinicalquality-content").should("be.visible");
  cy.getCy("clinical-dashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("clinical-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("clinical-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [72/76 | 94%] - Saving screenshot for ClinicalQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_quality");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [72/76 | 94%] - Verified ClinicalQualityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [73/76 | 96%] - Navigating to /offices/clinical/roles/clinical_director/staff-performance (StaffPerformanceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [73/76 | 96%] - Checking shell & content for StaffPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffperformance-screen").should("be.visible");
  cy.getCy("staffperformance-title").should("be.visible");
  cy.getCy("staffperformance-content").should("be.visible");
  cy.getCy("staffperformance-kpi-widget").should("be.visible");
  cy.getCy("staffperformance-compliance-card").should("be.visible");
  cy.getCy("staffperformance-satisfaction-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [73/76 | 96%] - Saving screenshot for StaffPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_performance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [73/76 | 96%] - Verified StaffPerformanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [74/76 | 97%] - Navigating to /offices/clinical/roles/clinical_director/compliance-review (ComplianceReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [74/76 | 97%] - Checking shell & content for ComplianceReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereview-screen").should("be.visible");
  cy.getCy("compliancereview-title").should("be.visible");
  cy.getCy("compliancereview-content").should("be.visible");
  cy.getCy("compliance-status-card").should("be.visible");
  cy.getCy("audit-results-chart").should("be.visible");
  cy.getCy("kpi-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [74/76 | 97%] - Saving screenshot for ComplianceReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [74/76 | 97%] - Verified ComplianceReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [75/76 | 98%] - Navigating to /offices/clinical/roles/clinical_director/incident-oversight (IncidentOversightScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-oversight");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [75/76 | 98%] - Checking shell & content for IncidentOversightScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentoversight-screen").should("be.visible");
  cy.getCy("incidentoversight-title").should("be.visible");
  cy.getCy("incidentoversight-content").should("be.visible");
  cy.getCy("incident-report-widget").should("be.visible");
  cy.getCy("compliance-scan-results-widget").should("be.visible");
  cy.getCy("kpi-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [75/76 | 98%] - Saving screenshot for IncidentOversightScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_oversight");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [75/76 | 98%] - Verified IncidentOversightScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [76/76 | 100%] - Navigating to /offices/clinical/roles/clinical_director/operations4k (ClinicalOperations4KScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/operations4k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [76/76 | 100%] - Checking shell & content for ClinicalOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaloperations4k-screen").should("be.visible");
  cy.getCy("clinicaloperations4k-title").should("be.visible");
  cy.getCy("clinicaloperations4k-content").should("be.visible");
  cy.getCy("clinical-dashboard-compliance-status").should("be.visible");
  cy.getCy("clinical-dashboard-performance-metrics").should("be.visible");
  cy.getCy("clinical-dashboard-staff-engagement").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [76/76 | 100%] - Saving screenshot for ClinicalOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [76/76 | 100%] - Verified ClinicalOperations4KScreen successfully!\n");
  });

  it("tests org role cx_director", () => {
    cy.loginAsRole("cx_director");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/corporate/roles/cx_director/dashboard (CxDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cx_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for CxDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");
  cy.getCy("cxdashboard-widget-customer-satisfaction").should("be.visible");
  cy.getCy("cxdashboard-widget-feedback-trends").should("be.visible");
  cy.getCy("cxdashboard-widget-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for CxDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified CxDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /executive/cx-director-analytics (CxDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/cx-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for CxDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectoranalytics-screen").should("be.visible");
  cy.getCy("cxdirectoranalytics-title").should("be.visible");
  cy.getCy("cxdirectoranalytics-content").should("be.visible");
  cy.getCy("cxdashboard-btn-refresh").should("be.visible");
  cy.getCy("cxdashboard-btn-export").should("be.visible");
  cy.getCy("cxdashboard-btn-viewdetails").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for CxDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified CxDirectorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /executive/cx-director-compliance (CxDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/cx-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for CxDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorcompliance-screen").should("be.visible");
  cy.getCy("cxdirectorcompliance-title").should("be.visible");
  cy.getCy("cxdirectorcompliance-content").should("be.visible");
  cy.getCy("cxdirector-btn-generate-report").should("be.visible");
  cy.getCy("cxdirector-btn-initiate-audit").should("be.visible");
  cy.getCy("cxdirector-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for CxDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified CxDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /executive/cx-director-workflow (CxDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/cx-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for CxDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorworkflow-screen").should("be.visible");
  cy.getCy("cxdirectorworkflow-title").should("be.visible");
  cy.getCy("cxdirectorworkflow-content").should("be.visible");
  cy.getCy("cxdashboard-btn-generate-report").should("be.visible");
  cy.getCy("cxdashboard-btn-view-details").should("be.visible");
  cy.getCy("cxdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for CxDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified CxDirectorWorkflowScreen successfully!\n");
  });

  it("tests org role finance_director", () => {
    cy.loginAsRole("finance_director");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/corporate/roles/finance_director/dashboard (FinanceDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/finance_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for FinanceDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectordashboard-screen").should("be.visible");
  cy.getCy("financedirectordashboard-title").should("be.visible");
  cy.getCy("financedirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for FinanceDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified FinanceDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /executive/finance-director-analytics (FinanceDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/finance-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for FinanceDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectoranalytics-screen").should("be.visible");
  cy.getCy("financedirectoranalytics-title").should("be.visible");
  cy.getCy("financedirectoranalytics-content").should("be.visible");
  cy.getCy("finance-kpi-widget").should("be.visible");
  cy.getCy("finance-cashflow-monitor").should("be.visible");
  cy.getCy("finance-budget-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for FinanceDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified FinanceDirectorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /executive/finance-director-compliance (FinanceDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/finance-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for FinanceDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorcompliance-screen").should("be.visible");
  cy.getCy("financedirectorcompliance-title").should("be.visible");
  cy.getCy("financedirectorcompliance-content").should("be.visible");
  cy.getCy("finance-kpi-widget").should("be.visible");
  cy.getCy("finance-cashflow-chart").should("be.visible");
  cy.getCy("finance-budget-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for FinanceDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified FinanceDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /executive/finance-director-workflow (FinanceDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/finance-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for FinanceDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorworkflow-screen").should("be.visible");
  cy.getCy("financedirectorworkflow-title").should("be.visible");
  cy.getCy("financedirectorworkflow-content").should("be.visible");
  cy.getCy("finance-kpi-widget").should("be.visible");
  cy.getCy("finance-cashflow-monitor").should("be.visible");
  cy.getCy("finance-budget-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for FinanceDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified FinanceDirectorWorkflowScreen successfully!\n");
  });

  it("tests org role hr_director", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Navigating to /offices/corporate/roles/hr_director/dashboard (HrDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Checking shell & content for HrDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectordashboard-screen").should("be.visible");
  cy.getCy("hrdirectordashboard-title").should("be.visible");
  cy.getCy("hrdirectordashboard-content").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-feedback").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Saving screenshot for HrDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Verified HrDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Navigating to /offices/corporate/roles/hr_manager/dashboard (HrManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Checking shell & content for HrManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerdashboard-screen").should("be.visible");
  cy.getCy("hrmanagerdashboard-title").should("be.visible");
  cy.getCy("hrmanagerdashboard-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-reports").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");
  cy.getCy("hrdashboard-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Saving screenshot for HrManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Verified HrManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Navigating to /executive/hr-director-analytics (HrDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/hr-director-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Checking shell & content for HrDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoranalytics-screen").should("be.visible");
  cy.getCy("hrdirectoranalytics-title").should("be.visible");
  cy.getCy("hrdirectoranalytics-content").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Saving screenshot for HrDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Verified HrDirectorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Navigating to /executive/hr-director-compliance (HrDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/hr-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Checking shell & content for HrDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcompliance-screen").should("be.visible");
  cy.getCy("hrdirectorcompliance-title").should("be.visible");
  cy.getCy("hrdirectorcompliance-content").should("be.visible");
  cy.getCy("hrdirector-btn-generate-report").should("be.visible");
  cy.getCy("hrdirector-btn-view-audit").should("be.visible");
  cy.getCy("hrdirector-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Saving screenshot for HrDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Verified HrDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Navigating to /executive/hr-director-workflow (HrDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/hr-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Checking shell & content for HrDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorworkflow-screen").should("be.visible");
  cy.getCy("hrdirectorworkflow-title").should("be.visible");
  cy.getCy("hrdirectorworkflow-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-reports").should("be.visible");
  cy.getCy("hrdashboard-btn-manage-policies").should("be.visible");
  cy.getCy("hrdashboard-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Saving screenshot for HrDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Verified HrDirectorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Navigating to /staff/hr-manager-analytics (HrManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Checking shell & content for HrManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanageranalytics-screen").should("be.visible");
  cy.getCy("hrmanageranalytics-title").should("be.visible");
  cy.getCy("hrmanageranalytics-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Saving screenshot for HrManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Verified HrManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Navigating to /staff/hr-manager-compliance (HrManagerComplianceScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Checking shell & content for HrManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagercompliance-screen").should("be.visible");
  cy.getCy("hrmanagercompliance-title").should("be.visible");
  cy.getCy("hrmanagercompliance-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Saving screenshot for HrManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Verified HrManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Navigating to /staff/hr-manager-workflow (HrManagerWorkflowScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Checking shell & content for HrManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerworkflow-screen").should("be.visible");
  cy.getCy("hrmanagerworkflow-title").should("be.visible");
  cy.getCy("hrmanagerworkflow-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-reports").should("be.visible");
  cy.getCy("hr-dashboard-btn-manage-policies").should("be.visible");
  cy.getCy("hr-dashboard-btn-initiate-recruitment").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Saving screenshot for HrManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Verified HrManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Navigating to /executive/hr-director-hiring-pipeline (HrDirectorHiringPipelineScreen)...");
  cy.visitWithSemantics("/executive/hr-director-hiring-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Checking shell & content for HrDirectorHiringPipelineScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorhiringpipeline-screen").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-title").should("be.visible");
  cy.getCy("hrdirectorhiringpipeline-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-report").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");
  cy.getCy("hrdashboard-btn-refresh-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Saving screenshot for HrDirectorHiringPipelineScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_hiring_pipeline");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Verified HrDirectorHiringPipelineScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Navigating to /executive/hr-director-staff-files (HrDirectorStaffFilesScreen)...");
  cy.visitWithSemantics("/executive/hr-director-staff-files");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Checking shell & content for HrDirectorStaffFilesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorstafffiles-screen").should("be.visible");
  cy.getCy("hrdirectorstafffiles-title").should("be.visible");
  cy.getCy("hrdirectorstafffiles-content").should("be.visible");
  cy.getCy("hr-dashboard-tasklist").should("be.visible");
  cy.getCy("hr-dashboard-kpi").should("be.visible");
  cy.getCy("hr-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Saving screenshot for HrDirectorStaffFilesScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_staff_files");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Verified HrDirectorStaffFilesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Navigating to /executive/hr-director-training (HrDirectorTrainingScreen)...");
  cy.visitWithSemantics("/executive/hr-director-training");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Checking shell & content for HrDirectorTrainingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectortraining-screen").should("be.visible");
  cy.getCy("hrdirectortraining-title").should("be.visible");
  cy.getCy("hrdirectortraining-content").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Saving screenshot for HrDirectorTrainingScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_training");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Verified HrDirectorTrainingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Navigating to /executive/hr-director-credential-expiry (HrDirectorCredentialExpiryScreen)...");
  cy.visitWithSemantics("/executive/hr-director-credential-expiry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Checking shell & content for HrDirectorCredentialExpiryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcredentialexpiry-screen").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-title").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Saving screenshot for HrDirectorCredentialExpiryScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_credential_expiry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Verified HrDirectorCredentialExpiryScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Navigating to /executive/hr-director-onboarding (HrDirectorOnboardingScreen)...");
  cy.visitWithSemantics("/executive/hr-director-onboarding");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Checking shell & content for HrDirectorOnboardingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectoronboarding-screen").should("be.visible");
  cy.getCy("hrdirectoronboarding-title").should("be.visible");
  cy.getCy("hrdirectoronboarding-content").should("be.visible");
  cy.getCy("hrdirector-btn-add-task").should("be.visible");
  cy.getCy("hrdirector-btn-generate-report").should("be.visible");
  cy.getCy("hrdirector-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Saving screenshot for HrDirectorOnboardingScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_onboarding");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Verified HrDirectorOnboardingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Navigating to /management/hiring-pipeline (HiringPipelineScreen)...");
  cy.visitWithSemantics("/management/hiring-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Checking shell & content for HiringPipelineScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hiringpipeline-screen").should("be.visible");
  cy.getCy("hiringpipeline-title").should("be.visible");
  cy.getCy("hiringpipeline-content").should("be.visible");
  cy.getCy("hrdashboard-btn-view-report").should("be.visible");
  cy.getCy("hrdashboard-btn-export-data").should("be.visible");
  cy.getCy("hrdashboard-btn-initiate-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Saving screenshot for HiringPipelineScreen...");
  cy.waitAndSee();
  cy.screenshot("hiring_pipeline");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Verified HiringPipelineScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Navigating to /management/employee-records (EmployeeRecordsScreen)...");
  cy.visitWithSemantics("/management/employee-records");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Checking shell & content for EmployeeRecordsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeerecords-screen").should("be.visible");
  cy.getCy("employeerecords-title").should("be.visible");
  cy.getCy("employeerecords-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Saving screenshot for EmployeeRecordsScreen...");
  cy.waitAndSee();
  cy.screenshot("employee_records");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Verified EmployeeRecordsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Navigating to /management/credential-expiry (CredentialExpiryScreen)...");
  cy.visitWithSemantics("/management/credential-expiry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Checking shell & content for CredentialExpiryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credentialexpiry-screen").should("be.visible");
  cy.getCy("credentialexpiry-title").should("be.visible");
  cy.getCy("credentialexpiry-content").should("be.visible");
  cy.getCy("hrdashboard-btn-refresh").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Saving screenshot for CredentialExpiryScreen...");
  cy.waitAndSee();
  cy.screenshot("credential_expiry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Verified CredentialExpiryScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Navigating to /management/training-management (TrainingManagementScreen)...");
  cy.visitWithSemantics("/management/training-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Checking shell & content for TrainingManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingmanagement-screen").should("be.visible");
  cy.getCy("trainingmanagement-title").should("be.visible");
  cy.getCy("trainingmanagement-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Saving screenshot for TrainingManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("training_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Verified TrainingManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Navigating to /management/onboarding (OnboardingScreen)...");
  cy.visitWithSemantics("/management/onboarding");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Checking shell & content for OnboardingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboarding-screen").should("be.visible");
  cy.getCy("onboarding-title").should("be.visible");
  cy.getCy("onboarding-content").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");
  cy.getCy("hrdashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Saving screenshot for OnboardingScreen...");
  cy.waitAndSee();
  cy.screenshot("onboarding");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Verified OnboardingScreen successfully!\n");
  });

  it("tests org role legal", () => {
    cy.loginAsRole("legal");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/corporate/roles/legal/dashboard (LegalDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/legal/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for LegalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legaldashboard-screen").should("be.visible");
  cy.getCy("legaldashboard-title").should("be.visible");
  cy.getCy("legaldashboard-content").should("be.visible");
  cy.getCy("legal-dashboard-compliance-status").should("be.visible");
  cy.getCy("legal-dashboard-dispute-status").should("be.visible");
  cy.getCy("legal-dashboard-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for LegalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified LegalDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /executive/legal-analytics (LegalAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/legal-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for LegalAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalanalytics-screen").should("be.visible");
  cy.getCy("legalanalytics-title").should("be.visible");
  cy.getCy("legalanalytics-content").should("be.visible");
  cy.getCy("legal-dashboard-kpi-chart").should("be.visible");
  cy.getCy("legal-dashboard-litigation-status").should("be.visible");
  cy.getCy("legal-dashboard-compliance-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for LegalAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified LegalAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /executive/legal-compliance (LegalComplianceScreen)...");
  cy.visitWithSemantics("/executive/legal-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for LegalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalcompliance-screen").should("be.visible");
  cy.getCy("legalcompliance-title").should("be.visible");
  cy.getCy("legalcompliance-content").should("be.visible");
  cy.getCy("legalcompliance-btn-update").should("be.visible");
  cy.getCy("legalcompliance-btn-train").should("be.visible");
  cy.getCy("legalcompliance-btn-review").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for LegalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified LegalComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /executive/legal-workflow (LegalWorkflowScreen)...");
  cy.visitWithSemantics("/executive/legal-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for LegalWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalworkflow-screen").should("be.visible");
  cy.getCy("legalworkflow-title").should("be.visible");
  cy.getCy("legalworkflow-content").should("be.visible");
  cy.getCy("legalworkflow-btn-addtask").should("be.visible");
  cy.getCy("legalworkflow-btn-reviewdocument").should("be.visible");
  cy.getCy("legalworkflow-btn-providelegaladvice").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for LegalWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified LegalWorkflowScreen successfully!\n");
  });

  it("tests org role owner", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/25 | 4%] - Navigating to /common/franchise-dashboard (FranchiseDashboardScreen)...");
  cy.visitWithSemantics("/common/franchise-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/25 | 4%] - Checking shell & content for FranchiseDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisedashboard-screen").should("be.visible");
  cy.getCy("franchisedashboard-title").should("be.visible");
  cy.getCy("franchisedashboard-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-export-logs").should("be.visible");
  cy.getCy("franchise-dashboard-btn-review-audit").should("be.visible");
  cy.getCy("franchise-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/25 | 4%] - Saving screenshot for FranchiseDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/25 | 4%] - Verified FranchiseDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/25 | 8%] - Navigating to /offices/corporate/roles/owner/dashboard (OwnerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/owner/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/25 | 8%] - Checking shell & content for OwnerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerdashboard-screen").should("be.visible");
  cy.getCy("ownerdashboard-title").should("be.visible");
  cy.getCy("ownerdashboard-content").should("be.visible");
  cy.getCy("owner-dashboard-btn-refresh").should("be.visible");
  cy.getCy("owner-dashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("owner-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/25 | 8%] - Saving screenshot for OwnerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/25 | 8%] - Verified OwnerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/25 | 12%] - Navigating to /common/franchise-analytics (FranchiseAnalyticsScreen)...");
  cy.visitWithSemantics("/common/franchise-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/25 | 12%] - Checking shell & content for FranchiseAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseanalytics-screen").should("be.visible");
  cy.getCy("franchiseanalytics-title").should("be.visible");
  cy.getCy("franchiseanalytics-content").should("be.visible");
  cy.getCy("franchise-analytics-kpi").should("be.visible");
  cy.getCy("franchise-analytics-sales-trend").should("be.visible");
  cy.getCy("franchise-analytics-satisfaction").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/25 | 12%] - Saving screenshot for FranchiseAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/25 | 12%] - Verified FranchiseAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/25 | 16%] - Navigating to /common/franchise-compliance (FranchiseComplianceScreen)...");
  cy.visitWithSemantics("/common/franchise-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/25 | 16%] - Checking shell & content for FranchiseComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecompliance-screen").should("be.visible");
  cy.getCy("franchisecompliance-title").should("be.visible");
  cy.getCy("franchisecompliance-content").should("be.visible");
  cy.getCy("franchise-compliance-status-indicator").should("be.visible");
  cy.getCy("franchise-audit-log-viewer").should("be.visible");
  cy.getCy("franchise-compliance-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/25 | 16%] - Saving screenshot for FranchiseComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/25 | 16%] - Verified FranchiseComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/25 | 20%] - Navigating to /common/franchise-workflow (FranchiseWorkflowScreen)...");
  cy.visitWithSemantics("/common/franchise-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/25 | 20%] - Checking shell & content for FranchiseWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseworkflow-screen").should("be.visible");
  cy.getCy("franchiseworkflow-title").should("be.visible");
  cy.getCy("franchiseworkflow-content").should("be.visible");
  cy.getCy("franchise-dashboard-sales").should("be.visible");
  cy.getCy("franchise-dashboard-employees").should("be.visible");
  cy.getCy("franchise-dashboard-customers").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/25 | 20%] - Saving screenshot for FranchiseWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/25 | 20%] - Verified FranchiseWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/25 | 24%] - Navigating to /executive/owner-analytics (OwnerAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/owner-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/25 | 24%] - Checking shell & content for OwnerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("owneranalytics-screen").should("be.visible");
  cy.getCy("owneranalytics-title").should("be.visible");
  cy.getCy("owneranalytics-content").should("be.visible");
  cy.getCy("owneranalytics-btn-view-reports").should("be.visible");
  cy.getCy("owneranalytics-btn-update-compliance").should("be.visible");
  cy.getCy("owneranalytics-btn-manage-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/25 | 24%] - Saving screenshot for OwnerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/25 | 24%] - Verified OwnerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/25 | 28%] - Navigating to /executive/owner-compliance (OwnerComplianceScreen)...");
  cy.visitWithSemantics("/executive/owner-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/25 | 28%] - Checking shell & content for OwnerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownercompliance-screen").should("be.visible");
  cy.getCy("ownercompliance-title").should("be.visible");
  cy.getCy("ownercompliance-content").should("be.visible");
  cy.getCy("owner-compliance-status").should("be.visible");
  cy.getCy("owner-audit-logs").should("be.visible");
  cy.getCy("owner-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/25 | 28%] - Saving screenshot for OwnerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [7/25 | 28%] - Verified OwnerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/25 | 32%] - Navigating to /executive/owner-workflow (OwnerWorkflowScreen)...");
  cy.visitWithSemantics("/executive/owner-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/25 | 32%] - Checking shell & content for OwnerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerworkflow-screen").should("be.visible");
  cy.getCy("ownerworkflow-title").should("be.visible");
  cy.getCy("ownerworkflow-content").should("be.visible");
  cy.getCy("franchise-dashboard-sales-report").should("be.visible");
  cy.getCy("franchise-dashboard-employee-report").should("be.visible");
  cy.getCy("franchise-dashboard-customer-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/25 | 32%] - Saving screenshot for OwnerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/25 | 32%] - Verified OwnerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/25 | 36%] - Navigating to /management/franchise-sales-manager-analytics (FranchiseSalesManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/25 | 36%] - Checking shell & content for FranchiseSalesManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanageranalytics-screen").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-title").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-content").should("be.visible");
  cy.getCy("franchise-sales-performance-chart").should("be.visible");
  cy.getCy("franchise-employee-turnover-stats").should("be.visible");
  cy.getCy("franchise-customer-satisfaction-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/25 | 36%] - Saving screenshot for FranchiseSalesManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [9/25 | 36%] - Verified FranchiseSalesManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/25 | 40%] - Navigating to /management/franchise-sales-manager-compliance (FranchiseSalesManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/25 | 40%] - Checking shell & content for FranchiseSalesManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagercompliance-screen").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-title").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-content").should("be.visible");
  cy.getCy("franchise-compliance-status").should("be.visible");
  cy.getCy("franchise-audit-logs").should("be.visible");
  cy.getCy("franchise-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/25 | 40%] - Saving screenshot for FranchiseSalesManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/25 | 40%] - Verified FranchiseSalesManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/25 | 44%] - Navigating to /management/franchise-sales-manager-workflow (FranchiseSalesManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/25 | 44%] - Checking shell & content for FranchiseSalesManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-title").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-content").should("be.visible");
  cy.getCy("franchise-sales-metrics").should("be.visible");
  cy.getCy("franchise-customer-feedback").should("be.visible");
  cy.getCy("franchise-employee-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/25 | 44%] - Saving screenshot for FranchiseSalesManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [11/25 | 44%] - Verified FranchiseSalesManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/25 | 48%] - Navigating to /executive/franchise-owner-command-center (FranchiseOwnerCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/25 | 48%] - Checking shell & content for FranchiseOwnerCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercommandcenter-screen").should("be.visible");
  cy.getCy("franchiseownercommandcenter-title").should("be.visible");
  cy.getCy("franchiseownercommandcenter-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-run-scan").should("be.visible");
  cy.getCy("franchise-dashboard-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/25 | 48%] - Saving screenshot for FranchiseOwnerCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [12/25 | 48%] - Verified FranchiseOwnerCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/25 | 52%] - Navigating to /offices/franchise/roles/franchise_owner/branch-overview (FranchiseOwnerBranchOverviewScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/branch-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/25 | 52%] - Checking shell & content for FranchiseOwnerBranchOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerbranchoverview-screen").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-title").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-content").should("be.visible");
  cy.getCy("franchise-owner-btn-trigger-scan").should("be.visible");
  cy.getCy("franchise-owner-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/25 | 52%] - Saving screenshot for FranchiseOwnerBranchOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_branch_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/25 | 52%] - Verified FranchiseOwnerBranchOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/25 | 56%] - Navigating to /offices/franchise/roles/franchise_owner/staff (FranchiseOwnerStaffScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/staff");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/25 | 56%] - Checking shell & content for FranchiseOwnerStaffScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerstaff-screen").should("be.visible");
  cy.getCy("franchiseownerstaff-title").should("be.visible");
  cy.getCy("franchiseownerstaff-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("franchise-dashboard-btn-refresh").should("be.visible");
  cy.getCy("franchise-dashboard-btn-manage-staff").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/25 | 56%] - Saving screenshot for FranchiseOwnerStaffScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_staff");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [14/25 | 56%] - Verified FranchiseOwnerStaffScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/25 | 60%] - Navigating to /offices/franchise/roles/franchise_owner/clients (FranchiseOwnerClientsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/clients");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/25 | 60%] - Checking shell & content for FranchiseOwnerClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerclients-screen").should("be.visible");
  cy.getCy("franchiseownerclients-title").should("be.visible");
  cy.getCy("franchiseownerclients-content").should("be.visible");
  cy.getCy("franchise-compliance-status").should("be.visible");
  cy.getCy("franchise-audit-results").should("be.visible");
  cy.getCy("franchise-kpi-tracking").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/25 | 60%] - Saving screenshot for FranchiseOwnerClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_clients");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/25 | 60%] - Verified FranchiseOwnerClientsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/25 | 64%] - Navigating to /offices/franchise/roles/franchise_owner/appointments (FranchiseOwnerAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/25 | 64%] - Checking shell & content for FranchiseOwnerAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerappointments-screen").should("be.visible");
  cy.getCy("franchiseownerappointments-title").should("be.visible");
  cy.getCy("franchiseownerappointments-content").should("be.visible");
  cy.getCy("franchise-appointments-scheduler").should("be.visible");
  cy.getCy("franchise-compliance-status").should("be.visible");
  cy.getCy("franchise-feedback-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/25 | 64%] - Saving screenshot for FranchiseOwnerAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_appointments");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [16/25 | 64%] - Verified FranchiseOwnerAppointmentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/25 | 68%] - Navigating to /executive/franchise-owner-finance-snapshot (FranchiseOwnerFinanceSnapshotScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-finance-snapshot");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/25 | 68%] - Checking shell & content for FranchiseOwnerFinanceSnapshotScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerfinancesnapshot-screen").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-title").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-content").should("be.visible");
  cy.getCy("franchise-finance-performance").should("be.visible");
  cy.getCy("franchise-compliance-status").should("be.visible");
  cy.getCy("franchise-operational-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/25 | 68%] - Saving screenshot for FranchiseOwnerFinanceSnapshotScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_finance_snapshot");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [17/25 | 68%] - Verified FranchiseOwnerFinanceSnapshotScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [18/25 | 72%] - Navigating to /offices/franchise/roles/franchise_owner/compliance (FranchiseOwnerComplianceScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [18/25 | 72%] - Checking shell & content for FranchiseOwnerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercompliance-screen").should("be.visible");
  cy.getCy("franchiseownercompliance-title").should("be.visible");
  cy.getCy("franchiseownercompliance-content").should("be.visible");
  cy.getCy("franchise-compliance-btn-execute-scan").should("be.visible");
  cy.getCy("franchise-compliance-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [18/25 | 72%] - Saving screenshot for FranchiseOwnerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [18/25 | 72%] - Verified FranchiseOwnerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/25 | 76%] - Navigating to /offices/franchise/roles/franchise_owner/reports (FranchiseOwnerReportsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/25 | 76%] - Checking shell & content for FranchiseOwnerReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerreports-screen").should("be.visible");
  cy.getCy("franchiseownerreports-title").should("be.visible");
  cy.getCy("franchiseownerreports-content").should("be.visible");
  cy.getCy("franchise-owner-btn-execute-scan").should("be.visible");
  cy.getCy("franchise-owner-btn-execute-audit").should("be.visible");
  cy.getCy("franchise-owner-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/25 | 76%] - Saving screenshot for FranchiseOwnerReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [19/25 | 76%] - Verified FranchiseOwnerReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [20/25 | 80%] - Navigating to /executive/franchise-command-center (FranchiseCommandCenterScreen)...");
  cy.visitWithSemantics("/executive/franchise-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [20/25 | 80%] - Checking shell & content for FranchiseCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter-screen").should("be.visible");
  cy.getCy("franchisecommandcenter-title").should("be.visible");
  cy.getCy("franchisecommandcenter-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("franchise-dashboard-btn-request-training").should("be.visible");
  cy.getCy("franchise-dashboard-btn-send-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [20/25 | 80%] - Saving screenshot for FranchiseCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [20/25 | 80%] - Verified FranchiseCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/25 | 84%] - Navigating to /executive/revenue-snapshot (RevenueSnapshotScreen)...");
  cy.visitWithSemantics("/executive/revenue-snapshot");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/25 | 84%] - Checking shell & content for RevenueSnapshotScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenuesnapshot-screen").should("be.visible");
  cy.getCy("revenuesnapshot-title").should("be.visible");
  cy.getCy("revenuesnapshot-content").should("be.visible");
  cy.getCy("revenue-metric-card").should("be.visible");
  cy.getCy("compliance-status-widget").should("be.visible");
  cy.getCy("operational-log-table").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/25 | 84%] - Saving screenshot for RevenueSnapshotScreen...");
  cy.waitAndSee();
  cy.screenshot("revenue_snapshot");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [21/25 | 84%] - Verified RevenueSnapshotScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/25 | 88%] - Navigating to /executive/staff-management (StaffManagementScreen)...");
  cy.visitWithSemantics("/executive/staff-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/25 | 88%] - Checking shell & content for StaffManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffmanagement-screen").should("be.visible");
  cy.getCy("staffmanagement-title").should("be.visible");
  cy.getCy("staffmanagement-content").should("be.visible");
  cy.getCy("franchise-kpi-dashboard").should("be.visible");
  cy.getCy("franchise-staff-performance").should("be.visible");
  cy.getCy("franchise-customer-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/25 | 88%] - Saving screenshot for StaffManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [22/25 | 88%] - Verified StaffManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [23/25 | 92%] - Navigating to /executive/appointment-overview (AppointmentOverviewScreen)...");
  cy.visitWithSemantics("/executive/appointment-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [23/25 | 92%] - Checking shell & content for AppointmentOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointmentoverview-screen").should("be.visible");
  cy.getCy("appointmentoverview-title").should("be.visible");
  cy.getCy("appointmentoverview-content").should("be.visible");
  cy.getCy("franchise-dashboard-sales").should("be.visible");
  cy.getCy("franchise-dashboard-employees").should("be.visible");
  cy.getCy("franchise-dashboard-customers").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [23/25 | 92%] - Saving screenshot for AppointmentOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("appointment_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [23/25 | 92%] - Verified AppointmentOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/25 | 96%] - Navigating to /executive/compliance-overview (ComplianceOverviewScreen)...");
  cy.visitWithSemantics("/executive/compliance-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/25 | 96%] - Checking shell & content for ComplianceOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("complianceoverview-screen").should("be.visible");
  cy.getCy("complianceoverview-title").should("be.visible");
  cy.getCy("complianceoverview-content").should("be.visible");
  cy.getCy("franchise-dashboard-sales").should("be.visible");
  cy.getCy("franchise-dashboard-customer-feedback").should("be.visible");
  cy.getCy("franchise-dashboard-inventory").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/25 | 96%] - Saving screenshot for ComplianceOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [24/25 | 96%] - Verified ComplianceOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [25/25 | 100%] - Navigating to /executive/franchise-command-center4-k (FranchiseCommandCenter4KScreen)...");
  cy.visitWithSemantics("/executive/franchise-command-center4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [25/25 | 100%] - Checking shell & content for FranchiseCommandCenter4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecommandcenter4k-screen").should("be.visible");
  cy.getCy("franchisecommandcenter4k-title").should("be.visible");
  cy.getCy("franchisecommandcenter4k-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("franchise-dashboard-btn-manage-training").should("be.visible");
  cy.getCy("franchise-dashboard-btn-review-financials").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [25/25 | 100%] - Saving screenshot for FranchiseCommandCenter4KScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_command_center4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [25/25 | 100%] - Verified FranchiseCommandCenter4KScreen successfully!\n");
  });

  it("tests org role shareholder", () => {
    cy.loginAsRole("shareholder");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/corporate/roles/shareholder/dashboard (ShareholderDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/shareholder/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for ShareholderDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderdashboard-screen").should("be.visible");
  cy.getCy("shareholderdashboard-title").should("be.visible");
  cy.getCy("shareholderdashboard-content").should("be.visible");
  cy.getCy("shareholder-btn-export-logs").should("be.visible");
  cy.getCy("shareholder-btn-trigger-action").should("be.visible");
  cy.getCy("shareholder-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for ShareholderDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("shareholder_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified ShareholderDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /executive/shareholder-analytics (ShareholderAnalyticsScreen)...");
  cy.visitWithSemantics("/executive/shareholder-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for ShareholderAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderanalytics-screen").should("be.visible");
  cy.getCy("shareholderanalytics-title").should("be.visible");
  cy.getCy("shareholderanalytics-content").should("be.visible");
  cy.getCy("shareholder-compliance-status").should("be.visible");
  cy.getCy("shareholder-performance-metrics").should("be.visible");
  cy.getCy("shareholder-operational-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for ShareholderAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("shareholder_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified ShareholderAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /executive/shareholder-compliance (ShareholderComplianceScreen)...");
  cy.visitWithSemantics("/executive/shareholder-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for ShareholderComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholdercompliance-screen").should("be.visible");
  cy.getCy("shareholdercompliance-title").should("be.visible");
  cy.getCy("shareholdercompliance-content").should("be.visible");
  cy.getCy("compliance-audit-btn-execute").should("be.visible");
  cy.getCy("governance-directives-btn-update").should("be.visible");
  cy.getCy("compliance-status-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for ShareholderComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("shareholder_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified ShareholderComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /executive/shareholder-workflow (ShareholderWorkflowScreen)...");
  cy.visitWithSemantics("/executive/shareholder-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for ShareholderWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderworkflow-screen").should("be.visible");
  cy.getCy("shareholderworkflow-title").should("be.visible");
  cy.getCy("shareholderworkflow-content").should("be.visible");
  cy.getCy("shareholder-dashboard-compliance-metric").should("be.visible");
  cy.getCy("shareholder-dashboard-log-viewer").should("be.visible");
  cy.getCy("shareholder-dashboard-workflow-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for ShareholderWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("shareholder_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified ShareholderWorkflowScreen successfully!\n");
  });

  it("tests org role training_director", () => {
    cy.loginAsRole("training_director");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Navigating to /common/course-architect-dashboard (CourseArchitectDashboardScreen)...");
  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Checking shell & content for CourseArchitectDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");
  cy.getCy("dashboard-participation-metric").should("be.visible");
  cy.getCy("dashboard-feedback-score").should("be.visible");
  cy.getCy("dashboard-effectiveness-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Saving screenshot for CourseArchitectDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Verified CourseArchitectDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Navigating to /offices/corporate/roles/training_director/dashboard (TrainingDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Checking shell & content for TrainingDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("training-dashboard-btn-adjust-program").should("be.visible");
  cy.getCy("training-dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Saving screenshot for TrainingDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Verified TrainingDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Navigating to /common/course-architect-analytics (CourseArchitectAnalyticsScreen)...");
  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Checking shell & content for CourseArchitectAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");
  cy.getCy("training-participation-metric").should("be.visible");
  cy.getCy("feedback-score-card").should("be.visible");
  cy.getCy("effectiveness-metric-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Saving screenshot for CourseArchitectAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Verified CourseArchitectAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Navigating to /common/course-architect-compliance (CourseArchitectComplianceScreen)...");
  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Checking shell & content for CourseArchitectComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");
  cy.getCy("trainingprogram-card").should("be.visible");
  cy.getCy("feedback-chart").should("be.visible");
  cy.getCy("compliance-status-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Saving screenshot for CourseArchitectComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Verified CourseArchitectComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Navigating to /common/course-architect-workflow (CourseArchitectWorkflowScreen)...");
  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Checking shell & content for CourseArchitectWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");
  cy.getCy("trainingprogram-card").should("be.visible");
  cy.getCy("feedbackscore-chart").should("be.visible");
  cy.getCy("completionrate-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Saving screenshot for CourseArchitectWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Verified CourseArchitectWorkflowScreen successfully!\n");
  });

  it("tests org role community_outreach", () => {
    cy.loginAsRole("community_outreach");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/marketing/roles/community_outreach/dashboard (CommunityOutreachDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/community_outreach/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for CommunityOutreachDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachdashboard-screen").should("be.visible");
  cy.getCy("communityoutreachdashboard-title").should("be.visible");
  cy.getCy("communityoutreachdashboard-content").should("be.visible");
  cy.getCy("community-outreach-btn-add-event").should("be.visible");
  cy.getCy("community-outreach-btn-collect-feedback").should("be.visible");
  cy.getCy("community-outreach-btn-view-reports").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for CommunityOutreachDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified CommunityOutreachDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/community-outreach-analytics (CommunityOutreachAnalyticsScreen)...");
  cy.visitWithSemantics("/management/community-outreach-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for CommunityOutreachAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachanalytics-screen").should("be.visible");
  cy.getCy("communityoutreachanalytics-title").should("be.visible");
  cy.getCy("communityoutreachanalytics-content").should("be.visible");
  cy.getCy("communityoutreach-kpi-chart").should("be.visible");
  cy.getCy("communityoutreach-engagement-metrics").should("be.visible");
  cy.getCy("communityoutreach-budget-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for CommunityOutreachAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified CommunityOutreachAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/community-outreach-compliance (CommunityOutreachComplianceScreen)...");
  cy.visitWithSemantics("/management/community-outreach-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for CommunityOutreachComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachcompliance-screen").should("be.visible");
  cy.getCy("communityoutreachcompliance-title").should("be.visible");
  cy.getCy("communityoutreachcompliance-content").should("be.visible");
  cy.getCy("outreach-btn-add-event").should("be.visible");
  cy.getCy("outreach-btn-submit-feedback").should("be.visible");
  cy.getCy("outreach-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for CommunityOutreachComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified CommunityOutreachComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/community-outreach-workflow (CommunityOutreachWorkflowScreen)...");
  cy.visitWithSemantics("/management/community-outreach-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for CommunityOutreachWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachworkflow-screen").should("be.visible");
  cy.getCy("communityoutreachworkflow-title").should("be.visible");
  cy.getCy("communityoutreachworkflow-content").should("be.visible");
  cy.getCy("community-outreach-btn-add-event").should("be.visible");
  cy.getCy("community-outreach-btn-submit-feedback").should("be.visible");
  cy.getCy("community-outreach-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for CommunityOutreachWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified CommunityOutreachWorkflowScreen successfully!\n");
  });

  it("tests org role compliance", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/9 | 11%] - Navigating to /offices/corporate/roles/compliance_manager/dashboard (ComplianceManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/9 | 11%] - Checking shell & content for ComplianceManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerdashboard-screen").should("be.visible");
  cy.getCy("compliancemanagerdashboard-title").should("be.visible");
  cy.getCy("compliancemanagerdashboard-content").should("be.visible");
  cy.getCy("compliance-dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("compliance-dashboard-btn-export-logs").should("be.visible");
  cy.getCy("compliance-dashboard-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/9 | 11%] - Saving screenshot for ComplianceManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/9 | 11%] - Verified ComplianceManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/9 | 22%] - Navigating to /management/compliance-manager-analytics (ComplianceManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/compliance-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/9 | 22%] - Checking shell & content for ComplianceManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanageranalytics-screen").should("be.visible");
  cy.getCy("compliancemanageranalytics-title").should("be.visible");
  cy.getCy("compliancemanageranalytics-content").should("be.visible");
  cy.getCy("compliance-violation-tracker").should("be.visible");
  cy.getCy("audit-results-overview").should("be.visible");
  cy.getCy("training-participation-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/9 | 22%] - Saving screenshot for ComplianceManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/9 | 22%] - Verified ComplianceManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/9 | 33%] - Navigating to /management/compliance-manager-compliance (ComplianceManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/compliance-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/9 | 33%] - Checking shell & content for ComplianceManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagercompliance-screen").should("be.visible");
  cy.getCy("compliancemanagercompliance-title").should("be.visible");
  cy.getCy("compliancemanagercompliance-content").should("be.visible");
  cy.getCy("compliance-dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("compliance-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/9 | 33%] - Saving screenshot for ComplianceManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/9 | 33%] - Verified ComplianceManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/9 | 44%] - Navigating to /management/compliance-manager-workflow (ComplianceManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/compliance-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/9 | 44%] - Checking shell & content for ComplianceManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerworkflow-screen").should("be.visible");
  cy.getCy("compliancemanagerworkflow-title").should("be.visible");
  cy.getCy("compliancemanagerworkflow-content").should("be.visible");
  cy.getCy("compliance-status-indicator").should("be.visible");
  cy.getCy("compliance-breach-counter").should("be.visible");
  cy.getCy("audit-results-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/9 | 44%] - Saving screenshot for ComplianceManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/9 | 44%] - Verified ComplianceManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/9 | 55%] - Navigating to /management/compliance-dashboard (ComplianceDashboardScreen)...");
  cy.visitWithSemantics("/management/compliance-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/9 | 55%] - Checking shell & content for ComplianceDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancedashboard-screen").should("be.visible");
  cy.getCy("compliancedashboard-title").should("be.visible");
  cy.getCy("compliancedashboard-content").should("be.visible");
  cy.getCy("compliance-dashboard-status").should("be.visible");
  cy.getCy("compliance-dashboard-audits").should("be.visible");
  cy.getCy("compliance-dashboard-activities").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/9 | 55%] - Saving screenshot for ComplianceDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/9 | 55%] - Verified ComplianceDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/9 | 66%] - Navigating to /management/audit-review (AuditReviewScreen)...");
  cy.visitWithSemantics("/management/audit-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/9 | 66%] - Checking shell & content for AuditReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditreview-screen").should("be.visible");
  cy.getCy("auditreview-title").should("be.visible");
  cy.getCy("auditreview-content").should("be.visible");
  cy.getCy("compliance-status-overview").should("be.visible");
  cy.getCy("recent-audits-list").should("be.visible");
  cy.getCy("compliance-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/9 | 66%] - Saving screenshot for AuditReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("audit_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/9 | 66%] - Verified AuditReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/9 | 77%] - Navigating to /management/incident-management (IncidentManagementScreen)...");
  cy.visitWithSemantics("/management/incident-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/9 | 77%] - Checking shell & content for IncidentManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentmanagement-screen").should("be.visible");
  cy.getCy("incidentmanagement-title").should("be.visible");
  cy.getCy("incidentmanagement-content").should("be.visible");
  cy.getCy("compliance-audit-status-card").should("be.visible");
  cy.getCy("compliance-activity-log").should("be.visible");
  cy.getCy("compliance-kpi-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/9 | 77%] - Saving screenshot for IncidentManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/9 | 77%] - Verified IncidentManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/9 | 88%] - Navigating to /management/policy-management (PolicyManagementScreen)...");
  cy.visitWithSemantics("/management/policy-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/9 | 88%] - Checking shell & content for PolicyManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policymanagement-screen").should("be.visible");
  cy.getCy("policymanagement-title").should("be.visible");
  cy.getCy("policymanagement-content").should("be.visible");
  cy.getCy("compliance-audit-status").should("be.visible");
  cy.getCy("compliance-breach-count").should("be.visible");
  cy.getCy("regulatory-change-overview").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/9 | 88%] - Saving screenshot for PolicyManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("policy_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/9 | 88%] - Verified PolicyManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [9/9 | 100%] - Navigating to /management/corrective-action (CorrectiveActionScreen)...");
  cy.visitWithSemantics("/management/corrective-action");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [9/9 | 100%] - Checking shell & content for CorrectiveActionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("correctiveaction-screen").should("be.visible");
  cy.getCy("correctiveaction-title").should("be.visible");
  cy.getCy("correctiveaction-content").should("be.visible");
  cy.getCy("compliance-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("compliance-dashboard-btn-update-status").should("be.visible");
  cy.getCy("compliance-dashboard-btn-train-staff").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [9/9 | 100%] - Saving screenshot for CorrectiveActionScreen...");
  cy.waitAndSee();
  cy.screenshot("corrective_action");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [9/9 | 100%] - Verified CorrectiveActionScreen successfully!\n");
  });

  it("tests org role franchise_sales", () => {
    cy.loginAsRole("franchise_sales");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /offices/business_development/roles/franchise_sales_manager/dashboard (FranchiseSalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for FranchiseSalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");
  cy.getCy("franchise-dashboard-kpi").should("be.visible");
  cy.getCy("franchise-dashboard-sales-trend").should("be.visible");
  cy.getCy("franchise-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for FranchiseSalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified FranchiseSalesManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /executive/franchise-sales-analytics (Franchise Sales Manager Analytics)...");
  cy.visitWithSemantics("/executive/franchise-sales-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Franchise Sales Manager Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesanalytics-screen").should("be.visible");
  cy.getCy("franchisesalesanalytics-title").should("be.visible");
  cy.getCy("franchisesalesanalytics-content").should("be.visible");
  cy.getCy("franchise-sales-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("franchise-sales-dashboard-btn-send-training-invite").should("be.visible");
  cy.getCy("franchise-sales-dashboard-btn-resolve-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Franchise Sales Manager Analytics...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Franchise Sales Manager Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /executive/franchise-sales-workflow (Franchise Sales Manager Compliance Workflow)...");
  cy.visitWithSemantics("/executive/franchise-sales-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Franchise Sales Manager Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesworkflow-screen").should("be.visible");
  cy.getCy("franchisesalesworkflow-title").should("be.visible");
  cy.getCy("franchisesalesworkflow-content").should("be.visible");
  cy.getCy("franchise-sales-metric-card").should("be.visible");
  cy.getCy("franchise-compliance-status").should("be.visible");
  cy.getCy("franchise-engagement-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Franchise Sales Manager Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Franchise Sales Manager Compliance Workflow successfully!\n");
  });

  it("tests org role gm", () => {
    cy.loginAsRole("gm");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/business_development/roles/general_manager/dashboard (GeneralManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/general_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for GeneralManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerdashboard-screen").should("be.visible");
  cy.getCy("generalmanagerdashboard-title").should("be.visible");
  cy.getCy("generalmanagerdashboard-content").should("be.visible");
  cy.getCy("gm-dashboard-kpi").should("be.visible");
  cy.getCy("gm-dashboard-operational-metrics").should("be.visible");
  cy.getCy("gm-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for GeneralManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified GeneralManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/general-manager-analytics (GeneralManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/general-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for GeneralManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanageranalytics-screen").should("be.visible");
  cy.getCy("generalmanageranalytics-title").should("be.visible");
  cy.getCy("generalmanageranalytics-content").should("be.visible");
  cy.getCy("gm-analytics-kpi").should("be.visible");
  cy.getCy("gm-analytics-employee-performance").should("be.visible");
  cy.getCy("gm-analytics-customer-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for GeneralManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified GeneralManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/general-manager-compliance (GeneralManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/general-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for GeneralManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagercompliance-screen").should("be.visible");
  cy.getCy("generalmanagercompliance-title").should("be.visible");
  cy.getCy("generalmanagercompliance-content").should("be.visible");
  cy.getCy("gm-dashboard-performance-metrics").should("be.visible");
  cy.getCy("gm-dashboard-compliance-status").should("be.visible");
  cy.getCy("gm-dashboard-employee-satisfaction").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for GeneralManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified GeneralManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/general-manager-workflow (GeneralManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/general-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for GeneralManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerworkflow-screen").should("be.visible");
  cy.getCy("generalmanagerworkflow-title").should("be.visible");
  cy.getCy("generalmanagerworkflow-content").should("be.visible");
  cy.getCy("gm-dashboard-kpi-chart").should("be.visible");
  cy.getCy("gm-dashboard-financial-performance").should("be.visible");
  cy.getCy("gm-dashboard-employee-engagement").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for GeneralManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified GeneralManagerWorkflowScreen successfully!\n");
  });

  it("tests org role governance", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Navigating to /common/system-dashboard (SystemDashboardScreen)...");
  cy.visitWithSemantics("/common/system-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Checking shell & content for SystemDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemdashboard-screen").should("be.visible");
  cy.getCy("systemdashboard-title").should("be.visible");
  cy.getCy("systemdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-refresh").should("be.visible");
  cy.getCy("govdashboard-btn-view-audit").should("be.visible");
  cy.getCy("govdashboard-btn-download-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Saving screenshot for SystemDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("system_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Verified SystemDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Navigating to /management/governance-officer-dashboard (GovernanceOfficerDashboardScreen)...");
  cy.visitWithSemantics("/management/governance-officer-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Checking shell & content for GovernanceOfficerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-execute-compliance-scan").should("be.visible");
  cy.getCy("govdashboard-btn-export-audit-logs").should("be.visible");
  cy.getCy("govdashboard-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Saving screenshot for GovernanceOfficerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Verified GovernanceOfficerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Navigating to /management/governance-officer-analytics (GovernanceOfficerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/governance-officer-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Checking shell & content for GovernanceOfficerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficeranalytics-screen").should("be.visible");
  cy.getCy("governanceofficeranalytics-title").should("be.visible");
  cy.getCy("governanceofficeranalytics-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-send-alert").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Saving screenshot for GovernanceOfficerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Verified GovernanceOfficerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Navigating to /management/governance-officer-compliance (GovernanceOfficerComplianceScreen)...");
  cy.visitWithSemantics("/management/governance-officer-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Checking shell & content for GovernanceOfficerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");
  cy.getCy("govdashboard-btn-start-audit").should("be.visible");
  cy.getCy("govdashboard-btn-view-reports").should("be.visible");
  cy.getCy("govdashboard-btn-generate-training-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Saving screenshot for GovernanceOfficerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Verified GovernanceOfficerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Navigating to /management/governance-officer-workflow (GovernanceOfficerWorkflowScreen)...");
  cy.visitWithSemantics("/management/governance-officer-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Checking shell & content for GovernanceOfficerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerworkflow-screen").should("be.visible");
  cy.getCy("governanceofficerworkflow-title").should("be.visible");
  cy.getCy("governanceofficerworkflow-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-submit-incident").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Saving screenshot for GovernanceOfficerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Verified GovernanceOfficerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Navigating to /common/governance-control-room (GovernanceControlRoomScreen)...");
  cy.visitWithSemantics("/common/governance-control-room");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Checking shell & content for GovernanceControlRoomScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governancecontrolroom-screen").should("be.visible");
  cy.getCy("governancecontrolroom-title").should("be.visible");
  cy.getCy("governancecontrolroom-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-compliance").should("be.visible");
  cy.getCy("gov-dashboard-btn-notify-stakeholders").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Saving screenshot for GovernanceControlRoomScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_control_room");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Verified GovernanceControlRoomScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Navigating to /common/runtime-verification (RuntimeVerificationScreen)...");
  cy.visitWithSemantics("/common/runtime-verification");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Checking shell & content for RuntimeVerificationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("runtimeverification-screen").should("be.visible");
  cy.getCy("runtimeverification-title").should("be.visible");
  cy.getCy("runtimeverification-content").should("be.visible");
  cy.getCy("gov-dashboard-compliance-status").should("be.visible");
  cy.getCy("gov-dashboard-audit-log").should("be.visible");
  cy.getCy("gov-dashboard-risk-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Saving screenshot for RuntimeVerificationScreen...");
  cy.waitAndSee();
  cy.screenshot("runtime_verification");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Verified RuntimeVerificationScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Navigating to /common/drift-findings (DriftFindingsScreen)...");
  cy.visitWithSemantics("/common/drift-findings");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Checking shell & content for DriftFindingsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("driftfindings-screen").should("be.visible");
  cy.getCy("driftfindings-title").should("be.visible");
  cy.getCy("driftfindings-content").should("be.visible");
  cy.getCy("gov-dashboard-compliance-status").should("be.visible");
  cy.getCy("gov-dashboard-audit-logs").should("be.visible");
  cy.getCy("gov-dashboard-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Saving screenshot for DriftFindingsScreen...");
  cy.waitAndSee();
  cy.screenshot("drift_findings");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Verified DriftFindingsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Navigating to /common/pending-task-queue (PendingTaskQueueScreen)...");
  cy.visitWithSemantics("/common/pending-task-queue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Checking shell & content for PendingTaskQueueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pendingtaskqueue-screen").should("be.visible");
  cy.getCy("pendingtaskqueue-title").should("be.visible");
  cy.getCy("pendingtaskqueue-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-refresh").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-download-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Saving screenshot for PendingTaskQueueScreen...");
  cy.waitAndSee();
  cy.screenshot("pending_task_queue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Verified PendingTaskQueueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Navigating to /common/agent-dispatch (AgentDispatchScreen)...");
  cy.visitWithSemantics("/common/agent-dispatch");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Checking shell & content for AgentDispatchScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("agentdispatch-screen").should("be.visible");
  cy.getCy("agentdispatch-title").should("be.visible");
  cy.getCy("agentdispatch-content").should("be.visible");
  cy.getCy("gov-dashboard-compliance-status").should("be.visible");
  cy.getCy("gov-dashboard-audit-log").should("be.visible");
  cy.getCy("gov-dashboard-risk-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Saving screenshot for AgentDispatchScreen...");
  cy.waitAndSee();
  cy.screenshot("agent_dispatch");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Verified AgentDispatchScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Navigating to /common/audit (ScreenAuditScreen)...");
  cy.visitWithSemantics("/common/audit");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Checking shell & content for ScreenAuditScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audit-screen").should("be.visible");
  cy.getCy("audit-title").should("be.visible");
  cy.getCy("audit-content").should("be.visible");
  cy.getCy("gov-dashboard-refresh-data").should("be.visible");
  cy.getCy("gov-dashboard-generate-audit-report").should("be.visible");
  cy.getCy("gov-dashboard-send-compliance-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Saving screenshot for ScreenAuditScreen...");
  cy.waitAndSee();
  cy.screenshot("audit");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Verified ScreenAuditScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Navigating to /common/api-health-dashboard (ApiHealthDashboardScreen)...");
  cy.visitWithSemantics("/common/api-health-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Checking shell & content for ApiHealthDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("govdashboard-btn-generate-report").should("be.visible");
  cy.getCy("govdashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Saving screenshot for ApiHealthDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Verified ApiHealthDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Navigating to /common/release-operations (ReleaseOperationsScreen)...");
  cy.visitWithSemantics("/common/release-operations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Checking shell & content for ReleaseOperationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releaseoperations-screen").should("be.visible");
  cy.getCy("releaseoperations-title").should("be.visible");
  cy.getCy("releaseoperations-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-filter-logs").should("be.visible");
  cy.getCy("gov-dashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Saving screenshot for ReleaseOperationsScreen...");
  cy.waitAndSee();
  cy.screenshot("release_operations");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Verified ReleaseOperationsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Navigating to /common/file-verification-dashboard (FileVerificationDashboardScreen)...");
  cy.visitWithSemantics("/common/file-verification-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Checking shell & content for FileVerificationDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("govdashboard-btn-generate-report").should("be.visible");
  cy.getCy("govdashboard-btn-access-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Saving screenshot for FileVerificationDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Verified FileVerificationDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Navigating to /common/role-coverage-dashboard (RoleCoverageDashboardScreen)...");
  cy.visitWithSemantics("/common/role-coverage-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Checking shell & content for RoleCoverageDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rolecoveragedashboard-screen").should("be.visible");
  cy.getCy("rolecoveragedashboard-title").should("be.visible");
  cy.getCy("rolecoveragedashboard-content").should("be.visible");
  cy.getCy("govdashboard-btn-generate-report").should("be.visible");
  cy.getCy("govdashboard-btn-update-doc").should("be.visible");
  cy.getCy("govdashboard-btn-conduct-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Saving screenshot for RoleCoverageDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("role_coverage_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Verified RoleCoverageDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Navigating to /common/responsive-preview (ResponsivePreviewScreen)...");
  cy.visitWithSemantics("/common/responsive-preview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Checking shell & content for ResponsivePreviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsivepreview-screen").should("be.visible");
  cy.getCy("responsivepreview-title").should("be.visible");
  cy.getCy("responsivepreview-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-compliance").should("be.visible");
  cy.getCy("gov-dashboard-btn-export-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-assess-risk").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Saving screenshot for ResponsivePreviewScreen...");
  cy.waitAndSee();
  cy.screenshot("responsive_preview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Verified ResponsivePreviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Navigating to /common/workflow-execution (WorkflowExecutionScreen)...");
  cy.visitWithSemantics("/common/workflow-execution");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Checking shell & content for WorkflowExecutionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowexecution-screen").should("be.visible");
  cy.getCy("workflowexecution-title").should("be.visible");
  cy.getCy("workflowexecution-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-request-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Saving screenshot for WorkflowExecutionScreen...");
  cy.waitAndSee();
  cy.screenshot("workflow_execution");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Verified WorkflowExecutionScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Navigating to /common/governance-operations4-k (GovernanceOperations4KScreen)...");
  cy.visitWithSemantics("/common/governance-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Checking shell & content for GovernanceOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceoperations4k-screen").should("be.visible");
  cy.getCy("governanceoperations4k-title").should("be.visible");
  cy.getCy("governanceoperations4k-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-conduct-audit").should("be.visible");
  cy.getCy("gov-dashboard-btn-update-docs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Saving screenshot for GovernanceOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Verified GovernanceOperations4KScreen successfully!\n");
  });

  it("tests org role bus_dev", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Navigating to /common/business-development-dashboard (BusinessDevelopmentDashboardScreen)...");
  cy.visitWithSemantics("/common/business-development-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Checking shell & content for BusinessDevelopmentDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-content").should("be.visible");
  cy.getCy("businessdashboard-btn-refresh").should("be.visible");
  cy.getCy("businessdashboard-btn-viewproposal").should("be.visible");
  cy.getCy("businessdashboard-btn-exportreport").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Saving screenshot for BusinessDevelopmentDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Verified BusinessDevelopmentDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Navigating to /offices/corporate/roles/head_of_bus_dev/dashboard (HeadOfBusDevDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/head_of_bus_dev/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Checking shell & content for HeadOfBusDevDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevdashboard-screen").should("be.visible");
  cy.getCy("headofbusdevdashboard-title").should("be.visible");
  cy.getCy("headofbusdevdashboard-content").should("be.visible");
  cy.getCy("bd-dashboard-kpi-widget").should("be.visible");
  cy.getCy("bd-dashboard-client-metrics").should("be.visible");
  cy.getCy("bd-dashboard-market-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Saving screenshot for HeadOfBusDevDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Verified HeadOfBusDevDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Navigating to /common/business-development-analytics (BusinessDevelopmentAnalyticsScreen)...");
  cy.visitWithSemantics("/common/business-development-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Checking shell & content for BusinessDevelopmentAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentanalytics-screen").should("be.visible");
  cy.getCy("businessdevelopmentanalytics-title").should("be.visible");
  cy.getCy("businessdevelopmentanalytics-content").should("be.visible");
  cy.getCy("bd-dashboard-sales-metrics").should("be.visible");
  cy.getCy("bd-dashboard-client-data").should("be.visible");
  cy.getCy("bd-dashboard-pipeline-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Saving screenshot for BusinessDevelopmentAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Verified BusinessDevelopmentAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Navigating to /common/business-development-compliance (BusinessDevelopmentComplianceScreen)...");
  cy.visitWithSemantics("/common/business-development-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Checking shell & content for BusinessDevelopmentComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentcompliance-screen").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-title").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-content").should("be.visible");
  cy.getCy("businessdev-kpi-widget").should("be.visible");
  cy.getCy("businessdev-customer-metrics").should("be.visible");
  cy.getCy("businessdev-initiatives-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Saving screenshot for BusinessDevelopmentComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Verified BusinessDevelopmentComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Navigating to /common/business-development-workflow (BusinessDevelopmentWorkflowScreen)...");
  cy.visitWithSemantics("/common/business-development-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Checking shell & content for BusinessDevelopmentWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentworkflow-screen").should("be.visible");
  cy.getCy("businessdevelopmentworkflow-title").should("be.visible");
  cy.getCy("businessdevelopmentworkflow-content").should("be.visible");
  cy.getCy("bd-dashboard-kpi-chart").should("be.visible");
  cy.getCy("bd-dashboard-opportunity-pipeline").should("be.visible");
  cy.getCy("bd-dashboard-team-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Saving screenshot for BusinessDevelopmentWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Verified BusinessDevelopmentWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Navigating to /management/head-of-bus-dev-analytics (HeadOfBusDevAnalyticsScreen)...");
  cy.visitWithSemantics("/management/head-of-bus-dev-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Checking shell & content for HeadOfBusDevAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevanalytics-screen").should("be.visible");
  cy.getCy("headofbusdevanalytics-title").should("be.visible");
  cy.getCy("headofbusdevanalytics-content").should("be.visible");
  cy.getCy("bd-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("bd-dashboard-btn-view-proposal").should("be.visible");
  cy.getCy("bd-dashboard-btn-negotiate-contract").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Saving screenshot for HeadOfBusDevAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Verified HeadOfBusDevAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Navigating to /management/head-of-bus-dev-compliance (HeadOfBusDevComplianceScreen)...");
  cy.visitWithSemantics("/management/head-of-bus-dev-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Checking shell & content for HeadOfBusDevComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevcompliance-screen").should("be.visible");
  cy.getCy("headofbusdevcompliance-title").should("be.visible");
  cy.getCy("headofbusdevcompliance-content").should("be.visible");
  cy.getCy("bd-dashboard-btn-view-proposal").should("be.visible");
  cy.getCy("bd-dashboard-btn-negotiate-contract").should("be.visible");
  cy.getCy("bd-dashboard-btn-track-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Saving screenshot for HeadOfBusDevComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Verified HeadOfBusDevComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Navigating to /management/head-of-bus-dev-workflow (HeadOfBusDevWorkflowScreen)...");
  cy.visitWithSemantics("/management/head-of-bus-dev-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Checking shell & content for HeadOfBusDevWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevworkflow-screen").should("be.visible");
  cy.getCy("headofbusdevworkflow-title").should("be.visible");
  cy.getCy("headofbusdevworkflow-content").should("be.visible");
  cy.getCy("bd-dashboard-kpi-chart").should("be.visible");
  cy.getCy("bd-dashboard-pipeline-status").should("be.visible");
  cy.getCy("bd-dashboard-client-engagement").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Saving screenshot for HeadOfBusDevWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Verified HeadOfBusDevWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Navigating to /management/franchise-lead (FranchiseLeadScreen)...");
  cy.visitWithSemantics("/management/franchise-lead");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Checking shell & content for FranchiseLeadScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiselead-screen").should("be.visible");
  cy.getCy("franchiselead-title").should("be.visible");
  cy.getCy("franchiselead-content").should("be.visible");
  cy.getCy("franchiselead-kpi-chart").should("be.visible");
  cy.getCy("franchiselead-opportunity-list").should("be.visible");
  cy.getCy("franchiselead-client-management").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Saving screenshot for FranchiseLeadScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_lead");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Verified FranchiseLeadScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Navigating to /management/partnership-management (PartnershipManagementScreen)...");
  cy.visitWithSemantics("/management/partnership-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Checking shell & content for PartnershipManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagement-screen").should("be.visible");
  cy.getCy("partnershipmanagement-title").should("be.visible");
  cy.getCy("partnershipmanagement-content").should("be.visible");
  cy.getCy("bdashboard-kpi-chart").should("be.visible");
  cy.getCy("bdashboard-partner-satisfaction").should("be.visible");
  cy.getCy("bdashboard-market-trend").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Saving screenshot for PartnershipManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Verified PartnershipManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Navigating to /management/growth-analytics (GrowthAnalyticsScreen)...");
  cy.visitWithSemantics("/management/growth-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Checking shell & content for GrowthAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("growthanalytics-screen").should("be.visible");
  cy.getCy("growthanalytics-title").should("be.visible");
  cy.getCy("growthanalytics-content").should("be.visible");
  cy.getCy("growthanalytics-btn-generate-report").should("be.visible");
  cy.getCy("growthanalytics-btn-view-details").should("be.visible");
  cy.getCy("growthanalytics-btn-update-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Saving screenshot for GrowthAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("growth_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Verified GrowthAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Navigating to /management/outreach-campaign (OutreachCampaignScreen)...");
  cy.visitWithSemantics("/management/outreach-campaign");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Checking shell & content for OutreachCampaignScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("outreachcampaign-screen").should("be.visible");
  cy.getCy("outreachcampaign-title").should("be.visible");
  cy.getCy("outreachcampaign-content").should("be.visible");
  cy.getCy("bdashboard-btn-add-opportunity").should("be.visible");
  cy.getCy("bdashboard-btn-view-reports").should("be.visible");
  cy.getCy("bdashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Saving screenshot for OutreachCampaignScreen...");
  cy.waitAndSee();
  cy.screenshot("outreach_campaign");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Verified OutreachCampaignScreen successfully!\n");
  });

  it("tests org role marketing", () => {
    cy.loginAsRole("marketing");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Navigating to /offices/corporate/roles/head_of_marketing/dashboard (HeadOfMarketingDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/head_of_marketing/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Checking shell & content for HeadOfMarketingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingdashboard-screen").should("be.visible");
  cy.getCy("headofmarketingdashboard-title").should("be.visible");
  cy.getCy("headofmarketingdashboard-content").should("be.visible");
  cy.getCy("marketing-dashboard-campaigns").should("be.visible");
  cy.getCy("marketing-dashboard-analytics").should("be.visible");
  cy.getCy("marketing-dashboard-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Saving screenshot for HeadOfMarketingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Verified HeadOfMarketingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Navigating to /offices/marketing/roles/local_marketing_manager/dashboard (LocalMarketingManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/local_marketing_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Checking shell & content for LocalMarketingManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");
  cy.getCy("localmarketing-dashboard-campaigns").should("be.visible");
  cy.getCy("localmarketing-dashboard-socialmedia").should("be.visible");
  cy.getCy("localmarketing-dashboard-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Saving screenshot for LocalMarketingManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Verified LocalMarketingManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Navigating to /management/head-of-marketing-analytics (HeadOfMarketingAnalyticsScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Checking shell & content for HeadOfMarketingAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketinganalytics-screen").should("be.visible");
  cy.getCy("headofmarketinganalytics-title").should("be.visible");
  cy.getCy("headofmarketinganalytics-content").should("be.visible");
  cy.getCy("marketing-dashboard-kpi").should("be.visible");
  cy.getCy("marketing-dashboard-realtime-analytics").should("be.visible");
  cy.getCy("marketing-dashboard-social-media").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Saving screenshot for HeadOfMarketingAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Verified HeadOfMarketingAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Navigating to /management/head-of-marketing-compliance (HeadOfMarketingComplianceScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Checking shell & content for HeadOfMarketingComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingcompliance-screen").should("be.visible");
  cy.getCy("headofmarketingcompliance-title").should("be.visible");
  cy.getCy("headofmarketingcompliance-content").should("be.visible");
  cy.getCy("marketing-dashboard-campaigns").should("be.visible");
  cy.getCy("marketing-dashboard-kpis").should("be.visible");
  cy.getCy("marketing-dashboard-analytics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Saving screenshot for HeadOfMarketingComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Verified HeadOfMarketingComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Navigating to /management/head-of-marketing-workflow (HeadOfMarketingWorkflowScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Checking shell & content for HeadOfMarketingWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingworkflow-screen").should("be.visible");
  cy.getCy("headofmarketingworkflow-title").should("be.visible");
  cy.getCy("headofmarketingworkflow-content").should("be.visible");
  cy.getCy("marketing-dashboard-btn-view-campaigns").should("be.visible");
  cy.getCy("marketing-dashboard-btn-analyze-kpis").should("be.visible");
  cy.getCy("marketing-dashboard-btn-check-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Saving screenshot for HeadOfMarketingWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Verified HeadOfMarketingWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Navigating to /management/local-marketing-manager-analytics (LocalMarketingManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Checking shell & content for LocalMarketingManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");
  cy.getCy("localmarketing-kpi-overview").should("be.visible");
  cy.getCy("localmarketing-refresh-data").should("be.visible");
  cy.getCy("localmarketing-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Saving screenshot for LocalMarketingManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Verified LocalMarketingManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Navigating to /management/local-marketing-manager-compliance (LocalMarketingManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Checking shell & content for LocalMarketingManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");
  cy.getCy("localmarketing-btn-generate-report").should("be.visible");
  cy.getCy("localmarketing-btn-view-campaign").should("be.visible");
  cy.getCy("localmarketing-btn-track-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Saving screenshot for LocalMarketingManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Verified LocalMarketingManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Navigating to /management/local-marketing-manager-workflow (LocalMarketingManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Checking shell & content for LocalMarketingManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");
  cy.getCy("localmarketing-btn-addcampaign").should("be.visible");
  cy.getCy("localmarketing-btn-viewreports").should("be.visible");
  cy.getCy("localmarketing-btn-adjustbudget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Saving screenshot for LocalMarketingManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Verified LocalMarketingManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Navigating to /management/campaign-dashboard (CampaignDashboardScreen)...");
  cy.visitWithSemantics("/management/campaign-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Checking shell & content for CampaignDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("campaigndashboard-screen").should("be.visible");
  cy.getCy("campaigndashboard-title").should("be.visible");
  cy.getCy("campaigndashboard-content").should("be.visible");
  cy.getCy("campaign-dashboard-refresh").should("be.visible");
  cy.getCy("campaign-dashboard-view-report").should("be.visible");
  cy.getCy("campaign-dashboard-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Saving screenshot for CampaignDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("campaign_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Verified CampaignDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Navigating to /management/lead-analytics (LeadAnalyticsScreen)...");
  cy.visitWithSemantics("/management/lead-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Checking shell & content for LeadAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadanalytics-screen").should("be.visible");
  cy.getCy("leadanalytics-title").should("be.visible");
  cy.getCy("leadanalytics-content").should("be.visible");
  cy.getCy("leadanalytics-btn-refresh").should("be.visible");
  cy.getCy("leadanalytics-btn-export").should("be.visible");
  cy.getCy("leadanalytics-btn-viewdetails").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Saving screenshot for LeadAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("lead_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Verified LeadAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Navigating to /management/social-media (SocialMediaScreen)...");
  cy.visitWithSemantics("/management/social-media");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Checking shell & content for SocialMediaScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialmedia-screen").should("be.visible");
  cy.getCy("socialmedia-title").should("be.visible");
  cy.getCy("socialmedia-content").should("be.visible");
  cy.getCy("marketing-dashboard-btn-view-campaign").should("be.visible");
  cy.getCy("marketing-dashboard-btn-export-reports").should("be.visible");
  cy.getCy("marketing-dashboard-btn-analyze-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Saving screenshot for SocialMediaScreen...");
  cy.waitAndSee();
  cy.screenshot("social_media");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Verified SocialMediaScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Navigating to /management/brand-management (BrandManagementScreen)...");
  cy.visitWithSemantics("/management/brand-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Checking shell & content for BrandManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("brandmanagement-screen").should("be.visible");
  cy.getCy("brandmanagement-title").should("be.visible");
  cy.getCy("brandmanagement-content").should("be.visible");
  cy.getCy("marketing-dashboard-campaign-overview").should("be.visible");
  cy.getCy("marketing-dashboard-kpi-chart").should("be.visible");
  cy.getCy("marketing-dashboard-real-time-analytics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Saving screenshot for BrandManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("brand_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Verified BrandManagementScreen successfully!\n");
  });

  it("tests org role local_marketing", () => {
    cy.loginAsRole("local_marketing");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/marketing/roles/local_marketing_manager/dashboard (LocalMarketingManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/local_marketing_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for LocalMarketingManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");
  cy.getCy("localmarketing-dashboard-campaigns").should("be.visible");
  cy.getCy("localmarketing-dashboard-socialmedia").should("be.visible");
  cy.getCy("localmarketing-dashboard-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for LocalMarketingManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified LocalMarketingManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/local-marketing-manager-analytics (LocalMarketingManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for LocalMarketingManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");
  cy.getCy("localmarketing-kpi-overview").should("be.visible");
  cy.getCy("localmarketing-refresh-data").should("be.visible");
  cy.getCy("localmarketing-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for LocalMarketingManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified LocalMarketingManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/local-marketing-manager-compliance (LocalMarketingManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for LocalMarketingManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");
  cy.getCy("localmarketing-btn-generate-report").should("be.visible");
  cy.getCy("localmarketing-btn-view-campaign").should("be.visible");
  cy.getCy("localmarketing-btn-track-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for LocalMarketingManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified LocalMarketingManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/local-marketing-manager-workflow (LocalMarketingManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for LocalMarketingManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");
  cy.getCy("localmarketing-btn-addcampaign").should("be.visible");
  cy.getCy("localmarketing-btn-viewreports").should("be.visible");
  cy.getCy("localmarketing-btn-adjustbudget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for LocalMarketingManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified LocalMarketingManagerWorkflowScreen successfully!\n");
  });

  it("tests org role ops_manager", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Navigating to /offices/franchise/roles/operations_manager/dashboard (OperationsManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Checking shell & content for OperationsManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerdashboard-screen").should("be.visible");
  cy.getCy("operationsmanagerdashboard-title").should("be.visible");
  cy.getCy("operationsmanagerdashboard-content").should("be.visible");
  cy.getCy("operations-dashboard-kpi").should("be.visible");
  cy.getCy("operations-dashboard-compliance").should("be.visible");
  cy.getCy("operations-dashboard-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Saving screenshot for OperationsManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Verified OperationsManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Navigating to /management/operations-manager-analytics (OperationsManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/operations-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Checking shell & content for OperationsManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanageranalytics-screen").should("be.visible");
  cy.getCy("operationsmanageranalytics-title").should("be.visible");
  cy.getCy("operationsmanageranalytics-content").should("be.visible");
  cy.getCy("opsmanager-btn-refresh").should("be.visible");
  cy.getCy("opsmanager-btn-view-report").should("be.visible");
  cy.getCy("opsmanager-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Saving screenshot for OperationsManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Verified OperationsManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Navigating to /management/operations-manager-compliance (OperationsManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/operations-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Checking shell & content for OperationsManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagercompliance-screen").should("be.visible");
  cy.getCy("operationsmanagercompliance-title").should("be.visible");
  cy.getCy("operationsmanagercompliance-content").should("be.visible");
  cy.getCy("operations-compliance-status-card").should("be.visible");
  cy.getCy("operations-audit-log-table").should("be.visible");
  cy.getCy("operations-performance-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Saving screenshot for OperationsManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Verified OperationsManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Navigating to /management/operations-manager-workflow (OperationsManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/operations-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Checking shell & content for OperationsManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerworkflow-screen").should("be.visible");
  cy.getCy("operationsmanagerworkflow-title").should("be.visible");
  cy.getCy("operationsmanagerworkflow-content").should("be.visible");
  cy.getCy("opsmanager-kpi-overview").should("be.visible");
  cy.getCy("opsmanager-metrics-chart").should("be.visible");
  cy.getCy("opsmanager-team-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Saving screenshot for OperationsManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Verified OperationsManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Navigating to /management/daily-operations (DailyOperationsScreen)...");
  cy.visitWithSemantics("/management/daily-operations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Checking shell & content for DailyOperationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dailyoperations-screen").should("be.visible");
  cy.getCy("dailyoperations-title").should("be.visible");
  cy.getCy("dailyoperations-content").should("be.visible");
  cy.getCy("operations-kpi-widget").should("be.visible");
  cy.getCy("operations-compliance-status").should("be.visible");
  cy.getCy("operations-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Saving screenshot for DailyOperationsScreen...");
  cy.waitAndSee();
  cy.screenshot("daily_operations");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Verified DailyOperationsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Navigating to /management/attendance (AttendanceScreen)...");
  cy.visitWithSemantics("/management/attendance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Checking shell & content for AttendanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("attendance-screen").should("be.visible");
  cy.getCy("attendance-title").should("be.visible");
  cy.getCy("attendance-content").should("be.visible");
  cy.getCy("attendance-dashboard-performance").should("be.visible");
  cy.getCy("attendance-dashboard-compliance").should("be.visible");
  cy.getCy("attendance-dashboard-engagement").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Saving screenshot for AttendanceScreen...");
  cy.waitAndSee();
  cy.screenshot("attendance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Verified AttendanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Navigating to /management/scheduling-health (SchedulingHealthScreen)...");
  cy.visitWithSemantics("/management/scheduling-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Checking shell & content for SchedulingHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulinghealth-screen").should("be.visible");
  cy.getCy("schedulinghealth-title").should("be.visible");
  cy.getCy("schedulinghealth-content").should("be.visible");
  cy.getCy("ops-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("ops-dashboard-btn-conduct-audit").should("be.visible");
  cy.getCy("ops-dashboard-btn-train-staff").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Saving screenshot for SchedulingHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_health");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Verified SchedulingHealthScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Navigating to /management/service-issue (ServiceIssueScreen)...");
  cy.visitWithSemantics("/management/service-issue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Checking shell & content for ServiceIssueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("serviceissue-screen").should("be.visible");
  cy.getCy("serviceissue-title").should("be.visible");
  cy.getCy("serviceissue-content").should("be.visible");
  cy.getCy("opsdashboard-btn-generate-report").should("be.visible");
  cy.getCy("opsdashboard-btn-view-compliance").should("be.visible");
  cy.getCy("opsdashboard-btn-track-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Saving screenshot for ServiceIssueScreen...");
  cy.waitAndSee();
  cy.screenshot("service_issue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Verified ServiceIssueScreen successfully!\n");
  });

  it("tests org role partnership", () => {
    cy.loginAsRole("partnership");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/business_development/roles/partnership_manager/dashboard (PartnershipManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for PartnershipManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-content").should("be.visible");
  cy.getCy("partnership-dashboard-btn-export-logs").should("be.visible");
  cy.getCy("partnership-dashboard-btn-refresh-data").should("be.visible");
  cy.getCy("partnership-dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for PartnershipManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified PartnershipManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/partnership-manager-analytics (PartnershipManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for PartnershipManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanageranalytics-screen").should("be.visible");
  cy.getCy("partnershipmanageranalytics-title").should("be.visible");
  cy.getCy("partnershipmanageranalytics-content").should("be.visible");
  cy.getCy("partnerships-btn-generate-report").should("be.visible");
  cy.getCy("partnerships-btn-negotiate").should("be.visible");
  cy.getCy("partnerships-btn-address-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for PartnershipManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified PartnershipManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/partnership-manager-compliance (PartnershipManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for PartnershipManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagercompliance-screen").should("be.visible");
  cy.getCy("partnershipmanagercompliance-title").should("be.visible");
  cy.getCy("partnershipmanagercompliance-content").should("be.visible");
  cy.getCy("compliance-audit-status-card").should("be.visible");
  cy.getCy("recent-audit-summary-card").should("be.visible");
  cy.getCy("operational-logs-table").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for PartnershipManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified PartnershipManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/partnership-manager-workflow (PartnershipManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/partnership-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for PartnershipManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerworkflow-screen").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-title").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-content").should("be.visible");
  cy.getCy("partnerships-overview-card").should("be.visible");
  cy.getCy("performance-metrics-chart").should("be.visible");
  cy.getCy("alerts-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for PartnershipManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified PartnershipManagerWorkflowScreen successfully!\n");
  });

  it("tests org role regional_bdm", () => {
    cy.loginAsRole("regional_bdm");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/business_development/roles/regional_bdm/dashboard (RegionalBdmDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for RegionalBdmDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmdashboard-screen").should("be.visible");
  cy.getCy("regionalbdmdashboard-title").should("be.visible");
  cy.getCy("regionalbdmdashboard-content").should("be.visible");
  cy.getCy("dashboard-active-operations").should("be.visible");
  cy.getCy("dashboard-productivity-metric").should("be.visible");
  cy.getCy("dashboard-security-clearance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for RegionalBdmDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified RegionalBdmDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/regional-bdm-analytics (RegionalBdmAnalyticsScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for RegionalBdmAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmanalytics-screen").should("be.visible");
  cy.getCy("regionalbdmanalytics-title").should("be.visible");
  cy.getCy("regionalbdmanalytics-content").should("be.visible");
  cy.getCy("regional-bdm-btn-generate-report").should("be.visible");
  cy.getCy("regional-bdm-btn-send-feedback").should("be.visible");
  cy.getCy("regional-bdm-btn-update-strategy").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for RegionalBdmAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified RegionalBdmAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/regional-bdm-compliance (RegionalBdmComplianceScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for RegionalBdmComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmcompliance-screen").should("be.visible");
  cy.getCy("regionalbdmcompliance-title").should("be.visible");
  cy.getCy("regionalbdmcompliance-content").should("be.visible");
  cy.getCy("compliance-audit-status").should("be.visible");
  cy.getCy("telemetry-data-display").should("be.visible");
  cy.getCy("governance-actions-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for RegionalBdmComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified RegionalBdmComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/regional-bdm-workflow (RegionalBdmWorkflowScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for RegionalBdmWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmworkflow-screen").should("be.visible");
  cy.getCy("regionalbdmworkflow-title").should("be.visible");
  cy.getCy("regionalbdmworkflow-content").should("be.visible");
  cy.getCy("regional-bdm-sales-metric").should("be.visible");
  cy.getCy("regional-bdm-sales-trend").should("be.visible");
  cy.getCy("regional-bdm-client-manager").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for RegionalBdmWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified RegionalBdmWorkflowScreen successfully!\n");
  });

  it("tests org role regional_manager_usa", () => {
    cy.loginAsRole("regional_manager_usa");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/business_development/roles/regional_manager_usa/dashboard (RegionalManagerUsaDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_manager_usa/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for RegionalManagerUsaDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-content").should("be.visible");
  cy.getCy("dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("dashboard-btn-export-audit-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for RegionalManagerUsaDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified RegionalManagerUsaDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/regional-manager-usa-analytics (RegionalManagerUsaAnalyticsScreen)...");
  cy.visitWithSemantics("/management/regional-manager-usa-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for RegionalManagerUsaAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusaanalytics-screen").should("be.visible");
  cy.getCy("regionalmanagerusaanalytics-title").should("be.visible");
  cy.getCy("regionalmanagerusaanalytics-content").should("be.visible");
  cy.getCy("regionalmanager-sales-performance").should("be.visible");
  cy.getCy("regionalmanager-customer-feedback").should("be.visible");
  cy.getCy("regionalmanager-budget-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for RegionalManagerUsaAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified RegionalManagerUsaAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/regional-manager-usa-compliance (RegionalManagerUsaComplianceScreen)...");
  cy.visitWithSemantics("/management/regional-manager-usa-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for RegionalManagerUsaComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusacompliance-screen").should("be.visible");
  cy.getCy("regionalmanagerusacompliance-title").should("be.visible");
  cy.getCy("regionalmanagerusacompliance-content").should("be.visible");
  cy.getCy("compliance-audit-status").should("be.visible");
  cy.getCy("telemetry-log-widget").should("be.visible");
  cy.getCy("security-policy-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for RegionalManagerUsaComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified RegionalManagerUsaComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/regional-manager-usa-workflow (RegionalManagerUsaWorkflowScreen)...");
  cy.visitWithSemantics("/management/regional-manager-usa-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for RegionalManagerUsaWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusaworkflow-screen").should("be.visible");
  cy.getCy("regionalmanagerusaworkflow-title").should("be.visible");
  cy.getCy("regionalmanagerusaworkflow-content").should("be.visible");
  cy.getCy("dashboard-btn-generate-report").should("be.visible");
  cy.getCy("dashboard-btn-schedule-meeting").should("be.visible");
  cy.getCy("dashboard-btn-allocate-resources").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for RegionalManagerUsaWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified RegionalManagerUsaWorkflowScreen successfully!\n");
  });

  it("tests org role scrum_master", () => {
    cy.loginAsRole("scrum_master");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /management/scrum-master-dashboard (ScrumMasterDashboardScreen)...");
  cy.visitWithSemantics("/management/scrum-master-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for ScrumMasterDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterdashboard-screen").should("be.visible");
  cy.getCy("scrummasterdashboard-title").should("be.visible");
  cy.getCy("scrummasterdashboard-content").should("be.visible");
  cy.getCy("scrum-dashboard-burndown-chart").should("be.visible");
  cy.getCy("scrum-dashboard-velocity-metric").should("be.visible");
  cy.getCy("scrum-dashboard-impediment-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for ScrumMasterDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified ScrumMasterDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/scrum-master-analytics (ScrumMasterAnalyticsScreen)...");
  cy.visitWithSemantics("/management/scrum-master-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for ScrumMasterAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasteranalytics-screen").should("be.visible");
  cy.getCy("scrummasteranalytics-title").should("be.visible");
  cy.getCy("scrummasteranalytics-content").should("be.visible");
  cy.getCy("scrum-dashboard-btn-add-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-resolve-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-start-sprint-planning").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for ScrumMasterAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified ScrumMasterAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/scrum-master-compliance (ScrumMasterComplianceScreen)...");
  cy.visitWithSemantics("/management/scrum-master-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for ScrumMasterComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummastercompliance-screen").should("be.visible");
  cy.getCy("scrummastercompliance-title").should("be.visible");
  cy.getCy("scrummastercompliance-content").should("be.visible");
  cy.getCy("scrum-dashboard-btn-add-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-resolve-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-record-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for ScrumMasterComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified ScrumMasterComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/scrum-master-workflow (ScrumMasterWorkflowScreen)...");
  cy.visitWithSemantics("/management/scrum-master-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for ScrumMasterWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterworkflow-screen").should("be.visible");
  cy.getCy("scrummasterworkflow-title").should("be.visible");
  cy.getCy("scrummasterworkflow-content").should("be.visible");
  cy.getCy("scrum-dashboard-btn-add-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-resolve-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-start-retrospective").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for ScrumMasterWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified ScrumMasterWorkflowScreen successfully!\n");
  });

  it("tests org role hr_hiring", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/13 | 7%] - Navigating to /offices/franchise/roles/hr_hiring/dashboard (HrHiringDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/13 | 7%] - Checking shell & content for HrHiringDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringdashboard-screen").should("be.visible");
  cy.getCy("hrhiringdashboard-title").should("be.visible");
  cy.getCy("hrhiringdashboard-content").should("be.visible");
  cy.getCy("hr_dashboard-kpi-widget").should("be.visible");
  cy.getCy("hr_dashboard-candidate-pipeline").should("be.visible");
  cy.getCy("hr_dashboard-source-analysis").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/13 | 7%] - Saving screenshot for HrHiringDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/13 | 7%] - Verified HrHiringDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/13 | 15%] - Navigating to /staff/hr-hiring-analytics (HrHiringAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/13 | 15%] - Checking shell & content for HrHiringAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringanalytics-screen").should("be.visible");
  cy.getCy("hrhiringanalytics-title").should("be.visible");
  cy.getCy("hrhiringanalytics-content").should("be.visible");
  cy.getCy("hr_hiring_analytics-btn-refresh").should("be.visible");
  cy.getCy("hr_hiring_analytics-btn-export").should("be.visible");
  cy.getCy("hr_hiring_analytics-btn-add_position").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/13 | 15%] - Saving screenshot for HrHiringAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/13 | 15%] - Verified HrHiringAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/13 | 23%] - Navigating to /staff/hr-hiring-compliance (HrHiringComplianceScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/13 | 23%] - Checking shell & content for HrHiringComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcompliance-screen").should("be.visible");
  cy.getCy("hrhiringcompliance-title").should("be.visible");
  cy.getCy("hrhiringcompliance-content").should("be.visible");
  cy.getCy("hr_hiring_compliance-btn-refresh").should("be.visible");
  cy.getCy("hr_hiring_compliance-btn-export").should("be.visible");
  cy.getCy("hr_hiring_compliance-btn-view_feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/13 | 23%] - Saving screenshot for HrHiringComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/13 | 23%] - Verified HrHiringComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/13 | 30%] - Navigating to /staff/hr-hiring-workflow (HrHiringWorkflowScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/13 | 30%] - Checking shell & content for HrHiringWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringworkflow-screen").should("be.visible");
  cy.getCy("hrhiringworkflow-title").should("be.visible");
  cy.getCy("hrhiringworkflow-content").should("be.visible");
  cy.getCy("ta-dashboard-btn-view-details").should("be.visible");
  cy.getCy("ta-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("ta-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/13 | 30%] - Saving screenshot for HrHiringWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/13 | 30%] - Verified HrHiringWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/13 | 38%] - Navigating to /offices/franchise/roles/hr_hiring/applicants (HrHiringApplicantsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/applicants");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/13 | 38%] - Checking shell & content for HrHiringApplicantsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringapplicants-screen").should("be.visible");
  cy.getCy("hrhiringapplicants-title").should("be.visible");
  cy.getCy("hrhiringapplicants-content").should("be.visible");
  cy.getCy("recruitment-kpi-chart").should("be.visible");
  cy.getCy("candidate-pipeline-visualization").should("be.visible");
  cy.getCy("diversity-metrics-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/13 | 38%] - Saving screenshot for HrHiringApplicantsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_applicants");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/13 | 38%] - Verified HrHiringApplicantsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/13 | 46%] - Navigating to /offices/franchise/roles/hr_hiring/interviews (HrHiringInterviewsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/interviews");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/13 | 46%] - Checking shell & content for HrHiringInterviewsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringinterviews-screen").should("be.visible");
  cy.getCy("hrhiringinterviews-title").should("be.visible");
  cy.getCy("hrhiringinterviews-content").should("be.visible");
  cy.getCy("recruitment-kpi-chart").should("be.visible");
  cy.getCy("recruitment-funnel-chart").should("be.visible");
  cy.getCy("diversity-metrics-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/13 | 46%] - Saving screenshot for HrHiringInterviewsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_interviews");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/13 | 46%] - Verified HrHiringInterviewsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/13 | 53%] - Navigating to /offices/franchise/roles/hr_hiring/offers (HrHiringOffersScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/offers");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/13 | 53%] - Checking shell & content for HrHiringOffersScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringoffers-screen").should("be.visible");
  cy.getCy("hrhiringoffers-title").should("be.visible");
  cy.getCy("hrhiringoffers-content").should("be.visible");
  cy.getCy("recruitment-kpi-chart").should("be.visible");
  cy.getCy("candidate-pipeline-chart").should("be.visible");
  cy.getCy("diversity-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/13 | 53%] - Saving screenshot for HrHiringOffersScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_offers");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/13 | 53%] - Verified HrHiringOffersScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/13 | 61%] - Navigating to /offices/franchise/roles/hr_hiring/onboarding (HrHiringOnboardingScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/onboarding");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/13 | 61%] - Checking shell & content for HrHiringOnboardingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringonboarding-screen").should("be.visible");
  cy.getCy("hrhiringonboarding-title").should("be.visible");
  cy.getCy("hrhiringonboarding-content").should("be.visible");
  cy.getCy("ta-dashboard-btn-add-candidate").should("be.visible");
  cy.getCy("ta-dashboard-btn-schedule-interview").should("be.visible");
  cy.getCy("ta-dashboard-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/13 | 61%] - Saving screenshot for HrHiringOnboardingScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_onboarding");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/13 | 61%] - Verified HrHiringOnboardingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/13 | 69%] - Navigating to /offices/franchise/roles/hr_hiring/credentials (HrHiringCredentialsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/credentials");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/13 | 69%] - Checking shell & content for HrHiringCredentialsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcredentials-screen").should("be.visible");
  cy.getCy("hrhiringcredentials-title").should("be.visible");
  cy.getCy("hrhiringcredentials-content").should("be.visible");
  cy.getCy("hr_hiring_btn_add_job").should("be.visible");
  cy.getCy("hr_hiring_btn_view_candidate").should("be.visible");
  cy.getCy("hr_hiring_btn_export_metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/13 | 69%] - Saving screenshot for HrHiringCredentialsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_credentials");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/13 | 69%] - Verified HrHiringCredentialsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/13 | 76%] - Navigating to /staff/applicant-tracking (ApplicantTrackingScreen)...");
  cy.visitWithSemantics("/staff/applicant-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/13 | 76%] - Checking shell & content for ApplicantTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("applicanttracking-screen").should("be.visible");
  cy.getCy("applicanttracking-title").should("be.visible");
  cy.getCy("applicanttracking-content").should("be.visible");
  cy.getCy("applicanttracking-btn-refresh").should("be.visible");
  cy.getCy("applicanttracking-btn-export").should("be.visible");
  cy.getCy("applicanttracking-btn-viewfeedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/13 | 76%] - Saving screenshot for ApplicantTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("applicant_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/13 | 76%] - Verified ApplicantTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [11/13 | 84%] - Navigating to /staff/interview-scheduling (InterviewSchedulingScreen)...");
  cy.visitWithSemantics("/staff/interview-scheduling");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [11/13 | 84%] - Checking shell & content for InterviewSchedulingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("interviewscheduling-screen").should("be.visible");
  cy.getCy("interviewscheduling-title").should("be.visible");
  cy.getCy("interviewscheduling-content").should("be.visible");
  cy.getCy("ta-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("ta-dashboard-btn-update-metrics").should("be.visible");
  cy.getCy("ta-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [11/13 | 84%] - Saving screenshot for InterviewSchedulingScreen...");
  cy.waitAndSee();
  cy.screenshot("interview_scheduling");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [11/13 | 84%] - Verified InterviewSchedulingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [12/13 | 92%] - Navigating to /staff/offer-management (OfferManagementScreen)...");
  cy.visitWithSemantics("/staff/offer-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [12/13 | 92%] - Checking shell & content for OfferManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("offermanagement-screen").should("be.visible");
  cy.getCy("offermanagement-title").should("be.visible");
  cy.getCy("offermanagement-content").should("be.visible");
  cy.getCy("recruitment-metrics-card").should("be.visible");
  cy.getCy("candidate-pipeline-chart").should("be.visible");
  cy.getCy("diversity-metrics-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [12/13 | 92%] - Saving screenshot for OfferManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("offer_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [12/13 | 92%] - Verified OfferManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [13/13 | 100%] - Navigating to /staff/onboarding-checklist (OnboardingChecklistScreen)...");
  cy.visitWithSemantics("/staff/onboarding-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [13/13 | 100%] - Checking shell & content for OnboardingChecklistScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboardingchecklist-screen").should("be.visible");
  cy.getCy("onboardingchecklist-title").should("be.visible");
  cy.getCy("onboardingchecklist-content").should("be.visible");
  cy.getCy("ta-dashboard-kpi-chart").should("be.visible");
  cy.getCy("ta-dashboard-candidate-pipeline").should("be.visible");
  cy.getCy("ta-dashboard-diversity-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [13/13 | 100%] - Saving screenshot for OnboardingChecklistScreen...");
  cy.waitAndSee();
  cy.screenshot("onboarding_checklist");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [13/13 | 100%] - Verified OnboardingChecklistScreen successfully!\n");
  });

  it("tests org role territory_expansion", () => {
    cy.loginAsRole("territory_expansion");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/business_development/roles/territory_expansion_manager/dashboard (TerritoryExpansionManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for TerritoryExpansionManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerdashboard-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-content").should("be.visible");
  cy.getCy("territory-dashboard-kpi").should("be.visible");
  cy.getCy("territory-dashboard-telemetry").should("be.visible");
  cy.getCy("territory-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for TerritoryExpansionManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified TerritoryExpansionManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/territory-expansion-manager-analytics (TerritoryExpansionManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/territory-expansion-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for TerritoryExpansionManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanageranalytics-screen").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-title").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-content").should("be.visible");
  cy.getCy("territory-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("territory-dashboard-btn-update-strategy").should("be.visible");
  cy.getCy("territory-dashboard-btn-train-teams").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for TerritoryExpansionManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified TerritoryExpansionManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/territory-expansion-manager-compliance (TerritoryExpansionManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/territory-expansion-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for TerritoryExpansionManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagercompliance-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-title").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-content").should("be.visible");
  cy.getCy("territory-expansion-btn-generate-report").should("be.visible");
  cy.getCy("territory-expansion-btn-update-strategy").should("be.visible");
  cy.getCy("territory-expansion-btn-request-resources").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for TerritoryExpansionManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified TerritoryExpansionManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/territory-expansion-manager-workflow (TerritoryExpansionManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/territory-expansion-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for TerritoryExpansionManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerworkflow-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerworkflow-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerworkflow-content").should("be.visible");
  cy.getCy("territory-expansion-btn-generate-report").should("be.visible");
  cy.getCy("territory-expansion-btn-update-strategy").should("be.visible");
  cy.getCy("territory-expansion-btn-monitor-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for TerritoryExpansionManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified TerritoryExpansionManagerWorkflowScreen successfully!\n");
  });

  it("tests org role territory_sales", () => {
    cy.loginAsRole("territory_sales");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/marketing/roles/territory_sales_manager/dashboard (TerritorySalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/territory_sales_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for TerritorySalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");
  cy.getCy("dashboard-sales-performance").should("be.visible");
  cy.getCy("dashboard-customer-satisfaction").should("be.visible");
  cy.getCy("dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for TerritorySalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified TerritorySalesManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/territory-sales-manager-analytics (TerritorySalesManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for TerritorySalesManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanageranalytics-screen").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-title").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-content").should("be.visible");
  cy.getCy("territory-sales-manager-btn-generate-report").should("be.visible");
  cy.getCy("territory-sales-manager-btn-view-segmentation").should("be.visible");
  cy.getCy("territory-sales-manager-btn-update-strategy").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for TerritorySalesManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified TerritorySalesManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/territory-sales-manager-compliance (TerritorySalesManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for TerritorySalesManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagercompliance-screen").should("be.visible");
  cy.getCy("territorysalesmanagercompliance-title").should("be.visible");
  cy.getCy("territorysalesmanagercompliance-content").should("be.visible");
  cy.getCy("salesperformance-chart").should("be.visible");
  cy.getCy("clientmanagement-tool").should("be.visible");
  cy.getCy("leadtracking-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for TerritorySalesManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified TerritorySalesManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/territory-sales-manager-workflow (TerritorySalesManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for TerritorySalesManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("territorysalesmanagerworkflow-title").should("be.visible");
  cy.getCy("territorysalesmanagerworkflow-content").should("be.visible");
  cy.getCy("territory-sales-manager-btn-set-targets").should("be.visible");
  cy.getCy("territory-sales-manager-btn-conduct-training").should("be.visible");
  cy.getCy("territory-sales-manager-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for TerritorySalesManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified TerritorySalesManagerWorkflowScreen successfully!\n");
  });

  it("tests org role volunteer_coordinator", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Navigating to /offices/corporate/roles/volunteer_coordinator/dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/volunteer_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");
  cy.getCy("volunteer-dashboard-add-volunteer").should("be.visible");
  cy.getCy("volunteer-dashboard-schedule-shift").should("be.visible");
  cy.getCy("volunteer-dashboard-send-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Navigating to /executive/intake-coordinator-referrals (IntakeCoordinatorReferralsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Checking shell & content for IntakeCoordinatorReferralsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-track-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Saving screenshot for IntakeCoordinatorReferralsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Verified IntakeCoordinatorReferralsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Navigating to /executive/intake-coordinator-new-client-intake (IntakeCoordinatorNewClientIntakeScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Checking shell & content for IntakeCoordinatorNewClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-recruit").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-log-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Saving screenshot for IntakeCoordinatorNewClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Verified IntakeCoordinatorNewClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Navigating to /executive/intake-coordinator-assessment-queue (IntakeCoordinatorAssessmentQueueScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Checking shell & content for IntakeCoordinatorAssessmentQueueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Saving screenshot for IntakeCoordinatorAssessmentQueueScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Verified IntakeCoordinatorAssessmentQueueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Navigating to /executive/intake-coordinator-booking (IntakeCoordinatorBookingScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Checking shell & content for IntakeCoordinatorBookingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-log-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Saving screenshot for IntakeCoordinatorBookingScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Verified IntakeCoordinatorBookingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Navigating to /executive/intake-coordinator-documents (IntakeCoordinatorDocumentsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Checking shell & content for IntakeCoordinatorDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-recruit").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Saving screenshot for IntakeCoordinatorDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Verified IntakeCoordinatorDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Navigating to /executive/intake-coordinator-follow-up (IntakeCoordinatorFollowUpScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Checking shell & content for IntakeCoordinatorFollowUpScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-update").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Saving screenshot for IntakeCoordinatorFollowUpScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Verified IntakeCoordinatorFollowUpScreen successfully!\n");
  });

  it("tests org role premium_concierge", () => {
    cy.loginAsRole("premium_concierge");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /management/premium-concierge-dashboard (PremiumConciergeDashboardScreen)...");
  cy.visitWithSemantics("/management/premium-concierge-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for PremiumConciergeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premiumconciergedashboard-screen").should("be.visible");
  cy.getCy("premiumconciergedashboard-title").should("be.visible");
  cy.getCy("premiumconciergedashboard-content").should("be.visible");
  cy.getCy("premium-concierge-btn-run-compliance-scan").should("be.visible");
  cy.getCy("premium-concierge-btn-sync-security-posture").should("be.visible");
  cy.getCy("premium-concierge-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for PremiumConciergeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("premium_concierge_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified PremiumConciergeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /premium/premium-concierge-analytics (Premium Concierge Care Coordinator Analytics)...");
  cy.visitWithSemantics("/premium/premium-concierge-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Premium Concierge Care Coordinator Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premiumconciergeanalytics-screen").should("be.visible");
  cy.getCy("premiumconciergeanalytics-title").should("be.visible");
  cy.getCy("premiumconciergeanalytics-content").should("be.visible");
  cy.getCy("premium-concierge-btn-refresh").should("be.visible");
  cy.getCy("premium-concierge-btn-run-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Premium Concierge Care Coordinator Analytics...");
  cy.waitAndSee();
  cy.screenshot("premium_concierge_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Premium Concierge Care Coordinator Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /premium/premium-concierge-workflow (Premium Concierge Care Coordinator Compliance Workflow)...");
  cy.visitWithSemantics("/premium/premium-concierge-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Premium Concierge Care Coordinator Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premiumconciergeworkflow-screen").should("be.visible");
  cy.getCy("premiumconciergeworkflow-title").should("be.visible");
  cy.getCy("premiumconciergeworkflow-content").should("be.visible");
  cy.getCy("premium-concierge-btn-quality-verification").should("be.visible");
  cy.getCy("premium-concierge-loading-indicator").should("be.visible");
  cy.getCy("premium-concierge-log-history").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Premium Concierge Care Coordinator Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("premium_concierge_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Premium Concierge Care Coordinator Compliance Workflow successfully!\n");
  });

  it("tests org role vip_manager", () => {
    cy.loginAsRole("vip_manager");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /management/vip-manager-dashboard (VipManagerDashboardScreen)...");
  cy.visitWithSemantics("/management/vip-manager-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for VipManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanagerdashboard-screen").should("be.visible");
  cy.getCy("vipmanagerdashboard-title").should("be.visible");
  cy.getCy("vipmanagerdashboard-content").should("be.visible");
  cy.getCy("vipmanager-btn-compliance-scan").should("be.visible");
  cy.getCy("vipmanager-btn-log-touchpoint").should("be.visible");
  cy.getCy("vipmanager-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for VipManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("vip_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified VipManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /executive/vip-manager-analytics (VIP Client Manager Analytics)...");
  cy.visitWithSemantics("/executive/vip-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for VIP Client Manager Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanageranalytics-screen").should("be.visible");
  cy.getCy("vipmanageranalytics-title").should("be.visible");
  cy.getCy("vipmanageranalytics-content").should("be.visible");
  cy.getCy("vip-dashboard-btn-send-feedback").should("be.visible");
  cy.getCy("vip-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("vip-dashboard-btn-execute-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for VIP Client Manager Analytics...");
  cy.waitAndSee();
  cy.screenshot("vip_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified VIP Client Manager Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /executive/vip-manager-workflow (VIP Client Manager Compliance Workflow)...");
  cy.visitWithSemantics("/executive/vip-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for VIP Client Manager Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanagerworkflow-screen").should("be.visible");
  cy.getCy("vipmanagerworkflow-title").should("be.visible");
  cy.getCy("vipmanagerworkflow-content").should("be.visible");
  cy.getCy("vipmanager-btn-execute-scan").should("be.visible");
  cy.getCy("vipmanager-btn-resolve-issue").should("be.visible");
  cy.getCy("vipmanager-btn-update-dashboard").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for VIP Client Manager Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("vip_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified VIP Client Manager Compliance Workflow successfully!\n");
  });

  it("tests org role psw", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Navigating to /offices/clinical/roles/psw/dashboard (PswDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Checking shell & content for PswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  cy.getCy("pswdashboard-content").should("be.visible");
  cy.getCy("pswdashboard-btn-checkin").should("be.visible");
  cy.getCy("pswdashboard-btn-checkout").should("be.visible");
  cy.getCy("pswdashboard-btn-log-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Saving screenshot for PswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Verified PswDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Navigating to /offices/clinical/roles/psw/reports (PswAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Checking shell & content for PswAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswanalytics-screen").should("be.visible");
  cy.getCy("pswanalytics-title").should("be.visible");
  cy.getCy("pswanalytics-content").should("be.visible");
  cy.getCy("psw-dashboard-btn-log-mood").should("be.visible");
  cy.getCy("psw-dashboard-btn-view-reports").should("be.visible");
  cy.getCy("psw-dashboard-btn-filter").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Saving screenshot for PswAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Verified PswAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Navigating to /offices/clinical/roles/psw/patient-profile (PswClientsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/patient-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Checking shell & content for PswClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclients-screen").should("be.visible");
  cy.getCy("pswclients-title").should("be.visible");
  cy.getCy("pswclients-content").should("be.visible");
  cy.getCy("psw-dashboard-client-list").should("be.visible");
  cy.getCy("psw-dashboard-search-bar").should("be.visible");
  cy.getCy("psw-dashboard-filter-options").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Saving screenshot for PswClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_clients");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Verified PswClientsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Navigating to /offices/clinical/roles/psw/help-support (PswComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/help-support");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Checking shell & content for PswComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcompliance-screen").should("be.visible");
  cy.getCy("pswcompliance-title").should("be.visible");
  cy.getCy("pswcompliance-content").should("be.visible");
  cy.getCy("psw-dashboard-btn-view-schedule").should("be.visible");
  cy.getCy("psw-dashboard-btn-report-issue").should("be.visible");
  cy.getCy("psw-dashboard-btn-log-activity").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Saving screenshot for PswComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Verified PswComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Navigating to /offices/clinical/roles/psw/notifications (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/notifications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");
  cy.getCy("pswdashboard-btn-update-health-status").should("be.visible");
  cy.getCy("pswdashboard-btn-log-activity").should("be.visible");
  cy.getCy("pswdashboard-btn-report-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Verified PswMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Navigating to /offices/clinical/roles/psw/check-in (PswShiftTrackerScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/check-in");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Checking shell & content for PswShiftTrackerScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswshifttracker-screen").should("be.visible");
  cy.getCy("pswshifttracker-title").should("be.visible");
  cy.getCy("pswshifttracker-content").should("be.visible");
  cy.getCy("psw-btn-clockin").should("be.visible");
  cy.getCy("psw-btn-clockout").should("be.visible");
  cy.getCy("psw-btn-complete-task").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Saving screenshot for PswShiftTrackerScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_shift_tracker");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Verified PswShiftTrackerScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Navigating to /offices/clinical/roles/psw/visit-checklist (PswTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Checking shell & content for PswTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswtasks-screen").should("be.visible");
  cy.getCy("pswtasks-title").should("be.visible");
  cy.getCy("pswtasks-content").should("be.visible");
  cy.getCy("psw-tasks-complete").should("be.visible");
  cy.getCy("psw-alert-high-priority").should("be.visible");
  cy.getCy("psw-client-notes").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Saving screenshot for PswTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Verified PswTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");
  cy.getCy("psw-dashboard-client-overview").should("be.visible");
  cy.getCy("psw-dashboard-appointment-alert").should("be.visible");
  cy.getCy("psw-dashboard-activity-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Verified PswVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Navigating to /offices/clinical/roles/psw/psw-workflow (PswWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Checking shell & content for PswWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswworkflow-screen").should("be.visible");
  cy.getCy("pswworkflow-title").should("be.visible");
  cy.getCy("pswworkflow-content").should("be.visible");
  cy.getCy("psw-btn-clockin").should("be.visible");
  cy.getCy("psw-btn-clockout").should("be.visible");
  cy.getCy("psw-btn-submitADLs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Saving screenshot for PswWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Verified PswWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Navigating to /offices/clinical/roles/psw/system-logs (PswCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/system-logs");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Checking shell & content for PswCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcommandcenter-screen").should("be.visible");
  cy.getCy("pswcommandcenter-title").should("be.visible");
  cy.getCy("pswcommandcenter-content").should("be.visible");
  cy.getCy("psw-dashboard-client-overview").should("be.visible");
  cy.getCy("psw-dashboard-compliance-status").should("be.visible");
  cy.getCy("psw-dashboard-care-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Saving screenshot for PswCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Verified PswCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Navigating to /offices/clinical/roles/psw/psw-my-shifts (PswMyShiftsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-my-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Checking shell & content for PswMyShiftsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmyshifts-screen").should("be.visible");
  cy.getCy("pswmyshifts-title").should("be.visible");
  cy.getCy("pswmyshifts-content").should("be.visible");
  cy.getCy("psw-dashboard-btn-view-shift").should("be.visible");
  cy.getCy("psw-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("psw-dashboard-btn-update-health").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Saving screenshot for PswMyShiftsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Verified PswMyShiftsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Navigating to /offices/clinical/roles/psw/profile (PswClientProfileScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Checking shell & content for PswClientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclientprofile-screen").should("be.visible");
  cy.getCy("pswclientprofile-title").should("be.visible");
  cy.getCy("pswclientprofile-content").should("be.visible");
  cy.getCy("psw-status-update-btn").should("be.visible");
  cy.getCy("psw-charting-complete-btn").should("be.visible");
  cy.getCy("psw-certification-add-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Saving screenshot for PswClientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_client_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Verified PswClientProfileScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Verified PswVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Navigating to /offices/clinical/roles/psw/observation-vitals-log (PswVitalsLogScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/observation-vitals-log");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Checking shell & content for PswVitalsLogScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvitalslog-screen").should("be.visible");
  cy.getCy("pswvitalslog-title").should("be.visible");
  cy.getCy("pswvitalslog-content").should("be.visible");
  cy.getCy("psw-dashboard-client-overview").should("be.visible");
  cy.getCy("psw-dashboard-vital-signs").should("be.visible");
  cy.getCy("psw-dashboard-medication-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Saving screenshot for PswVitalsLogScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Verified PswVitalsLogScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Navigating to /offices/clinical/roles/psw/incident-report (PswIncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Checking shell & content for PswIncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswincidentreport-screen").should("be.visible");
  cy.getCy("pswincidentreport-title").should("be.visible");
  cy.getCy("pswincidentreport-content").should("be.visible");
  cy.getCy("psw-dashboard-btn-report-incident").should("be.visible");
  cy.getCy("psw-dashboard-btn-update-health-status").should("be.visible");
  cy.getCy("psw-dashboard-btn-view-compliance-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Saving screenshot for PswIncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Verified PswIncidentReportScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Navigating to /offices/clinical/roles/psw/care-plan (PswCarePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Checking shell & content for PswCarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcareplan-screen").should("be.visible");
  cy.getCy("pswcareplan-title").should("be.visible");
  cy.getCy("pswcareplan-content").should("be.visible");
  cy.getCy("psw-tasklist").should("be.visible");
  cy.getCy("psw-health-status").should("be.visible");
  cy.getCy("psw-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Saving screenshot for PswCarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_care_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Verified PswCarePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Navigating to /offices/clinical/roles/psw/messages (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Verified PswMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Navigating to /offices/clinical/roles/psw/documents (PswDocumentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Checking shell & content for PswDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdocuments-screen").should("be.visible");
  cy.getCy("pswdocuments-title").should("be.visible");
  cy.getCy("pswdocuments-content").should("be.visible");
  cy.getCy("psw-dashboard-client-overview").should("be.visible");
  cy.getCy("psw-dashboard-health-status").should("be.visible");
  cy.getCy("psw-dashboard-activity-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Saving screenshot for PswDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Verified PswDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Navigating to /offices/clinical/roles/psw/shift-tasks (ShiftTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/shift-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Checking shell & content for ShiftTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shifttasks-screen").should("be.visible");
  cy.getCy("shifttasks-title").should("be.visible");
  cy.getCy("shifttasks-content").should("be.visible");
  cy.getCy("pswdashboard-client-overview").should("be.visible");
  cy.getCy("pswdashboard-health-status").should("be.visible");
  cy.getCy("pswdashboard-activity-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Saving screenshot for ShiftTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("shift_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Verified ShiftTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Navigating to /offices/clinical/roles/psw/vitals-entry (VitalsEntryScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/vitals-entry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Checking shell & content for VitalsEntryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalsentry-screen").should("be.visible");
  cy.getCy("vitalsentry-title").should("be.visible");
  cy.getCy("vitalsentry-content").should("be.visible");
  cy.getCy("pswdashboard-btn-logvitals").should("be.visible");
  cy.getCy("pswdashboard-btn-addcarenote").should("be.visible");
  cy.getCy("pswdashboard-btn-sendmessage").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Saving screenshot for VitalsEntryScreen...");
  cy.waitAndSee();
  cy.screenshot("vitals_entry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Verified VitalsEntryScreen successfully!\n");
  });

  it("tests org role hsw", () => {
    cy.loginAsRole("hsw");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Navigating to /clinical/hsw-dashboard (HswDashboardScreen)...");
  cy.visitWithSemantics("/clinical/hsw-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Checking shell & content for HswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswdashboard-screen").should("be.visible");
  cy.getCy("hswdashboard-title").should("be.visible");
  cy.getCy("hswdashboard-content").should("be.visible");
  cy.getCy("pswdashboard-btn-checkin").should("be.visible");
  cy.getCy("pswdashboard-btn-checkout").should("be.visible");
  cy.getCy("pswdashboard-btn-emergency").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Saving screenshot for HswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Verified HswDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Navigating to /clinical/hsw-adl-logger (HswAdlLoggerScreen)...");
  cy.visitWithSemantics("/clinical/hsw-adl-logger");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Checking shell & content for HswAdlLoggerScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswadllogger-screen").should("be.visible");
  cy.getCy("hswadllogger-title").should("be.visible");
  cy.getCy("hswadllogger-content").should("be.visible");
  cy.getCy("adl-log-save-draft").should("be.visible");
  cy.getCy("adl-log-submit").should("be.visible");
  cy.getCy("adl-log-view-drafts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Saving screenshot for HswAdlLoggerScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_adl_logger");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Verified HswAdlLoggerScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Navigating to /clinical/hsw-care-plans (HswCarePlansScreen)...");
  cy.visitWithSemantics("/clinical/hsw-care-plans");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Checking shell & content for HswCarePlansScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswcareplans-screen").should("be.visible");
  cy.getCy("hswcareplans-title").should("be.visible");
  cy.getCy("hswcareplans-content").should("be.visible");
  cy.getCy("pswdashboard-btn-record-progress").should("be.visible");
  cy.getCy("pswdashboard-btn-send-reminder").should("be.visible");
  cy.getCy("pswdashboard-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Saving screenshot for HswCarePlansScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_care_plans");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Verified HswCarePlansScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Navigating to /clinical/hsw-incident-reports (HswIncidentReportsScreen)...");
  cy.visitWithSemantics("/clinical/hsw-incident-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Checking shell & content for HswIncidentReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswincidentreports-screen").should("be.visible");
  cy.getCy("hswincidentreports-title").should("be.visible");
  cy.getCy("hswincidentreports-content").should("be.visible");
  cy.getCy("incident-report-btn").should("be.visible");
  cy.getCy("health-status-update-btn").should("be.visible");
  cy.getCy("care-plan-access-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Saving screenshot for HswIncidentReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_incident_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Verified HswIncidentReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Navigating to /clinical/hsw-schedule (HswScheduleScreen)...");
  cy.visitWithSemantics("/clinical/hsw-schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Checking shell & content for HswScheduleScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswschedule-screen").should("be.visible");
  cy.getCy("hswschedule-title").should("be.visible");
  cy.getCy("hswschedule-content").should("be.visible");
  cy.getCy("hsw-schedule-btn-swap").should("be.visible");
  cy.getCy("hsw-schedule-btn-log-mileage").should("be.visible");
  cy.getCy("hsw-schedule-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Saving screenshot for HswScheduleScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Verified HswScheduleScreen successfully!\n");
  });

  it("tests org role rn_field_supervisor", () => {
    cy.loginAsRole("rn_field_supervisor");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for RnFieldSupervisorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");
  cy.getCy("rnfdashboard-btn-submit-audit").should("be.visible");
  cy.getCy("rnfdashboard-btn-update-policy").should("be.visible");
  cy.getCy("rnfdashboard-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for RnFieldSupervisorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified RnFieldSupervisorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /rn/rn-field-supervisor-analytics (Registered Nurse (RN) Field Supervisor Analytics)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Registered Nurse (RN) Field Supervisor Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisoranalytics-screen").should("be.visible");
  cy.getCy("rnfieldsupervisoranalytics-title").should("be.visible");
  cy.getCy("rnfieldsupervisoranalytics-content").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-view-metrics").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-report-incident").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-log-visit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Registered Nurse (RN) Field Supervisor Analytics...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Registered Nurse (RN) Field Supervisor Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /rn/rn-field-supervisor-workflow (Registered Nurse (RN) Field Supervisor Compliance Workflow)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Registered Nurse (RN) Field Supervisor Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisorworkflow-screen").should("be.visible");
  cy.getCy("rnfieldsupervisorworkflow-title").should("be.visible");
  cy.getCy("rnfieldsupervisorworkflow-content").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-submit-compliance").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-request-training").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-log-field-visit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Registered Nurse (RN) Field Supervisor Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Registered Nurse (RN) Field Supervisor Compliance Workflow successfully!\n");
  });

  it("tests org role np", () => {
    cy.loginAsRole("np");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /clinical/np-dashboard (NpDashboardScreen)...");
  cy.visitWithSemantics("/clinical/np-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for NpDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npdashboard-screen").should("be.visible");
  cy.getCy("npdashboard-title").should("be.visible");
  cy.getCy("npdashboard-content").should("be.visible");
  cy.getCy("npdashboard-btn-view-records").should("be.visible");
  cy.getCy("npdashboard-btn-log-activity").should("be.visible");
  cy.getCy("npdashboard-btn-send-referral").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for NpDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("np_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified NpDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /rn/np-analytics (Nurse Practitioner (NP) Analytics)...");
  cy.visitWithSemantics("/rn/np-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Nurse Practitioner (NP) Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npanalytics-screen").should("be.visible");
  cy.getCy("npanalytics-title").should("be.visible");
  cy.getCy("npanalytics-content").should("be.visible");
  cy.getCy("np-dashboard-btn-view-records").should("be.visible");
  cy.getCy("np-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("np-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Nurse Practitioner (NP) Analytics...");
  cy.waitAndSee();
  cy.screenshot("np_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Nurse Practitioner (NP) Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /rn/np-workflow (Nurse Practitioner (NP) Compliance Workflow)...");
  cy.visitWithSemantics("/rn/np-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Nurse Practitioner (NP) Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npworkflow-screen").should("be.visible");
  cy.getCy("npworkflow-title").should("be.visible");
  cy.getCy("npworkflow-content").should("be.visible");
  cy.getCy("npworkflow-btn-submit-assessment").should("be.visible");
  cy.getCy("npworkflow-btn-update-care-plan").should("be.visible");
  cy.getCy("npworkflow-btn-prescribe-medication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Nurse Practitioner (NP) Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("np_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Nurse Practitioner (NP) Compliance Workflow successfully!\n");
  });

  it("tests org role rpn", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /offices/clinical/roles/rpn/dashboard (RpnDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for RpnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpndashboard-screen").should("be.visible");
  cy.getCy("rpndashboard-title").should("be.visible");
  cy.getCy("rpndashboard-content").should("be.visible");
  cy.getCy("rpn-dashboard-vital-signs").should("be.visible");
  cy.getCy("rpn-dashboard-alerts").should("be.visible");
  cy.getCy("rpn-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for RpnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified RpnDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /offices/clinical/roles/rpn/rpn-analytics (RpnAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for RpnAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnanalytics-screen").should("be.visible");
  cy.getCy("rpnanalytics-title").should("be.visible");
  cy.getCy("rpnanalytics-content").should("be.visible");
  cy.getCy("rpn-dashboard-log-vital-signs").should("be.visible");
  cy.getCy("rpn-dashboard-administer-immunization").should("be.visible");
  cy.getCy("rpn-dashboard-update-wound-care").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for RpnAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified RpnAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /offices/clinical/roles/rpn/rpn-compliance (RpnComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for RpnComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncompliance-screen").should("be.visible");
  cy.getCy("rpncompliance-title").should("be.visible");
  cy.getCy("rpncompliance-content").should("be.visible");
  cy.getCy("rpn-vitals-monitor").should("be.visible");
  cy.getCy("rpn-medication-admin").should("be.visible");
  cy.getCy("rpn-incident-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for RpnComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified RpnComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /offices/clinical/roles/rpn/rpn-workflow (RpnWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for RpnWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnworkflow-screen").should("be.visible");
  cy.getCy("rpnworkflow-title").should("be.visible");
  cy.getCy("rpnworkflow-content").should("be.visible");
  cy.getCy("rpn-dashboard-dressing-log").should("be.visible");
  cy.getCy("rpn-dashboard-immunization-summary").should("be.visible");
  cy.getCy("rpn-dashboard-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for RpnWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified RpnWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /offices/clinical/roles/rpn/rpn-command-center (RpnCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for RpnCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncommandcenter-screen").should("be.visible");
  cy.getCy("rpncommandcenter-title").should("be.visible");
  cy.getCy("rpncommandcenter-content").should("be.visible");
  cy.getCy("rpn-dashboard-btn-view-patient").should("be.visible");
  cy.getCy("rpn-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("rpn-dashboard-btn-log-interaction").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for RpnCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified RpnCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /offices/clinical/roles/rpn/patient-charting (RpnPatientChartingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-charting");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for RpnPatientChartingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnpatientcharting-screen").should("be.visible");
  cy.getCy("rpnpatientcharting-title").should("be.visible");
  cy.getCy("rpnpatientcharting-content").should("be.visible");
  cy.getCy("rpn-dashboard-patient-health").should("be.visible");
  cy.getCy("rpn-dashboard-medication-records").should("be.visible");
  cy.getCy("rpn-dashboard-compliance-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for RpnPatientChartingScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_patient_charting");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified RpnPatientChartingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /offices/clinical/roles/rpn/medications (RpnMedicationsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/medications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for RpnMedicationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnmedications-screen").should("be.visible");
  cy.getCy("rpnmedications-title").should("be.visible");
  cy.getCy("rpnmedications-content").should("be.visible");
  cy.getCy("rpn-med-log").should("be.visible");
  cy.getCy("rpn-report-incident").should("be.visible");
  cy.getCy("rpn-vital-signs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for RpnMedicationsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_medications");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified RpnMedicationsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /offices/clinical/roles/rpn/vitals (RpnVitalsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for RpnVitalsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnvitals-screen").should("be.visible");
  cy.getCy("rpnvitals-title").should("be.visible");
  cy.getCy("rpnvitals-content").should("be.visible");
  cy.getCy("rpn-vitals-monitor").should("be.visible");
  cy.getCy("rpn-medication-track").should("be.visible");
  cy.getCy("rpn-careplan-update").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for RpnVitalsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_vitals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified RpnVitalsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /offices/clinical/roles/rpn/rpn-care-plan-review (RpnCarePlanReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-care-plan-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for RpnCarePlanReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncareplanreview-screen").should("be.visible");
  cy.getCy("rpncareplanreview-title").should("be.visible");
  cy.getCy("rpncareplanreview-content").should("be.visible");
  cy.getCy("rpn-dashboard-btn-view-metrics").should("be.visible");
  cy.getCy("rpn-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("rpn-dashboard-btn-view-kpis").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for RpnCarePlanReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_care_plan_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified RpnCarePlanReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /offices/clinical/roles/rpn/rpn-incident-review (RpnIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for RpnIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnincidentreview-screen").should("be.visible");
  cy.getCy("rpnincidentreview-title").should("be.visible");
  cy.getCy("rpnincidentreview-content").should("be.visible");
  cy.getCy("rpn-dashboard-btn-submit-incident").should("be.visible");
  cy.getCy("rpn-dashboard-btn-view-patient").should("be.visible");
  cy.getCy("rpn-dashboard-btn-log-medication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for RpnIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_incident_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified RpnIncidentReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /offices/clinical/roles/rpn/rpn-tasks (RpnTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for RpnTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpntasks-screen").should("be.visible");
  cy.getCy("rpntasks-title").should("be.visible");
  cy.getCy("rpntasks-content").should("be.visible");
  cy.getCy("rpn-tasks-btn-assessment").should("be.visible");
  cy.getCy("rpn-tasks-btn-medication").should("be.visible");
  cy.getCy("rpn-tasks-btn-vitals").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for RpnTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified RpnTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /offices/clinical/roles/rpn/rpn-reports (RpnReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for RpnReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnreports-screen").should("be.visible");
  cy.getCy("rpnreports-title").should("be.visible");
  cy.getCy("rpnreports-content").should("be.visible");
  cy.getCy("rpn-dashboard-vital-signs").should("be.visible");
  cy.getCy("rpn-dashboard-medication-records").should("be.visible");
  cy.getCy("rpn-dashboard-documentation-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for RpnReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified RpnReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /offices/clinical/roles/rpn/nursing-task (NursingTaskScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/nursing-task");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for NursingTaskScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nursingtask-screen").should("be.visible");
  cy.getCy("nursingtask-title").should("be.visible");
  cy.getCy("nursingtask-content").should("be.visible");
  cy.getCy("nursingtask-btn-administer-medication").should("be.visible");
  cy.getCy("nursingtask-btn-document-care").should("be.visible");
  cy.getCy("nursingtask-btn-report-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for NursingTaskScreen...");
  cy.waitAndSee();
  cy.screenshot("nursing_task");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified NursingTaskScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /offices/clinical/roles/rpn/vitals-tracking (VitalsTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for VitalsTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalstracking-screen").should("be.visible");
  cy.getCy("vitalstracking-title").should("be.visible");
  cy.getCy("vitalstracking-content").should("be.visible");
  cy.getCy("vitals-tracking-btn-record-vital-signs").should("be.visible");
  cy.getCy("vitals-tracking-btn-administer-medication").should("be.visible");
  cy.getCy("vitals-tracking-btn-document-care").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for VitalsTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("vitals_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified VitalsTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /offices/clinical/roles/rpn/medication (MedicationScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/medication");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for MedicationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medication-screen").should("be.visible");
  cy.getCy("medication-title").should("be.visible");
  cy.getCy("medication-content").should("be.visible");
  cy.getCy("medication-log").should("be.visible");
  cy.getCy("vital-sign-trend").should("be.visible");
  cy.getCy("alert-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for MedicationScreen...");
  cy.waitAndSee();
  cy.screenshot("medication");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified MedicationScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /offices/clinical/roles/rpn/patient-observation (PatientObservationScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-observation");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for PatientObservationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientobservation-screen").should("be.visible");
  cy.getCy("patientobservation-title").should("be.visible");
  cy.getCy("patientobservation-content").should("be.visible");
  cy.getCy("patient-observation-vital-signs").should("be.visible");
  cy.getCy("patient-observation-medication-tracker").should("be.visible");
  cy.getCy("patient-observation-daily-activities").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for PatientObservationScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_observation");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified PatientObservationScreen successfully!\n");
  });

  it("tests org role lpn", () => {
    cy.loginAsRole("lpn");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /clinical/lpn-dashboard (LpnDashboardScreen)...");
  cy.visitWithSemantics("/clinical/lpn-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for LpnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpndashboard-screen").should("be.visible");
  cy.getCy("lpndashboard-title").should("be.visible");
  cy.getCy("lpndashboard-content").should("be.visible");
  cy.getCy("lpn-dashboard-vital-signs").should("be.visible");
  cy.getCy("lpn-dashboard-medication-log").should("be.visible");
  cy.getCy("lpn-dashboard-compliance-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for LpnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("lpn_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified LpnDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /rpn/lpn-analytics (Licensed Practical Nurse (LPN) Analytics)...");
  cy.visitWithSemantics("/rpn/lpn-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Licensed Practical Nurse (LPN) Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpnanalytics-screen").should("be.visible");
  cy.getCy("lpnanalytics-title").should("be.visible");
  cy.getCy("lpnanalytics-content").should("be.visible");
  cy.getCy("lpn-dashboard-btn-report-incident").should("be.visible");
  cy.getCy("lpn-dashboard-btn-view-care-plan").should("be.visible");
  cy.getCy("lpn-dashboard-btn-track-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Licensed Practical Nurse (LPN) Analytics...");
  cy.waitAndSee();
  cy.screenshot("lpn_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Licensed Practical Nurse (LPN) Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /rpn/lpn-workflow (Licensed Practical Nurse (LPN) Compliance Workflow)...");
  cy.visitWithSemantics("/rpn/lpn-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Licensed Practical Nurse (LPN) Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpnworkflow-screen").should("be.visible");
  cy.getCy("lpnworkflow-title").should("be.visible");
  cy.getCy("lpnworkflow-content").should("be.visible");
  cy.getCy("lpn-dashboard-btn-update-status").should("be.visible");
  cy.getCy("lpn-dashboard-btn-log-medication").should("be.visible");
  cy.getCy("lpn-dashboard-btn-report-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Licensed Practical Nurse (LPN) Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("lpn_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Licensed Practical Nurse (LPN) Compliance Workflow successfully!\n");
  });

  it("tests org role employee", () => {
    cy.loginAsRole("employee");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /staff/employee-dashboard (EmployeeDashboardScreen)...");
  cy.visitWithSemantics("/staff/employee-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for EmployeeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeedashboard-screen").should("be.visible");
  cy.getCy("employeedashboard-title").should("be.visible");
  cy.getCy("employeedashboard-content").should("be.visible");
  cy.getCy("employee-dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("employee-dashboard-btn-sync-security-posture").should("be.visible");
  cy.getCy("employee-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for EmployeeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("employee_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified EmployeeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /staff/employee-analytics (Employee Analytics)...");
  cy.visitWithSemantics("/staff/employee-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Employee Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeeanalytics-screen").should("be.visible");
  cy.getCy("employeeanalytics-title").should("be.visible");
  cy.getCy("employeeanalytics-content").should("be.visible");
  cy.getCy("employee-analytics-btn-execute-scan").should("be.visible");
  cy.getCy("employee-analytics-btn-refresh-telemetry").should("be.visible");
  cy.getCy("employee-analytics-btn-trigger-governance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Employee Analytics...");
  cy.waitAndSee();
  cy.screenshot("employee_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Employee Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /staff/employee-workflow (Employee Compliance Workflow)...");
  cy.visitWithSemantics("/staff/employee-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Employee Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeeworkflow-screen").should("be.visible");
  cy.getCy("employeeworkflow-title").should("be.visible");
  cy.getCy("employeeworkflow-content").should("be.visible");
  cy.getCy("employee-workflow-btn-execute-scan").should("be.visible");
  cy.getCy("employee-workflow-btn-trigger-action").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Employee Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("employee_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Employee Compliance Workflow successfully!\n");
  });

  it("tests org role volunteer", () => {
    cy.loginAsRole("volunteer");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Navigating to /offices/corporate/roles/volunteer_coordinator/dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/volunteer_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");
  cy.getCy("volunteer-dashboard-add-volunteer").should("be.visible");
  cy.getCy("volunteer-dashboard-schedule-shift").should("be.visible");
  cy.getCy("volunteer-dashboard-send-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Navigating to /staff/volunteer-dashboard (VolunteerDashboardScreen)...");
  cy.visitWithSemantics("/staff/volunteer-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Checking shell & content for VolunteerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteerdashboard-screen").should("be.visible");
  cy.getCy("volunteerdashboard-title").should("be.visible");
  cy.getCy("volunteerdashboard-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-checkin").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-record-visit").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-run-compliance-scan").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Saving screenshot for VolunteerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Verified VolunteerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Navigating to /staff/volunteer-coordinator-analytics (VolunteerCoordinatorAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Checking shell & content for VolunteerCoordinatorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatoranalytics-screen").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-title").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-content").should("be.visible");
  cy.getCy("volunteer-attendance-tracker").should("be.visible");
  cy.getCy("event-participation-stats").should("be.visible");
  cy.getCy("feedback-rating-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Saving screenshot for VolunteerCoordinatorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Verified VolunteerCoordinatorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Navigating to /staff/volunteer-coordinator-compliance (VolunteerCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Checking shell & content for VolunteerCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorcompliance-screen").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-title").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-content").should("be.visible");
  cy.getCy("compliance-status-card").should("be.visible");
  cy.getCy("audit-log-viewer").should("be.visible");
  cy.getCy("training-notification-banner").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Saving screenshot for VolunteerCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Verified VolunteerCoordinatorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Navigating to /staff/volunteer-coordinator-workflow (VolunteerCoordinatorWorkflowScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Checking shell & content for VolunteerCoordinatorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorworkflow-screen").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-title").should("be.visible");
  cy.getCy("volunteercoordinatorworkflow-content").should("be.visible");
  cy.getCy("volunteer-dashboard-refresh").should("be.visible");
  cy.getCy("volunteer-task-execute").should("be.visible");
  cy.getCy("volunteer-sandbox-join").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Saving screenshot for VolunteerCoordinatorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Verified VolunteerCoordinatorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Navigating to /executive/intake-coordinator-referrals (IntakeCoordinatorReferralsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Checking shell & content for IntakeCoordinatorReferralsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-track-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Saving screenshot for IntakeCoordinatorReferralsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Verified IntakeCoordinatorReferralsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Navigating to /executive/intake-coordinator-new-client-intake (IntakeCoordinatorNewClientIntakeScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Checking shell & content for IntakeCoordinatorNewClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-recruit").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-log-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Saving screenshot for IntakeCoordinatorNewClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Verified IntakeCoordinatorNewClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Navigating to /executive/intake-coordinator-assessment-queue (IntakeCoordinatorAssessmentQueueScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Checking shell & content for IntakeCoordinatorAssessmentQueueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Saving screenshot for IntakeCoordinatorAssessmentQueueScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Verified IntakeCoordinatorAssessmentQueueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Navigating to /executive/intake-coordinator-booking (IntakeCoordinatorBookingScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Checking shell & content for IntakeCoordinatorBookingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-log-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Saving screenshot for IntakeCoordinatorBookingScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Verified IntakeCoordinatorBookingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Navigating to /executive/intake-coordinator-documents (IntakeCoordinatorDocumentsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Checking shell & content for IntakeCoordinatorDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-recruit").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Saving screenshot for IntakeCoordinatorDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Verified IntakeCoordinatorDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Navigating to /executive/intake-coordinator-follow-up (IntakeCoordinatorFollowUpScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Checking shell & content for IntakeCoordinatorFollowUpScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-update").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Saving screenshot for IntakeCoordinatorFollowUpScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Verified IntakeCoordinatorFollowUpScreen successfully!\n");
  });

  it("tests org role admin", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /common/office-dashboard (OfficeDashboardScreen)...");
  cy.visitWithSemantics("/common/office-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for OfficeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officedashboard-screen").should("be.visible");
  cy.getCy("officedashboard-title").should("be.visible");
  cy.getCy("officedashboard-content").should("be.visible");
  cy.getCy("office_dashboard-btn-add-task").should("be.visible");
  cy.getCy("office_dashboard-btn-schedule-appointment").should("be.visible");
  cy.getCy("office_dashboard-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for OfficeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("office_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified OfficeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /offices/franchise/roles/billing_admin/dashboard (BillingAdminDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/billing_admin/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for BillingAdminDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmindashboard-screen").should("be.visible");
  cy.getCy("billingadmindashboard-title").should("be.visible");
  cy.getCy("billingadmindashboard-content").should("be.visible");
  cy.getCy("billing-dashboard-status-overview").should("be.visible");
  cy.getCy("billing-dashboard-discrepancy-metrics").should("be.visible");
  cy.getCy("billing-dashboard-activity-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for BillingAdminDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified BillingAdminDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /staff/receptionist-dashboard (ReceptionistDashboardScreen)...");
  cy.visitWithSemantics("/staff/receptionist-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for ReceptionistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistdashboard-screen").should("be.visible");
  cy.getCy("receptionistdashboard-title").should("be.visible");
  cy.getCy("receptionistdashboard-content").should("be.visible");
  cy.getCy("receptionist-dashboard-btn-add-appointment").should("be.visible");
  cy.getCy("receptionist-dashboard-btn-send-message").should("be.visible");
  cy.getCy("receptionist-dashboard-btn-upload-document").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for ReceptionistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified ReceptionistDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /common/office-analytics (OfficeAnalyticsScreen)...");
  cy.visitWithSemantics("/common/office-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for OfficeAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeanalytics-screen").should("be.visible");
  cy.getCy("officeanalytics-title").should("be.visible");
  cy.getCy("officeanalytics-content").should("be.visible");
  cy.getCy("officeanalytics-btn-addtask").should("be.visible");
  cy.getCy("officeanalytics-btn-schedule").should("be.visible");
  cy.getCy("officeanalytics-btn-logcommunication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for OfficeAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("office_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified OfficeAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /common/office-compliance (OfficeComplianceScreen)...");
  cy.visitWithSemantics("/common/office-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for OfficeComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officecompliance-screen").should("be.visible");
  cy.getCy("officecompliance-title").should("be.visible");
  cy.getCy("officecompliance-content").should("be.visible");
  cy.getCy("officecompliance-btn-addtask").should("be.visible");
  cy.getCy("officecompliance-btn-logcommunication").should("be.visible");
  cy.getCy("officecompliance-btn-schedulemeeting").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for OfficeComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("office_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified OfficeComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /common/office-workflow (OfficeWorkflowScreen)...");
  cy.visitWithSemantics("/common/office-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for OfficeWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeworkflow-screen").should("be.visible");
  cy.getCy("officeworkflow-title").should("be.visible");
  cy.getCy("officeworkflow-content").should("be.visible");
  cy.getCy("officeworkflow-btn-add-appointment").should("be.visible");
  cy.getCy("officeworkflow-btn-complete-task").should("be.visible");
  cy.getCy("officeworkflow-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for OfficeWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("office_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified OfficeWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /staff/billing-admin-analytics (BillingAdminAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for BillingAdminAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminanalytics-screen").should("be.visible");
  cy.getCy("billingadminanalytics-title").should("be.visible");
  cy.getCy("billingadminanalytics-content").should("be.visible");
  cy.getCy("billing_admin_btn_add_task").should("be.visible");
  cy.getCy("billing_admin_btn_schedule").should("be.visible");
  cy.getCy("billing_admin_btn_send_message").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for BillingAdminAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified BillingAdminAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /staff/billing-admin-compliance (BillingAdminComplianceScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for BillingAdminComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmincompliance-screen").should("be.visible");
  cy.getCy("billingadmincompliance-title").should("be.visible");
  cy.getCy("billingadmincompliance-content").should("be.visible");
  cy.getCy("billing_admin_btn_add_task").should("be.visible");
  cy.getCy("billing_admin_btn_schedule_appointment").should("be.visible");
  cy.getCy("billing_admin_btn_log_communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for BillingAdminComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified BillingAdminComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /staff/billing-admin-workflow (BillingAdminWorkflowScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for BillingAdminWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminworkflow-screen").should("be.visible");
  cy.getCy("billingadminworkflow-title").should("be.visible");
  cy.getCy("billingadminworkflow-content").should("be.visible");
  cy.getCy("billing_admin_task_management").should("be.visible");
  cy.getCy("billing_admin_calendar").should("be.visible");
  cy.getCy("billing_admin_communication_log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for BillingAdminWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified BillingAdminWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /staff/receptionist-analytics (ReceptionistAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/receptionist-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for ReceptionistAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistanalytics-screen").should("be.visible");
  cy.getCy("receptionistanalytics-title").should("be.visible");
  cy.getCy("receptionistanalytics-content").should("be.visible");
  cy.getCy("receptionist-analytics-btn-add-task").should("be.visible");
  cy.getCy("receptionist-analytics-btn-schedule-appointment").should("be.visible");
  cy.getCy("receptionist-analytics-btn-send-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for ReceptionistAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified ReceptionistAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /staff/receptionist-compliance (ReceptionistComplianceScreen)...");
  cy.visitWithSemantics("/staff/receptionist-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for ReceptionistComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistcompliance-screen").should("be.visible");
  cy.getCy("receptionistcompliance-title").should("be.visible");
  cy.getCy("receptionistcompliance-content").should("be.visible");
  cy.getCy("receptionist-btn-add-appointment").should("be.visible");
  cy.getCy("receptionist-btn-send-email").should("be.visible");
  cy.getCy("receptionist-btn-upload-document").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for ReceptionistComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified ReceptionistComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /staff/receptionist-workflow (ReceptionistWorkflowScreen)...");
  cy.visitWithSemantics("/staff/receptionist-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for ReceptionistWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistworkflow-screen").should("be.visible");
  cy.getCy("receptionistworkflow-title").should("be.visible");
  cy.getCy("receptionistworkflow-content").should("be.visible");
  cy.getCy("admin-dashboard-btn-logcall").should("be.visible");
  cy.getCy("admin-dashboard-btn-schedule").should("be.visible");
  cy.getCy("admin-dashboard-btn-sendemail").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for ReceptionistWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified ReceptionistWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /staff/invoice-management (InvoiceManagementScreen)...");
  cy.visitWithSemantics("/staff/invoice-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for InvoiceManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("invoicemanagement-screen").should("be.visible");
  cy.getCy("invoicemanagement-title").should("be.visible");
  cy.getCy("invoicemanagement-content").should("be.visible");
  cy.getCy("invoice_management-btn-add-task").should("be.visible");
  cy.getCy("invoice_management-btn-schedule-appointment").should("be.visible");
  cy.getCy("invoice_management-btn-upload-document").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for InvoiceManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("invoice_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified InvoiceManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /staff/claims-processing (ClaimsProcessingScreen)...");
  cy.visitWithSemantics("/staff/claims-processing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for ClaimsProcessingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("claimsprocessing-screen").should("be.visible");
  cy.getCy("claimsprocessing-title").should("be.visible");
  cy.getCy("claimsprocessing-content").should("be.visible");
  cy.getCy("claims-processing-btn-add-task").should("be.visible");
  cy.getCy("claims-processing-btn-schedule-appointment").should("be.visible");
  cy.getCy("claims-processing-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for ClaimsProcessingScreen...");
  cy.waitAndSee();
  cy.screenshot("claims_processing");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified ClaimsProcessingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /staff/payment-tracking (PaymentTrackingScreen)...");
  cy.visitWithSemantics("/staff/payment-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for PaymentTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("paymenttracking-screen").should("be.visible");
  cy.getCy("paymenttracking-title").should("be.visible");
  cy.getCy("paymenttracking-content").should("be.visible");
  cy.getCy("paymenttracking-btn-addtask").should("be.visible");
  cy.getCy("paymenttracking-btn-schedulemeeting").should("be.visible");
  cy.getCy("paymenttracking-btn-sendcommunication").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for PaymentTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("payment_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified PaymentTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /staff/refund-management (RefundManagementScreen)...");
  cy.visitWithSemantics("/staff/refund-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for RefundManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("refundmanagement-screen").should("be.visible");
  cy.getCy("refundmanagement-title").should("be.visible");
  cy.getCy("refundmanagement-content").should("be.visible");
  cy.getCy("refundmanagement-btn-addtask").should("be.visible");
  cy.getCy("refundmanagement-btn-schedulemeeting").should("be.visible");
  cy.getCy("refundmanagement-btn-generatereport").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for RefundManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("refund_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified RefundManagementScreen successfully!\n");
  });

  it("tests org role scheduler", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Navigating to /offices/franchise/roles/scheduler/dashboard (SchedulerDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Checking shell & content for SchedulerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerdashboard-screen").should("be.visible");
  cy.getCy("schedulerdashboard-title").should("be.visible");
  cy.getCy("schedulerdashboard-content").should("be.visible");
  cy.getCy("scheduler-dashboard-btn-resolve-conflict").should("be.visible");
  cy.getCy("scheduler-dashboard-btn-optimize-schedule").should("be.visible");
  cy.getCy("scheduler-dashboard-btn-view-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Saving screenshot for SchedulerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Verified SchedulerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Navigating to /staff/coordinator-dispatch-map (CoordinatorDispatchMapScreen)...");
  cy.visitWithSemantics("/staff/coordinator-dispatch-map");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Checking shell & content for CoordinatorDispatchMapScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatordispatchmap-screen").should("be.visible");
  cy.getCy("coordinatordispatchmap-title").should("be.visible");
  cy.getCy("coordinatordispatchmap-content").should("be.visible");
  cy.getCy("coordinator-dispatch-btn-assign-shift").should("be.visible");
  cy.getCy("coordinator-dispatch-btn-send-alert").should("be.visible");
  cy.getCy("coordinator-dispatch-btn-view-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Saving screenshot for CoordinatorDispatchMapScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_dispatch_map");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Verified CoordinatorDispatchMapScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Navigating to /staff/coordinator-hub (CoordinatorHubScreen)...");
  cy.visitWithSemantics("/staff/coordinator-hub");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Checking shell & content for CoordinatorHubScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorhub-screen").should("be.visible");
  cy.getCy("coordinatorhub-title").should("be.visible");
  cy.getCy("coordinatorhub-content").should("be.visible");
  cy.getCy("coordinatorhub-btn-assign-shift").should("be.visible");
  cy.getCy("coordinatorhub-btn-resolve-alert").should("be.visible");
  cy.getCy("coordinatorhub-btn-view-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Saving screenshot for CoordinatorHubScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_hub");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Verified CoordinatorHubScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Navigating to /staff/coordinator-sos (CoordinatorSosScreen)...");
  cy.visitWithSemantics("/staff/coordinator-sos");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Checking shell & content for CoordinatorSosScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorsos-screen").should("be.visible");
  cy.getCy("coordinatorsos-title").should("be.visible");
  cy.getCy("coordinatorsos-content").should("be.visible");
  cy.getCy("coordinator-sos-btn-report-incident").should("be.visible");
  cy.getCy("coordinator-sos-btn-view-performance").should("be.visible");
  cy.getCy("coordinator-sos-btn-update-schedule").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Saving screenshot for CoordinatorSosScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_sos");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Verified CoordinatorSosScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Navigating to /staff/coordinator-waitlist (CoordinatorWaitlistScreen)...");
  cy.visitWithSemantics("/staff/coordinator-waitlist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Checking shell & content for CoordinatorWaitlistScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorwaitlist-screen").should("be.visible");
  cy.getCy("coordinatorwaitlist-title").should("be.visible");
  cy.getCy("coordinatorwaitlist-content").should("be.visible");
  cy.getCy("coordinator-dashboard-btn-update-schedule").should("be.visible");
  cy.getCy("coordinator-dashboard-btn-report-incident").should("be.visible");
  cy.getCy("coordinator-dashboard-btn-order-supplies").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Saving screenshot for CoordinatorWaitlistScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_waitlist");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Verified CoordinatorWaitlistScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Navigating to /staff/scheduler-analytics (SchedulerAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Checking shell & content for SchedulerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleranalytics-screen").should("be.visible");
  cy.getCy("scheduleranalytics-title").should("be.visible");
  cy.getCy("scheduleranalytics-content").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");
  cy.getCy("scheduler-btn-submit-incident").should("be.visible");
  cy.getCy("scheduler-btn-view-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Saving screenshot for SchedulerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Verified SchedulerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Navigating to /staff/scheduler-compliance (SchedulerComplianceScreen)...");
  cy.visitWithSemantics("/staff/scheduler-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Checking shell & content for SchedulerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercompliance-screen").should("be.visible");
  cy.getCy("schedulercompliance-title").should("be.visible");
  cy.getCy("schedulercompliance-content").should("be.visible");
  cy.getCy("scheduler-btn-add-schedule").should("be.visible");
  cy.getCy("scheduler-btn-view-reports").should("be.visible");
  cy.getCy("scheduler-btn-resolve-complaint").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Saving screenshot for SchedulerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Verified SchedulerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Navigating to /staff/scheduler-workflow (SchedulerWorkflowScreen)...");
  cy.visitWithSemantics("/staff/scheduler-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Checking shell & content for SchedulerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerworkflow-screen").should("be.visible");
  cy.getCy("schedulerworkflow-title").should("be.visible");
  cy.getCy("schedulerworkflow-content").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");
  cy.getCy("scheduler-btn-submit-incident").should("be.visible");
  cy.getCy("scheduler-btn-view-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Saving screenshot for SchedulerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Verified SchedulerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Navigating to /staff/scheduler-command-center (SchedulerCommandCenterScreen)...");
  cy.visitWithSemantics("/staff/scheduler-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Checking shell & content for SchedulerCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercommandcenter-screen").should("be.visible");
  cy.getCy("schedulercommandcenter-title").should("be.visible");
  cy.getCy("schedulercommandcenter-content").should("be.visible");
  cy.getCy("scheduler-btn-view-audit").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");
  cy.getCy("scheduler-btn-resolve-complaint").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Saving screenshot for SchedulerCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Verified SchedulerCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Navigating to /staff/scheduler-calendar (SchedulerCalendarScreen)...");
  cy.visitWithSemantics("/staff/scheduler-calendar");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Checking shell & content for SchedulerCalendarScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercalendar-screen").should("be.visible");
  cy.getCy("schedulercalendar-title").should("be.visible");
  cy.getCy("schedulercalendar-content").should("be.visible");
  cy.getCy("scheduler-btn-view-attendance").should("be.visible");
  cy.getCy("scheduler-btn-generate-report").should("be.visible");
  cy.getCy("scheduler-btn-address-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Saving screenshot for SchedulerCalendarScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_calendar");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Verified SchedulerCalendarScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Navigating to /staff/scheduler-booking-requests (SchedulerBookingRequestsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-booking-requests");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Checking shell & content for SchedulerBookingRequestsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerbookingrequests-screen").should("be.visible");
  cy.getCy("schedulerbookingrequests-title").should("be.visible");
  cy.getCy("schedulerbookingrequests-content").should("be.visible");
  cy.getCy("scheduler-btn-view-reports").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");
  cy.getCy("scheduler-btn-resolve-complaint").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Saving screenshot for SchedulerBookingRequestsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_booking_requests");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Verified SchedulerBookingRequestsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Navigating to /staff/scheduler-conflicts (SchedulerConflictsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-conflicts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Checking shell & content for SchedulerConflictsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerconflicts-screen").should("be.visible");
  cy.getCy("schedulerconflicts-title").should("be.visible");
  cy.getCy("schedulerconflicts-content").should("be.visible");
  cy.getCy("scheduler-btn-resolve-conflict").should("be.visible");
  cy.getCy("scheduler-btn-view-performance").should("be.visible");
  cy.getCy("scheduler-btn-submit-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Saving screenshot for SchedulerConflictsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_conflicts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Verified SchedulerConflictsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Navigating to /staff/scheduler-open-shifts (SchedulerOpenShiftsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-open-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Checking shell & content for SchedulerOpenShiftsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleropenshifts-screen").should("be.visible");
  cy.getCy("scheduleropenshifts-title").should("be.visible");
  cy.getCy("scheduleropenshifts-content").should("be.visible");
  cy.getCy("scheduler-btn-view-performance").should("be.visible");
  cy.getCy("scheduler-btn-conduct-audit").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Saving screenshot for SchedulerOpenShiftsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_open_shifts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Verified SchedulerOpenShiftsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Navigating to /staff/scheduler-provider-availability (SchedulerProviderAvailabilityScreen)...");
  cy.visitWithSemantics("/staff/scheduler-provider-availability");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Checking shell & content for SchedulerProviderAvailabilityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerprovideravailability-screen").should("be.visible");
  cy.getCy("schedulerprovideravailability-title").should("be.visible");
  cy.getCy("schedulerprovideravailability-content").should("be.visible");
  cy.getCy("scheduler-btn-view-schedule").should("be.visible");
  cy.getCy("scheduler-btn-report-issue").should("be.visible");
  cy.getCy("scheduler-btn-track-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Saving screenshot for SchedulerProviderAvailabilityScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_provider_availability");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Verified SchedulerProviderAvailabilityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Navigating to /staff/scheduling-dashboard (SchedulingDashboardScreen)...");
  cy.visitWithSemantics("/staff/scheduling-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Checking shell & content for SchedulingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingdashboard-screen").should("be.visible");
  cy.getCy("schedulingdashboard-title").should("be.visible");
  cy.getCy("schedulingdashboard-content").should("be.visible");
  cy.getCy("scheduling-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("scheduling-dashboard-btn-send-update").should("be.visible");
  cy.getCy("scheduling-dashboard-btn-log-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Saving screenshot for SchedulingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Verified SchedulingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Navigating to /staff/calendar-management (CalendarManagementScreen)...");
  cy.visitWithSemantics("/staff/calendar-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Checking shell & content for CalendarManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("calendarmanagement-screen").should("be.visible");
  cy.getCy("calendarmanagement-title").should("be.visible");
  cy.getCy("calendarmanagement-content").should("be.visible");
  cy.getCy("calendar_management-btn-update-schedule").should("be.visible");
  cy.getCy("calendar_management-btn-log-incident").should("be.visible");
  cy.getCy("calendar_management-btn-view-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Saving screenshot for CalendarManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("calendar_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Verified CalendarManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Navigating to /staff/conflict-resolution (ConflictResolutionScreen)...");
  cy.visitWithSemantics("/staff/conflict-resolution");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Checking shell & content for ConflictResolutionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("conflictresolution-screen").should("be.visible");
  cy.getCy("conflictresolution-title").should("be.visible");
  cy.getCy("conflictresolution-content").should("be.visible");
  cy.getCy("shift-supervisor-btn-add-incident").should("be.visible");
  cy.getCy("shift-supervisor-btn-resolve-conflict").should("be.visible");
  cy.getCy("shift-supervisor-btn-schedule-meeting").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Saving screenshot for ConflictResolutionScreen...");
  cy.waitAndSee();
  cy.screenshot("conflict_resolution");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Verified ConflictResolutionScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Navigating to /staff/open-shift (OpenShiftScreen)...");
  cy.visitWithSemantics("/staff/open-shift");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Checking shell & content for OpenShiftScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("openshift-screen").should("be.visible");
  cy.getCy("openshift-title").should("be.visible");
  cy.getCy("openshift-content").should("be.visible");
  cy.getCy("shift-dashboard-btn-view-performance").should("be.visible");
  cy.getCy("shift-dashboard-btn-report-incident").should("be.visible");
  cy.getCy("shift-dashboard-btn-schedule-shift").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Saving screenshot for OpenShiftScreen...");
  cy.waitAndSee();
  cy.screenshot("open_shift");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Verified OpenShiftScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Navigating to /staff/scheduling-operations4-k (SchedulingOperations4KScreen)...");
  cy.visitWithSemantics("/staff/scheduling-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Checking shell & content for SchedulingOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingoperations4k-screen").should("be.visible");
  cy.getCy("schedulingoperations4k-title").should("be.visible");
  cy.getCy("schedulingoperations4k-content").should("be.visible");
  cy.getCy("scheduling-overview").should("be.visible");
  cy.getCy("incident-log").should("be.visible");
  cy.getCy("customer-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Saving screenshot for SchedulingOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Verified SchedulingOperations4KScreen successfully!\n");
  });

  it("tests org role customer_support", () => {
    cy.loginAsRole("customer_support");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/10 | 10%] - Navigating to /common/customer-support-analytics (CustomerSupportAnalyticsScreen)...");
  cy.visitWithSemantics("/common/customer-support-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/10 | 10%] - Checking shell & content for CustomerSupportAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportanalytics-screen").should("be.visible");
  cy.getCy("customersupportanalytics-title").should("be.visible");
  cy.getCy("customersupportanalytics-content").should("be.visible");
  cy.getCy("customer-support-btn-respond").should("be.visible");
  cy.getCy("customer-support-btn-escalate").should("be.visible");
  cy.getCy("customer-support-btn-update-kb").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/10 | 10%] - Saving screenshot for CustomerSupportAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("customer_support_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/10 | 10%] - Verified CustomerSupportAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/10 | 20%] - Navigating to /common/customer-support-compliance (CustomerSupportComplianceScreen)...");
  cy.visitWithSemantics("/common/customer-support-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/10 | 20%] - Checking shell & content for CustomerSupportComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportcompliance-screen").should("be.visible");
  cy.getCy("customersupportcompliance-title").should("be.visible");
  cy.getCy("customersupportcompliance-content").should("be.visible");
  cy.getCy("customer-support-btn-respond").should("be.visible");
  cy.getCy("customer-support-btn-audit").should("be.visible");
  cy.getCy("customer-support-btn-update-security").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/10 | 20%] - Saving screenshot for CustomerSupportComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("customer_support_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/10 | 20%] - Verified CustomerSupportComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/10 | 30%] - Navigating to /common/customer-support-workflow (CustomerSupportWorkflowScreen)...");
  cy.visitWithSemantics("/common/customer-support-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/10 | 30%] - Checking shell & content for CustomerSupportWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportworkflow-screen").should("be.visible");
  cy.getCy("customersupportworkflow-title").should("be.visible");
  cy.getCy("customersupportworkflow-content").should("be.visible");
  cy.getCy("support-dashboard-ticket-status").should("be.visible");
  cy.getCy("support-dashboard-feedback").should("be.visible");
  cy.getCy("support-dashboard-response-time").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/10 | 30%] - Saving screenshot for CustomerSupportWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("customer_support_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/10 | 30%] - Verified CustomerSupportWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/10 | 40%] - Navigating to /common/support-analytics (SupportAnalyticsScreen)...");
  cy.visitWithSemantics("/common/support-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/10 | 40%] - Checking shell & content for SupportAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportanalytics-screen").should("be.visible");
  cy.getCy("supportanalytics-title").should("be.visible");
  cy.getCy("supportanalytics-content").should("be.visible");
  cy.getCy("support-analytics-btn-follow-up").should("be.visible");
  cy.getCy("support-analytics-btn-gather-feedback").should("be.visible");
  cy.getCy("support-analytics-btn-train-staff").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/10 | 40%] - Saving screenshot for SupportAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("support_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/10 | 40%] - Verified SupportAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/10 | 50%] - Navigating to /common/support-compliance (SupportComplianceScreen)...");
  cy.visitWithSemantics("/common/support-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/10 | 50%] - Checking shell & content for SupportComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportcompliance-screen").should("be.visible");
  cy.getCy("supportcompliance-title").should("be.visible");
  cy.getCy("supportcompliance-content").should("be.visible");
  cy.getCy("support-btn-log-interaction").should("be.visible");
  cy.getCy("support-btn-conduct-audit").should("be.visible");
  cy.getCy("support-btn-provide-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/10 | 50%] - Saving screenshot for SupportComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("support_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/10 | 50%] - Verified SupportComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/10 | 60%] - Navigating to /common/support-workflow (SupportWorkflowScreen)...");
  cy.visitWithSemantics("/common/support-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/10 | 60%] - Checking shell & content for SupportWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportworkflow-screen").should("be.visible");
  cy.getCy("supportworkflow-title").should("be.visible");
  cy.getCy("supportworkflow-content").should("be.visible");
  cy.getCy("support-dashboard-ticket-overview").should("be.visible");
  cy.getCy("support-dashboard-response-time").should("be.visible");
  cy.getCy("support-dashboard-customer-satisfaction").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/10 | 60%] - Saving screenshot for SupportWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("support_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/10 | 60%] - Verified SupportWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/10 | 70%] - Navigating to /staff/ticket-management (TicketManagementScreen)...");
  cy.visitWithSemantics("/staff/ticket-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/10 | 70%] - Checking shell & content for TicketManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ticketmanagement-screen").should("be.visible");
  cy.getCy("ticketmanagement-title").should("be.visible");
  cy.getCy("ticketmanagement-content").should("be.visible");
  cy.getCy("ticket-status-overview").should("be.visible");
  cy.getCy("response-time-chart").should("be.visible");
  cy.getCy("customer-satisfaction-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/10 | 70%] - Saving screenshot for TicketManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("ticket_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/10 | 70%] - Verified TicketManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/10 | 80%] - Navigating to /staff/client-issue (ClientIssueScreen)...");
  cy.visitWithSemantics("/staff/client-issue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/10 | 80%] - Checking shell & content for ClientIssueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientissue-screen").should("be.visible");
  cy.getCy("clientissue-title").should("be.visible");
  cy.getCy("clientissue-content").should("be.visible");
  cy.getCy("support-dashboard-btn-respond").should("be.visible");
  cy.getCy("support-dashboard-btn-escalate").should("be.visible");
  cy.getCy("support-dashboard-btn-document").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/10 | 80%] - Saving screenshot for ClientIssueScreen...");
  cy.waitAndSee();
  cy.screenshot("client_issue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/10 | 80%] - Verified ClientIssueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [9/10 | 90%] - Navigating to /staff/communication (CommunicationScreen)...");
  cy.visitWithSemantics("/staff/communication");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [9/10 | 90%] - Checking shell & content for CommunicationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communication-screen").should("be.visible");
  cy.getCy("communication-title").should("be.visible");
  cy.getCy("communication-content").should("be.visible");
  cy.getCy("support-dashboard-btn-refresh").should("be.visible");
  cy.getCy("support-dashboard-btn-export").should("be.visible");
  cy.getCy("support-dashboard-btn-assign").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [9/10 | 90%] - Saving screenshot for CommunicationScreen...");
  cy.waitAndSee();
  cy.screenshot("communication");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [9/10 | 90%] - Verified CommunicationScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [10/10 | 100%] - Navigating to /staff/resolution-tracking (ResolutionTrackingScreen)...");
  cy.visitWithSemantics("/staff/resolution-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [10/10 | 100%] - Checking shell & content for ResolutionTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("resolutiontracking-screen").should("be.visible");
  cy.getCy("resolutiontracking-title").should("be.visible");
  cy.getCy("resolutiontracking-content").should("be.visible");
  cy.getCy("support-btn-respond").should("be.visible");
  cy.getCy("support-btn-followup").should("be.visible");
  cy.getCy("support-btn-escalate").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [10/10 | 100%] - Saving screenshot for ResolutionTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("resolution_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [10/10 | 100%] - Verified ResolutionTrackingScreen successfully!\n");
  });

  it("tests org role training_coordinator", () => {
    cy.loginAsRole("training_coordinator");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /staff/training-dashboard (TrainingDashboardScreen)...");
  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for TrainingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");
  cy.getCy("training-dashboard-btn-add-session").should("be.visible");
  cy.getCy("training-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("training-dashboard-btn-send-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for TrainingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified TrainingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /staff/course-assignment (CourseAssignmentScreen)...");
  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for CourseAssignmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");
  cy.getCy("training-dashboard-metrics").should("be.visible");
  cy.getCy("training-feedback-submit").should("be.visible");
  cy.getCy("training-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for CourseAssignmentScreen...");
  cy.waitAndSee();
  cy.screenshot("course_assignment");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified CourseAssignmentScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /staff/certification-tracking (CertificationTrackingScreen)...");
  cy.visitWithSemantics("/staff/certification-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for CertificationTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");
  cy.getCy("training-session-overview").should("be.visible");
  cy.getCy("participation-metrics-chart").should("be.visible");
  cy.getCy("feedback-evaluation-card").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for CertificationTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("certification_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified CertificationTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /staff/staff-progress (StaffProgressScreen)...");
  cy.visitWithSemantics("/staff/staff-progress");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for StaffProgressScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");
  cy.getCy("training-overview").should("be.visible");
  cy.getCy("engagement-metrics").should("be.visible");
  cy.getCy("feedback-results").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for StaffProgressScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_progress");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified StaffProgressScreen successfully!\n");
  });

  it("tests org role qa_specialist", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/10 | 10%] - Navigating to /common/qa-analytics (QaAnalyticsScreen)...");
  cy.visitWithSemantics("/common/qa-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/10 | 10%] - Checking shell & content for QaAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaanalytics-screen").should("be.visible");
  cy.getCy("qaanalytics-title").should("be.visible");
  cy.getCy("qaanalytics-content").should("be.visible");
  cy.getCy("qa-dashboard-testcase-status").should("be.visible");
  cy.getCy("qa-dashboard-defect-metrics").should("be.visible");
  cy.getCy("qa-dashboard-testcoverage").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/10 | 10%] - Saving screenshot for QaAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/10 | 10%] - Verified QaAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/10 | 20%] - Navigating to /common/qa-compliance (QaComplianceScreen)...");
  cy.visitWithSemantics("/common/qa-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/10 | 20%] - Checking shell & content for QaComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qacompliance-screen").should("be.visible");
  cy.getCy("qacompliance-title").should("be.visible");
  cy.getCy("qacompliance-content").should("be.visible");
  cy.getCy("qa-compliance-status-indicator").should("be.visible");
  cy.getCy("qa-audit-log-table").should("be.visible");
  cy.getCy("qa-compliance-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/10 | 20%] - Saving screenshot for QaComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/10 | 20%] - Verified QaComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/10 | 30%] - Navigating to /common/qa-workflow (QaWorkflowScreen)...");
  cy.visitWithSemantics("/common/qa-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/10 | 30%] - Checking shell & content for QaWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaworkflow-screen").should("be.visible");
  cy.getCy("qaworkflow-title").should("be.visible");
  cy.getCy("qaworkflow-content").should("be.visible");
  cy.getCy("qa-tasklist").should("be.visible");
  cy.getCy("qa-defect-tracker").should("be.visible");
  cy.getCy("qa-test-coverage-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/10 | 30%] - Saving screenshot for QaWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/10 | 30%] - Verified QaWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/10 | 40%] - Navigating to /staff/quality-assurance-analytics (QualityAssuranceAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/10 | 40%] - Checking shell & content for QualityAssuranceAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceanalytics-screen").should("be.visible");
  cy.getCy("qualityassuranceanalytics-title").should("be.visible");
  cy.getCy("qualityassuranceanalytics-content").should("be.visible");
  cy.getCy("qa-dashboard-btn-view-test-plans").should("be.visible");
  cy.getCy("qa-dashboard-btn-run-tests").should("be.visible");
  cy.getCy("qa-dashboard-btn-log-defect").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/10 | 40%] - Saving screenshot for QualityAssuranceAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [4/10 | 40%] - Verified QualityAssuranceAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/10 | 50%] - Navigating to /staff/quality-assurance-compliance (QualityAssuranceComplianceScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/10 | 50%] - Checking shell & content for QualityAssuranceComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecompliance-screen").should("be.visible");
  cy.getCy("qualityassurancecompliance-title").should("be.visible");
  cy.getCy("qualityassurancecompliance-content").should("be.visible");
  cy.getCy("qa-dashboard-compliance-status").should("be.visible");
  cy.getCy("qa-dashboard-performance-metrics").should("be.visible");
  cy.getCy("qa-dashboard-audit-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/10 | 50%] - Saving screenshot for QualityAssuranceComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [5/10 | 50%] - Verified QualityAssuranceComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/10 | 60%] - Navigating to /staff/quality-assurance-workflow (QualityAssuranceWorkflowScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/10 | 60%] - Checking shell & content for QualityAssuranceWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceworkflow-screen").should("be.visible");
  cy.getCy("qualityassuranceworkflow-title").should("be.visible");
  cy.getCy("qualityassuranceworkflow-content").should("be.visible");
  cy.getCy("qa-dashboard-btn-execute-test").should("be.visible");
  cy.getCy("qa-dashboard-btn-track-defects").should("be.visible");
  cy.getCy("qa-dashboard-btn-view-reports").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/10 | 60%] - Saving screenshot for QualityAssuranceWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [6/10 | 60%] - Verified QualityAssuranceWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/10 | 70%] - Navigating to /staff/quality-audit (QualityAuditScreen)...");
  cy.visitWithSemantics("/staff/quality-audit");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/10 | 70%] - Checking shell & content for QualityAuditScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityaudit-screen").should("be.visible");
  cy.getCy("qualityaudit-title").should("be.visible");
  cy.getCy("qualityaudit-content").should("be.visible");
  cy.getCy("qa-compliance-scan-btn").should("be.visible");
  cy.getCy("qa-review-logs-btn").should("be.visible");
  cy.getCy("qa-generate-kpi-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/10 | 70%] - Saving screenshot for QualityAuditScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_audit");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [7/10 | 70%] - Verified QualityAuditScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/10 | 80%] - Navigating to /staff/failed-workflow (FailedWorkflowScreen)...");
  cy.visitWithSemantics("/staff/failed-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/10 | 80%] - Checking shell & content for FailedWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("failedworkflow-screen").should("be.visible");
  cy.getCy("failedworkflow-title").should("be.visible");
  cy.getCy("failedworkflow-content").should("be.visible");
  cy.getCy("qa-tasklist").should("be.visible");
  cy.getCy("qa-defect-metrics").should("be.visible");
  cy.getCy("qa-test-coverage").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/10 | 80%] - Saving screenshot for FailedWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("failed_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [8/10 | 80%] - Verified FailedWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [9/10 | 90%] - Navigating to /staff/testing-overview (TestingOverviewScreen)...");
  cy.visitWithSemantics("/staff/testing-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [9/10 | 90%] - Checking shell & content for TestingOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("testingoverview-screen").should("be.visible");
  cy.getCy("testingoverview-title").should("be.visible");
  cy.getCy("testingoverview-content").should("be.visible");
  cy.getCy("qa-dashboard-refresh-status").should("be.visible");
  cy.getCy("qa-dashboard-view-defects").should("be.visible");
  cy.getCy("qa-dashboard-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [9/10 | 90%] - Saving screenshot for TestingOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("testing_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [9/10 | 90%] - Verified TestingOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [10/10 | 100%] - Navigating to /staff/defect-tracking (DefectTrackingScreen)...");
  cy.visitWithSemantics("/staff/defect-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [10/10 | 100%] - Checking shell & content for DefectTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("defecttracking-screen").should("be.visible");
  cy.getCy("defecttracking-title").should("be.visible");
  cy.getCy("defecttracking-content").should("be.visible");
  cy.getCy("qa-dashboard-btn-execute-test").should("be.visible");
  cy.getCy("qa-dashboard-btn-document-defect").should("be.visible");
  cy.getCy("qa-dashboard-btn-resolve-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [10/10 | 100%] - Saving screenshot for DefectTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("defect_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [10/10 | 100%] - Verified DefectTrackingScreen successfully!\n");
  });

  it("tests org role family", () => {
    cy.loginAsRole("family");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Navigating to /common/family-member-analytics (FamilyMemberAnalyticsScreen)...");
  cy.visitWithSemantics("/common/family-member-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Checking shell & content for FamilyMemberAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberanalytics-screen").should("be.visible");
  cy.getCy("familymemberanalytics-title").should("be.visible");
  cy.getCy("familymemberanalytics-content").should("be.visible");
  cy.getCy("family-member-analytics-refresh").should("be.visible");
  cy.getCy("family-member-sandbox-access").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Saving screenshot for FamilyMemberAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Verified FamilyMemberAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Navigating to /common/family-member-compliance (FamilyMemberComplianceScreen)...");
  cy.visitWithSemantics("/common/family-member-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Checking shell & content for FamilyMemberComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymembercompliance-screen").should("be.visible");
  cy.getCy("familymembercompliance-title").should("be.visible");
  cy.getCy("familymembercompliance-content").should("be.visible");
  cy.getCy("family_member_compliance-scan-status").should("be.visible");
  cy.getCy("family_member_compliance-log-summary").should("be.visible");
  cy.getCy("family_member_compliance-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Saving screenshot for FamilyMemberComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Verified FamilyMemberComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Navigating to /common/family-member-workflow (FamilyMemberWorkflowScreen)...");
  cy.visitWithSemantics("/common/family-member-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Checking shell & content for FamilyMemberWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberworkflow-screen").should("be.visible");
  cy.getCy("familymemberworkflow-title").should("be.visible");
  cy.getCy("familymemberworkflow-content").should("be.visible");
  cy.getCy("family-member-btn-execute-1").should("be.visible");
  cy.getCy("family-member-btn-action-sweep").should("be.visible");
  cy.getCy("family-member-dashboard-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Saving screenshot for FamilyMemberWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Verified FamilyMemberWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Navigating to /common/family-overview (FamilyOverviewScreen)...");
  cy.visitWithSemantics("/common/family-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Checking shell & content for FamilyOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyoverview-screen").should("be.visible");
  cy.getCy("familyoverview-title").should("be.visible");
  cy.getCy("familyoverview-content").should("be.visible");
  cy.getCy("family-overview-btn-run-scan").should("be.visible");
  cy.getCy("family-overview-btn-trigger-action").should("be.visible");
  cy.getCy("family-overview-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Saving screenshot for FamilyOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("family_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Verified FamilyOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Navigating to /common/care-updates (CareUpdatesScreen)...");
  cy.visitWithSemantics("/common/care-updates");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Checking shell & content for CareUpdatesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careupdates-screen").should("be.visible");
  cy.getCy("careupdates-title").should("be.visible");
  cy.getCy("careupdates-content").should("be.visible");
  cy.getCy("compliance-scan-results").should("be.visible");
  cy.getCy("performance-indicator-chart").should("be.visible");
  cy.getCy("operational-audit-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Saving screenshot for CareUpdatesScreen...");
  cy.waitAndSee();
  cy.screenshot("care_updates");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Verified CareUpdatesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Navigating to /common/billing-overview (BillingOverviewScreen)...");
  cy.visitWithSemantics("/common/billing-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Checking shell & content for BillingOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingoverview-screen").should("be.visible");
  cy.getCy("billingoverview-title").should("be.visible");
  cy.getCy("billingoverview-content").should("be.visible");
  cy.getCy("billing-overview-btn-execute-scan").should("be.visible");
  cy.getCy("billing-overview-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Saving screenshot for BillingOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Verified BillingOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Navigating to /common/emergency-contacts (EmergencyContactsScreen)...");
  cy.visitWithSemantics("/common/emergency-contacts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Checking shell & content for EmergencyContactsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("emergencycontacts-screen").should("be.visible");
  cy.getCy("emergencycontacts-title").should("be.visible");
  cy.getCy("emergencycontacts-content").should("be.visible");
  cy.getCy("emergency-contacts-list").should("be.visible");
  cy.getCy("compliance-scan-results").should("be.visible");
  cy.getCy("audit-log-viewer").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Saving screenshot for EmergencyContactsScreen...");
  cy.waitAndSee();
  cy.screenshot("emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Verified EmergencyContactsScreen successfully!\n");
  });

});
