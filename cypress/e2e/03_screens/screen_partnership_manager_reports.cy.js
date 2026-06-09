// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_reports", () => {
  it("opens and verifies screen partnership_manager_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/partnership_manager/reports (Partnership Manager Reports)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Partnership Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerreports-screen").should("be.visible");
  cy.getCy("partnershipmanagerreports-title").should("be.visible");
  cy.getCy("partnershipmanagerreports-content").should("be.visible");
  cy.getCy("partnerships-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("partnerships-dashboard-btn-export-pdf").should("be.visible");
  cy.getCy("partnerships-dashboard-btn-export-csv").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Partnership Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Partnership Manager Reports successfully!\n");

  });
});
