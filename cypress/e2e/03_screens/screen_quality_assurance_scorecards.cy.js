// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_scorecards", () => {
  it("opens and verifies screen quality_assurance_scorecards", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Quality Assurance Scorecards)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Assurance Scorecards...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancescorecards-screen").should("be.visible");
  cy.getCy("qualityassurancescorecards-title").should("be.visible");
  cy.getCy("qualityassurancescorecards-content").should("be.visible");
  cy.getCy("qa-dashboard-metrics-overview").should("be.visible");
  cy.getCy("qa-dashboard-scorecard-chart").should("be.visible");
  cy.getCy("qa-dashboard-red-flag-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Assurance Scorecards...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_scorecards");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Assurance Scorecards successfully!\n");

  });
});
