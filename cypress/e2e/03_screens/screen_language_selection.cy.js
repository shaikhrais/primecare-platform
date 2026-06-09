// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - language_selection", () => {
  it("opens and verifies screen language_selection", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Language Selection)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Language Selection...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("languageselection-screen").should("be.visible");
  cy.getCy("languageselection-title").should("be.visible");
  cy.getCy("languageselection-content").should("be.visible");
  cy.getCy("language-selection-dropdown").should("be.visible");
  cy.getCy("continue-button").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Language Selection...");
  cy.waitAndSee();
  cy.screenshot("language_selection");
  
  cy.task("log", "✅ PROGRESS: - Verified Language Selection successfully!\n");

  });
});
