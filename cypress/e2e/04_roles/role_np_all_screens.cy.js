// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - np", () => {
  it("tests all screens for role np", () => {
    cy.loginAsRole("np");


  
  cy.checkTestRegistry("npdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /clinical/np-dashboard (NpDashboardScreen)...");
    cy.visitWithSemantics("/clinical/np-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for /clinical/np-dashboard (NpDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("npdashboard-screen").should("be.visible");
    cy.getCy("npdashboard-title").should("be.visible");
    cy.getCy("npdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for /clinical/np-dashboard (NpDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("np_dashboard");
    
    cy.updateTestRegistry("npdashboard", "PASS", "role_np_all_screens.cy.js", "np_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified NpDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("npanalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /rn/np-analytics (Nurse Practitioner (NP) Analytics)...");
    cy.visitWithSemantics("/rn/np-analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for /rn/np-analytics (Nurse Practitioner (NP) Analytics)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("npanalytics-screen").should("be.visible");
    cy.getCy("npanalytics-title").should("be.visible");
    cy.getCy("npanalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for /rn/np-analytics (Nurse Practitioner (NP) Analytics)...");
    cy.waitAndSee();
    cy.screenshot("np_analytics");
    
    cy.updateTestRegistry("npanalytics", "PASS", "role_np_all_screens.cy.js", "np_analytics");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Nurse Practitioner (NP) Analytics successfully!\n");
  });


  
  cy.checkTestRegistry("npworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /rn/np-workflow (Nurse Practitioner (NP) Compliance Workflow)...");
    cy.visitWithSemantics("/rn/np-workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for /rn/np-workflow (Nurse Practitioner (NP) Compliance Workflow)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("npworkflow-screen").should("be.visible");
    cy.getCy("npworkflow-title").should("be.visible");
    cy.getCy("npworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for /rn/np-workflow (Nurse Practitioner (NP) Compliance Workflow)...");
    cy.waitAndSee();
    cy.screenshot("np_workflow");
    
    cy.updateTestRegistry("npworkflow", "PASS", "role_np_all_screens.cy.js", "np_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Nurse Practitioner (NP) Compliance Workflow successfully!\n");
  });


  });
});
