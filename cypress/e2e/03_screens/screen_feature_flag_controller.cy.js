// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - feature_flag_controller", () => {
  it("opens and verifies screen feature_flag_controller", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Feature Flag Controller)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Feature Flag Controller...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("featureflagcontroller-screen").should("be.visible");
  cy.getCy("featureflagcontroller-title").should("be.visible");
  cy.getCy("featureflagcontroller-content").should("be.visible");
  cy.getCy("feature-flag-list").should("be.visible");
  cy.getCy("feature-flag-toggle").should("be.visible");
  cy.getCy("error-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Feature Flag Controller...");
  cy.waitAndSee();
  cy.screenshot("feature_flag_controller");
  
  cy.task("log", "✅ PROGRESS: - Verified Feature Flag Controller successfully!\n");

  });
});
