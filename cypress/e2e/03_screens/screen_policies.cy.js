// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - policies", () => {
  it("opens and verifies screen policies", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/policies (Policies)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/policies");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Policies...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policies-screen").should("be.visible");
  cy.getCy("policies-title").should("be.visible");
  cy.getCy("policies-content").should("be.visible");
  cy.getCy("policies-loading-indicator").should("be.visible");
  cy.getCy("policies-error-message").should("be.visible");
  cy.getCy("policies-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Policies...");
  cy.waitAndSee();
  cy.screenshot("policies");
  
  cy.task("log", "✅ PROGRESS: - Verified Policies successfully!\n");

  });
});
