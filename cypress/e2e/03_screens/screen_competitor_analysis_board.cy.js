// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - competitor_analysis_board", () => {
  it("opens and verifies screen competitor_analysis_board", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Competitor Analysis Board)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Competitor Analysis Board...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("competitoranalysisboard-screen").should("be.visible");
  cy.getCy("competitoranalysisboard-title").should("be.visible");
  cy.getCy("competitoranalysisboard-content").should("be.visible");
  cy.getCy("competitor-analysis-refresh").should("be.visible");
  cy.getCy("competitor-analysis-add").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Competitor Analysis Board...");
  cy.waitAndSee();
  cy.screenshot("competitor_analysis_board");
  
  cy.task("log", "✅ PROGRESS: - Verified Competitor Analysis Board successfully!\n");

  });
});
