// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pediatric_analytics", () => {
  it("opens and verifies screen pediatric_analytics", () => {
    cy.loginAsRole("pediatric");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/pediatric-analytics (Pediatric Specialist Analytics)...");
  cy.visitWithSemantics("/clinical/pediatric-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Pediatric Specialist Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatric specialist analytics-screen").should("be.visible");
  cy.getCy("pediatric specialist analytics-title").should("be.visible");
  cy.getCy("pediatric specialist analytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Pediatric Specialist Analytics...");
  cy.waitAndSee();
  cy.screenshot("pediatric_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Pediatric Specialist Analytics successfully!\n");

  });
});
