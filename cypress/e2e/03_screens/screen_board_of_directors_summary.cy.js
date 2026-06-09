// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - board_of_directors_summary", () => {
  it("opens and verifies screen board_of_directors_summary", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Board Of Directors Summary)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Board Of Directors Summary...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("boardofdirectorssummary-screen").should("be.visible");
  cy.getCy("boardofdirectorssummary-title").should("be.visible");
  cy.getCy("boardofdirectorssummary-content").should("be.visible");
  cy.getCy("kpi-overview").should("be.visible");
  cy.getCy("refresh-data-btn").should("be.visible");
  cy.getCy("generate-pdf-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Board Of Directors Summary...");
  cy.waitAndSee();
  cy.screenshot("board_of_directors_summary");
  
  cy.task("log", "✅ PROGRESS: - Verified Board Of Directors Summary successfully!\n");

  });
});
