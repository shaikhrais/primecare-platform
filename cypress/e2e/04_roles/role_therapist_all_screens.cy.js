// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - therapist", () => {
  it("tests all screens for role therapist", () => {
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
});
