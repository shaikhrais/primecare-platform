// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_client_intake", () => {
  it("opens and verifies screen physiotherapist_client_intake", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/client-intake (PhysiotherapistClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistclientintake-screen").should("be.visible");
  cy.getCy("physiotherapistclientintake-title").should("be.visible");
  cy.getCy("physiotherapistclientintake-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-save").should("be.visible");
  cy.getCy("physio-dashboard-btn-update").should("be.visible");
  cy.getCy("physio-dashboard-btn-emergency").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_client_intake");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistClientIntakeScreen successfully!\n");

  });
});
