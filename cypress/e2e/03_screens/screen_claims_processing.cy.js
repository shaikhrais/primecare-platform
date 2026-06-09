// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - claims_processing", () => {
  it("opens and verifies screen claims_processing", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/claims-processing (ClaimsProcessingScreen)...");
  cy.visitWithSemantics("/staff/claims-processing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClaimsProcessingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("claimsprocessing-screen").should("be.visible");
  cy.getCy("claimsprocessing-title").should("be.visible");
  cy.getCy("claimsprocessing-content").should("be.visible");
  cy.getCy("claims-processing-btn-add-task").should("be.visible");
  cy.getCy("claims-processing-btn-schedule-appointment").should("be.visible");
  cy.getCy("claims-processing-btn-log-communication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClaimsProcessingScreen...");
  cy.waitAndSee();
  cy.screenshot("claims_processing");
  
  cy.task("log", "✅ PROGRESS: - Verified ClaimsProcessingScreen successfully!\n");

  });
});
