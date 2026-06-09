// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - configuration_version_control", () => {
  it("opens and verifies screen configuration_version_control", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Configuration Version Control)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Configuration Version Control...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("configurationversioncontrol-screen").should("be.visible");
  cy.getCy("configurationversioncontrol-title").should("be.visible");
  cy.getCy("configurationversioncontrol-content").should("be.visible");
  cy.getCy("configversion-btn-refresh").should("be.visible");
  cy.getCy("configversion-btn-viewdiff").should("be.visible");
  cy.getCy("configversion-btn-rollback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Configuration Version Control...");
  cy.waitAndSee();
  cy.screenshot("configuration_version_control");
  
  cy.task("log", "✅ PROGRESS: - Verified Configuration Version Control successfully!\n");

  });
});
