// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - corrective_action", () => {
  it("opens and verifies screen corrective_action", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/corrective-action (CorrectiveActionScreen)...");
  cy.visitWithSemantics("/management/corrective-action");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CorrectiveActionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("correctiveaction-screen").should("be.visible");
  cy.getCy("correctiveaction-title").should("be.visible");
  cy.getCy("correctiveaction-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CorrectiveActionScreen...");
  cy.waitAndSee();
  cy.screenshot("corrective_action");
  
  cy.task("log", "✅ PROGRESS: - Verified CorrectiveActionScreen successfully!\n");

  });
});
