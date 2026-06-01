// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - physician", () => {
  it("tests all screens for role physician", () => {
    cy.loginAsRole("physician");


  
  cy.checkTestRegistry("physiciandashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /clinical/physician-dashboard (PhysicianDashboardScreen)...");
    cy.visitWithSemantics("/clinical/physician-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for /clinical/physician-dashboard (PhysicianDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiciandashboard-screen").should("be.visible");
    cy.getCy("physiciandashboard-title").should("be.visible");
    cy.getCy("physiciandashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for /clinical/physician-dashboard (PhysicianDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("physician_dashboard");
    
    cy.updateTestRegistry("physiciandashboard", "PASS", "role_physician_all_screens.cy.js", "physician_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified PhysicianDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("physiciananalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /clinical/physician-analytics (Physician Analytics)...");
    cy.visitWithSemantics("/clinical/physician-analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for /clinical/physician-analytics (Physician Analytics)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physiciananalytics-screen").should("be.visible");
    cy.getCy("physiciananalytics-title").should("be.visible");
    cy.getCy("physiciananalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for /clinical/physician-analytics (Physician Analytics)...");
    cy.waitAndSee();
    cy.screenshot("physician_analytics");
    
    cy.updateTestRegistry("physiciananalytics", "PASS", "role_physician_all_screens.cy.js", "physician_analytics");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Physician Analytics successfully!\n");
  });


  
  cy.checkTestRegistry("physicianworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /clinical/physician-workflow (Physician Compliance Workflow)...");
    cy.visitWithSemantics("/clinical/physician-workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for /clinical/physician-workflow (Physician Compliance Workflow)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("physicianworkflow-screen").should("be.visible");
    cy.getCy("physicianworkflow-title").should("be.visible");
    cy.getCy("physicianworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for /clinical/physician-workflow (Physician Compliance Workflow)...");
    cy.waitAndSee();
    cy.screenshot("physician_workflow");
    
    cy.updateTestRegistry("physicianworkflow", "PASS", "role_physician_all_screens.cy.js", "physician_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Physician Compliance Workflow successfully!\n");
  });


  });
});
