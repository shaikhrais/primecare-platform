// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_treatment_history", () => {
  it("opens and verifies screen client_treatment_history", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Client Treatment History)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Client Treatment History...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clienttreatmenthistory-screen").should("be.visible");
  cy.getCy("clienttreatmenthistory-title").should("be.visible");
  cy.getCy("clienttreatmenthistory-content").should("be.visible");
  cy.getCy("client-treatment-history-summary").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Client Treatment History...");
  cy.waitAndSee();
  cy.screenshot("client_treatment_history");
  
  cy.task("log", "✅ PROGRESS: - Verified Client Treatment History successfully!\n");

  });
});
