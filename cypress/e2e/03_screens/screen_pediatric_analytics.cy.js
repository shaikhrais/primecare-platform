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

  cy.getCy("pediatricanalytics-screen").should("be.visible");
  cy.getCy("pediatricanalytics-title").should("be.visible");
  cy.getCy("pediatricanalytics-content").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-schedule").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-view-records").should("be.visible");
  cy.getCy("pediatric-dashboard-btn-send-reminder").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Pediatric Specialist Analytics...");
  cy.waitAndSee();
  cy.screenshot("pediatric_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Pediatric Specialist Analytics successfully!\n");

  });
});
