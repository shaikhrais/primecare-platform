// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_progress", () => {
  it("opens and verifies screen client_progress", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/client-progress (ClientProgressScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/client-progress");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClientProgressScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientprogress-screen").should("be.visible");
  cy.getCy("clientprogress-title").should("be.visible");
  cy.getCy("clientprogress-content").should("be.visible");
  cy.getCy("client-appointment-scheduler").should("be.visible");
  cy.getCy("client-assessment-tracker").should("be.visible");
  cy.getCy("performance-metrics-card").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClientProgressScreen...");
  cy.waitAndSee();
  cy.screenshot("client_progress");
  
  cy.task("log", "✅ PROGRESS: - Verified ClientProgressScreen successfully!\n");

  });
});
