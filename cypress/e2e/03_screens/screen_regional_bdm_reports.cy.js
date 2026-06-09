// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_reports", () => {
  it("opens and verifies screen regional_bdm_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/reports (Regional Bdm Reports)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmreports-screen").should("be.visible");
  cy.getCy("regionalbdmreports-title").should("be.visible");
  cy.getCy("regionalbdmreports-content").should("be.visible");
  cy.getCy("regional-reports-loading").should("be.visible");
  cy.getCy("regional-reports-error").should("be.visible");
  cy.getCy("regional-reports-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Reports...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Reports successfully!\n");

  });
});
