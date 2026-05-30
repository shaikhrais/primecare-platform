// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - release_management", () => {
  it("opens and verifies screen release_management", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/release-management (ReleaseManagementScreen)...");
  cy.visitWithSemantics("/executive/release-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ReleaseManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releasemanagement-screen").should("be.visible");
  cy.getCy("releasemanagement-title").should("be.visible");
  cy.getCy("releasemanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ReleaseManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("release_management");
  
  cy.task("log", "✅ PROGRESS: - Verified ReleaseManagementScreen successfully!\n");

  });
});
