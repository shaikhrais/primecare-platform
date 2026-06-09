// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scrum_master_compliance", () => {
  it("opens and verifies screen scrum_master_compliance", () => {
    cy.loginAsRole("scrum_master");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/scrum-master-compliance (ScrumMasterComplianceScreen)...");
  cy.visitWithSemantics("/management/scrum-master-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ScrumMasterComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummastercompliance-screen").should("be.visible");
  cy.getCy("scrummastercompliance-title").should("be.visible");
  cy.getCy("scrummastercompliance-content").should("be.visible");
  cy.getCy("scrum-dashboard-btn-add-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-resolve-impediment").should("be.visible");
  cy.getCy("scrum-dashboard-btn-record-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ScrumMasterComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified ScrumMasterComplianceScreen successfully!\n");

  });
});
