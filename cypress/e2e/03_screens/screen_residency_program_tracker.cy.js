// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - residency_program_tracker", () => {
  it("opens and verifies screen residency_program_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Residency Program Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Residency Program Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("residencyprogramtracker-screen").should("be.visible");
  cy.getCy("residencyprogramtracker-title").should("be.visible");
  cy.getCy("residencyprogramtracker-content").should("be.visible");
  cy.getCy("resident-list").should("be.visible");
  cy.getCy("resident-card").should("be.visible");
  cy.getCy("completion-percentage").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Residency Program Tracker...");
  cy.waitAndSee();
  cy.screenshot("residency_program_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Residency Program Tracker successfully!\n");

  });
});
