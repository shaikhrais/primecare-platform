// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - cns", () => {
  it("tests all screens for role cns", () => {
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

  cy.getCy("clinical nurse specialist analytics-screen").should("be.visible");
  cy.getCy("clinical nurse specialist analytics-title").should("be.visible");
  cy.getCy("clinical nurse specialist analytics-content").should("be.visible");

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

  cy.getCy("clinical nurse specialist compliance workflow-screen").should("be.visible");
  cy.getCy("clinical nurse specialist compliance workflow-title").should("be.visible");
  cy.getCy("clinical nurse specialist compliance workflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Clinical Nurse Specialist Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("cns_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Clinical Nurse Specialist Compliance Workflow successfully!\n");

  });
});
