// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governed", () => {
  it("opens and verifies screen governed", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Governed)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Governed...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governed-screen").should("be.visible");
  cy.getCy("governed-title").should("be.visible");
  cy.getCy("governed-content").should("be.visible");
  cy.getCy("gov-btn-validate-policies").should("be.visible");
  cy.getCy("gov-btn-enforce-policies").should("be.visible");
  cy.getCy("gov-btn-monitor-access").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Governed...");
  cy.waitAndSee();
  cy.screenshot("governed");
  
  cy.task("log", "✅ PROGRESS: - Verified Governed successfully!\n");

  });
});
