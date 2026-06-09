// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_compliance", () => {
  it("opens and verifies screen chiropractor_compliance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/compliance (ChiropractorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcompliance-screen").should("be.visible");
  cy.getCy("chiropractorcompliance-title").should("be.visible");
  cy.getCy("chiropractorcompliance-content").should("be.visible");
  cy.getCy("chiropractor-btn-schedule-appointment").should("be.visible");
  cy.getCy("chiropractor-btn-generate-report").should("be.visible");
  cy.getCy("chiropractor-btn-update-treatment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorComplianceScreen successfully!\n");

  });
});
