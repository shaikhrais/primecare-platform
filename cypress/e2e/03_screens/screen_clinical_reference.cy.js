// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_reference", () => {
  it("opens and verifies screen clinical_reference", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/clinical-reference (Clinical Reference)...");
  cy.visitWithSemantics("/governance/clinical-reference");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Reference...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalreference-screen").should("be.visible");
  cy.getCy("clinicalreference-title").should("be.visible");
  cy.getCy("clinical-reference-content").should("be.visible");
  cy.getCy("clinical-reference-loading").should("be.visible");
  cy.getCy("clinical-reference-error").should("be.visible");
  cy.getCy("clinical-reference-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Reference...");
  cy.waitAndSee();
  cy.screenshot("clinical_reference");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Reference successfully!\n");

  });
});
