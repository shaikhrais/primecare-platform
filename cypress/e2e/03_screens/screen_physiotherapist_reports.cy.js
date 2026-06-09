// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_reports", () => {
  it("opens and verifies screen physiotherapist_reports", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/reports (PhysiotherapistReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistreports-screen").should("be.visible");
  cy.getCy("physiotherapistreports-title").should("be.visible");
  cy.getCy("physiotherapistreports-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-update-treatment").should("be.visible");
  cy.getCy("physio-dashboard-btn-log-progress").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistReportsScreen successfully!\n");

  });
});
