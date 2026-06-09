// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_partners", () => {
  it("opens and verifies screen partnership_manager_partners", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/partnership_manager/partners (Partnership Manager Partners)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/partners");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Partnership Manager Partners...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerpartners-screen").should("be.visible");
  cy.getCy("partnershipmanagerpartners-title").should("be.visible");
  cy.getCy("partnershipmanagerpartners-content").should("be.visible");
  cy.getCy("partnerships-kpi-widget").should("be.visible");
  cy.getCy("partnerships-alert-notification").should("be.visible");
  cy.getCy("partnerships-communication-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Partnership Manager Partners...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_partners");
  
  cy.task("log", "✅ PROGRESS: - Verified Partnership Manager Partners successfully!\n");

  });
});
