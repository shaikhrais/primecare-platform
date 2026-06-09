// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_health_needs_assessment", () => {
  it("opens and verifies screen community_health_needs_assessment", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Health Needs Assessment)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Health Needs Assessment...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityhealthneedsassessment-screen").should("be.visible");
  cy.getCy("communityhealthneedsassessment-title").should("be.visible");
  cy.getCy("communityhealthneedsassessment-content").should("be.visible");
  cy.getCy("community-health-assessment-progress").should("be.visible");
  cy.getCy("community-health-metrics-chart").should("be.visible");
  cy.getCy("stakeholder-engagement-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Health Needs Assessment...");
  cy.waitAndSee();
  cy.screenshot("community_health_needs_assessment");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Health Needs Assessment successfully!\n");

  });
});
