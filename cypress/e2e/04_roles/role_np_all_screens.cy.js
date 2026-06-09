// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - np", () => {
  it("tests all screens for role np", () => {
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
});
