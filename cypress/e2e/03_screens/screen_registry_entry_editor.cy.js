// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - registry_entry_editor", () => {
  it("opens and verifies screen registry_entry_editor", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Registry Entry Editor)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Registry Entry Editor...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registryentryeditor-screen").should("be.visible");
  cy.getCy("registryentryeditor-title").should("be.visible");
  cy.getCy("registryentryeditor-content").should("be.visible");
  cy.getCy("registry-entry-input").should("be.visible");
  cy.getCy("registry-update-button").should("be.visible");
  cy.getCy("validation-console").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Registry Entry Editor...");
  cy.waitAndSee();
  cy.screenshot("registry_entry_editor");
  
  cy.task("log", "✅ PROGRESS: - Verified Registry Entry Editor successfully!\n");

  });
});
