// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_compliance", () => {
  it("opens and verifies screen physiotherapist_compliance", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/compliance (PhysiotherapistComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcompliance-screen").should("be.visible");
  cy.getCy("physiotherapistcompliance-title").should("be.visible");
  cy.getCy("physiotherapistcompliance-content").should("be.visible");
  cy.getCy("physio-btn-save-treatment").should("be.visible");
  cy.getCy("physio-btn-monitor-progress").should("be.visible");
  cy.getCy("physio-btn-educate-patient").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistComplianceScreen successfully!\n");

  });
});
