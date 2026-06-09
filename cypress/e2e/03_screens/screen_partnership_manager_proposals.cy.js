// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_proposals", () => {
  it("opens and verifies screen partnership_manager_proposals", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/partnership_manager/proposals (Partnership Manager Proposals)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/proposals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Partnership Manager Proposals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerproposals-screen").should("be.visible");
  cy.getCy("partnershipmanagerproposals-title").should("be.visible");
  cy.getCy("partnershipmanagerproposals-content").should("be.visible");
  cy.getCy("partnerships-btn-submit-feedback").should("be.visible");
  cy.getCy("partnerships-btn-update-status").should("be.visible");
  cy.getCy("partnerships-btn-request-info").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Partnership Manager Proposals...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_proposals");
  
  cy.task("log", "✅ PROGRESS: - Verified Partnership Manager Proposals successfully!\n");

  });
});
