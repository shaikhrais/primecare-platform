// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - social_worker", () => {
  it("tests all screens for role social_worker", () => {
    cy.loginAsRole("social_worker");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/clinical/roles/social_worker/dashboard (SocialWorkerDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for SocialWorkerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerdashboard-screen").should("be.visible");
  cy.getCy("socialworkerdashboard-title").should("be.visible");
  // cy.getCy("socialworkerdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for SocialWorkerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified SocialWorkerDashboardScreen successfully!\n");

  });
});
