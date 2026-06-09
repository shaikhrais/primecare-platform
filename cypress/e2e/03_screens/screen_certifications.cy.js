// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - certifications", () => {
  it("opens and verifies screen certifications", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Certifications)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Certifications...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certifications-screen").should("be.visible");
  cy.getCy("certifications-title").should("be.visible");
  cy.getCy("certifications-content").should("be.visible");
  cy.getCy("certifications-loading-indicator").should("be.visible");
  cy.getCy("certifications-error-message").should("be.visible");
  cy.getCy("certifications-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Certifications...");
  cy.waitAndSee();
  cy.screenshot("certifications");
  
  cy.task("log", "✅ PROGRESS: - Verified Certifications successfully!\n");

  });
});
