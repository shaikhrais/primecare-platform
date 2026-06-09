// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic", () => {
  it("opens and verifies screen dynamic", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Dynamic)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Dynamic...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamic-screen").should("be.visible");
  cy.getCy("dynamic-title").should("be.visible");
  cy.getCy("dynamic-content").should("be.visible");
  cy.getCy("project-dashboard-btn-update-metadata").should("be.visible");
  cy.getCy("project-dashboard-btn-view-details").should("be.visible");
  cy.getCy("project-dashboard-btn-track-completion").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Dynamic...");
  cy.waitAndSee();
  cy.screenshot("dynamic");
  
  cy.task("log", "✅ PROGRESS: - Verified Dynamic successfully!\n");

  });
});
