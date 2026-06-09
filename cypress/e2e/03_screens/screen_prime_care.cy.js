// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - prime_care", () => {
  it("opens and verifies screen prime_care", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Prime Care)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Prime Care...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("primecare-screen").should("be.visible");
  cy.getCy("primecare-title").should("be.visible");
  cy.getCy("primecare-content").should("be.visible");
  cy.getCy("primecare-btn-back").should("be.visible");
  cy.getCy("primecare-btn-navigate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Prime Care...");
  cy.waitAndSee();
  cy.screenshot("prime_care");
  
  cy.task("log", "✅ PROGRESS: - Verified Prime Care successfully!\n");

  });
});
