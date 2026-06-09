// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_command_center", () => {
  it("opens and verifies screen chiropractor_command_center", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/command-center (ChiropractorCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
  cy.getCy("chiropractorcommandcenter-title").should("be.visible");
  cy.getCy("chiropractorcommandcenter-content").should("be.visible");
  cy.getCy("chiropractor-btn-add-assessment").should("be.visible");
  cy.getCy("chiropractor-btn-update-plan").should("be.visible");
  cy.getCy("chiropractor-btn-record-adjustment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorCommandCenterScreen successfully!\n");

  });
});
