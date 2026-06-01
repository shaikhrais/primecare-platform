// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - lpn", () => {
  it("tests all screens for role lpn", () => {
    cy.loginAsRole("lpn");


  
  cy.checkTestRegistry("lpndashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /clinical/lpn-dashboard (LpnDashboardScreen)...");
    cy.visitWithSemantics("/clinical/lpn-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for /clinical/lpn-dashboard (LpnDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("lpndashboard-screen").should("be.visible");
    cy.getCy("lpndashboard-title").should("be.visible");
    cy.getCy("lpndashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for /clinical/lpn-dashboard (LpnDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("lpn_dashboard");
    
    cy.updateTestRegistry("lpndashboard", "PASS", "role_lpn_all_screens.cy.js", "lpn_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified LpnDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("lpnanalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /rpn/lpn-analytics (Licensed Practical Nurse (LPN) Analytics)...");
    cy.visitWithSemantics("/rpn/lpn-analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for /rpn/lpn-analytics (Licensed Practical Nurse (LPN) Analytics)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("lpnanalytics-screen").should("be.visible");
    cy.getCy("lpnanalytics-title").should("be.visible");
    cy.getCy("lpnanalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for /rpn/lpn-analytics (Licensed Practical Nurse (LPN) Analytics)...");
    cy.waitAndSee();
    cy.screenshot("lpn_analytics");
    
    cy.updateTestRegistry("lpnanalytics", "PASS", "role_lpn_all_screens.cy.js", "lpn_analytics");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Licensed Practical Nurse (LPN) Analytics successfully!\n");
  });


  
  cy.checkTestRegistry("lpnworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /rpn/lpn-workflow (Licensed Practical Nurse (LPN) Compliance Workflow)...");
    cy.visitWithSemantics("/rpn/lpn-workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for /rpn/lpn-workflow (Licensed Practical Nurse (LPN) Compliance Workflow)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("lpnworkflow-screen").should("be.visible");
    cy.getCy("lpnworkflow-title").should("be.visible");
    cy.getCy("lpnworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for /rpn/lpn-workflow (Licensed Practical Nurse (LPN) Compliance Workflow)...");
    cy.waitAndSee();
    cy.screenshot("lpn_workflow");
    
    cy.updateTestRegistry("lpnworkflow", "PASS", "role_lpn_all_screens.cy.js", "lpn_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Licensed Practical Nurse (LPN) Compliance Workflow successfully!\n");
  });


  });
});
