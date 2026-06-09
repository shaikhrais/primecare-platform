// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_release_management", () => {
  it("opens and verifies screen cto_release_management", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/release-management (Cto Release Management)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/release-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Release Management...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoreleasemanagement-screen").should("be.visible");
  cy.getCy("ctoreleasemanagement-title").should("be.visible");
  cy.getCy("ctoreleasemanagement-content").should("be.visible");
  cy.getCy("release-status-overview").should("be.visible");
  cy.getCy("release-metrics-chart").should("be.visible");
  cy.getCy("release-timeline").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Release Management...");
  cy.waitAndSee();
  cy.screenshot("cto_release_management");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Release Management successfully!\n");

  });
});
