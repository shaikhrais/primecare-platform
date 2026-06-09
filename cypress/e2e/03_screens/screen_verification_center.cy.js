// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - verification_center", () => {
  it("opens and verifies screen verification_center", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /verification (Verification Center)...");
  cy.visitWithSemantics("/verification");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Verification Center...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("verificationcenter-screen").should("be.visible");
  cy.getCy("verificationcenter-title").should("be.visible");
  cy.getCy("verificationcenter-content").should("be.visible");
  cy.getCy("verification-center-summary-card").should("be.visible");
  cy.getCy("verification-center-deployment-list").should("be.visible");
  cy.getCy("verification-center-loading-indicator").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Verification Center...");
  cy.waitAndSee();
  cy.screenshot("verification_center");
  
  cy.task("log", "✅ PROGRESS: - Verified Verification Center successfully!\n");

  });
});
