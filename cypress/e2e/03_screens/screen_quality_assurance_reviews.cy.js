// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_reviews", () => {
  it("opens and verifies screen quality_assurance_reviews", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Quality Assurance Reviews)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Assurance Reviews...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancereviews-screen").should("be.visible");
  cy.getCy("qualityassurancereviews-title").should("be.visible");
  cy.getCy("qualityassurancereviews-content").should("be.visible");
  cy.getCy("quality-dashboard-btn-submit-findings").should("be.visible");
  cy.getCy("quality-dashboard-btn-request-feedback").should("be.visible");
  cy.getCy("quality-dashboard-btn-schedule-meeting").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Assurance Reviews...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_reviews");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Assurance Reviews successfully!\n");

  });
});
