// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_determinants_of_health_tracker", () => {
  it("opens and verifies screen social_determinants_of_health_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Social Determinants Of Health Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Social Determinants Of Health Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialdeterminantsofhealthtracker-screen").should("be.visible");
  cy.getCy("socialdeterminantsofhealthtracker-title").should("be.visible");
  cy.getCy("socialdeterminantsofhealthtracker-content").should("be.visible");
  cy.getCy("healthtracker-btn-submit").should("be.visible");
  cy.getCy("healthtracker-btn-generate-report").should("be.visible");
  cy.getCy("healthtracker-btn-update-info").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Social Determinants Of Health Tracker...");
  cy.waitAndSee();
  cy.screenshot("social_determinants_of_health_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Social Determinants Of Health Tracker successfully!\n");

  });
});
