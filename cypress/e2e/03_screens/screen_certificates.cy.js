// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - certificates", () => {
  it("opens and verifies screen certificates", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Certificates)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Certificates...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificates-screen").should("be.visible");
  cy.getCy("certificates-title").should("be.visible");
  cy.getCy("certificates-content").should("be.visible");
  cy.getCy("certificates-loading-indicator").should("be.visible");
  cy.getCy("certificates-error-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Certificates...");
  cy.waitAndSee();
  cy.screenshot("certificates");
  
  cy.task("log", "✅ PROGRESS: - Verified Certificates successfully!\n");

  });
});
