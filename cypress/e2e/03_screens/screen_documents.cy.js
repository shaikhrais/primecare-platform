// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - documents", () => {
  it("opens and verifies screen documents", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/documents (DocumentsScreen)...");
  cy.visitWithSemantics("/common/documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for DocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("documents-screen").should("be.visible");
  cy.getCy("documents-title").should("be.visible");
  cy.getCy("documents-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for DocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("documents");
  
  cy.task("log", "✅ PROGRESS: - Verified DocumentsScreen successfully!\n");

  });
});
