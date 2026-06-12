// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - physician", () => {
  it("tests all screens for role physician", () => {
    cy.loginAsRole("physician");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /clinical/physician-dashboard (PhysicianDashboardScreen)...");
  cy.visitWithSemantics("/clinical/physician-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for PhysicianDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciandashboard-screen").should("be.visible");
  cy.getCy("physiciandashboard-title").should("be.visible");
  // cy.getCy("physiciandashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for PhysicianDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("physician_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified PhysicianDashboardScreen successfully!\n");

  });
});
