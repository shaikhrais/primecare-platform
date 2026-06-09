// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - global_settings", () => {
  it("opens and verifies screen global_settings", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Global Settings)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Global Settings...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("globalsettings-screen").should("be.visible");
  cy.getCy("globalsettings-title").should("be.visible");
  cy.getCy("globalsettings-content").should("be.visible");
  cy.getCy("globalsettings-btn-save").should("be.visible");
  cy.getCy("globalsettings-btn-revert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Global Settings...");
  cy.waitAndSee();
  cy.screenshot("global_settings");
  
  cy.task("log", "✅ PROGRESS: - Verified Global Settings successfully!\n");

  });
});
