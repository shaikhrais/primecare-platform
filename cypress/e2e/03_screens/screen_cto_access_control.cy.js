// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_access_control", () => {
  it("opens and verifies screen cto_access_control", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/access-control (Cto Access Control)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/access-control");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Access Control...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoaccesscontrol-screen").should("be.visible");
  cy.getCy("ctoaccesscontrol-title").should("be.visible");
  cy.getCy("ctoaccesscontrol-content").should("be.visible");
  cy.getCy("accesscontrol-overview").should("be.visible");
  cy.getCy("pending-requests-notification").should("be.visible");
  cy.getCy("security-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Access Control...");
  cy.waitAndSee();
  cy.screenshot("cto_access_control");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Access Control successfully!\n");

  });
});
