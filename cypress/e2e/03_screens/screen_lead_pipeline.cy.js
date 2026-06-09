// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lead_pipeline", () => {
  it("opens and verifies screen lead_pipeline", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Lead Pipeline)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Lead Pipeline...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadpipeline-screen").should("be.visible");
  cy.getCy("leadpipeline-title").should("be.visible");
  cy.getCy("leadpipeline-content").should("be.visible");
  cy.getCy("leadpipeline-btn-addnewlead").should("be.visible");
  cy.getCy("leadpipeline-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Lead Pipeline...");
  cy.waitAndSee();
  cy.screenshot("lead_pipeline");
  
  cy.task("log", "✅ PROGRESS: - Verified Lead Pipeline successfully!\n");

  });
});
