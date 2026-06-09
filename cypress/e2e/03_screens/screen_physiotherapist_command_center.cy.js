// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_command_center", () => {
  it("opens and verifies screen physiotherapist_command_center", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/command-center (PhysiotherapistCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcommandcenter-screen").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-title").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-content").should("be.visible");
  cy.getCy("physio-btn-save-treatment").should("be.visible");
  cy.getCy("physio-btn-update-progress").should("be.visible");
  cy.getCy("physio-btn-send-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistCommandCenterScreen successfully!\n");

  });
});
