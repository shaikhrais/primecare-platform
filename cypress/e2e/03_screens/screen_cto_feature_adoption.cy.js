// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_feature_adoption", () => {
  it("opens and verifies screen cto_feature_adoption", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/feature-adoption (Cto Feature Adoption)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/feature-adoption");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Feature Adoption...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctofeatureadoption-screen").should("be.visible");
  cy.getCy("ctofeatureadoption-title").should("be.visible");
  cy.getCy("ctofeatureadoption-content").should("be.visible");
  cy.getCy("feature-adoption-chart").should("be.visible");
  cy.getCy("user-engagement-metrics").should("be.visible");
  cy.getCy("error-tracking-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Feature Adoption...");
  cy.waitAndSee();
  cy.screenshot("cto_feature_adoption");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Feature Adoption successfully!\n");

  });
});
