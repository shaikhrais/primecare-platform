// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - lpn", () => {
  it("tests all screens for role lpn", () => {
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

  cy.getCy("licensed practical nurse (lpn) analytics-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-content").should("be.visible");

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

  cy.getCy("licensed practical nurse (lpn) compliance workflow-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) compliance workflow-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) compliance workflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Licensed Practical Nurse (LPN) Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("lpn_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Licensed Practical Nurse (LPN) Compliance Workflow successfully!\n");

  });
});
