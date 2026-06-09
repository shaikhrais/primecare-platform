// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - substance_abuse_prevention_tracker", () => {
  it("opens and verifies screen substance_abuse_prevention_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Substance Abuse Prevention Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Substance Abuse Prevention Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("substanceabusepreventiontracker-screen").should("be.visible");
  cy.getCy("substanceabusepreventiontracker-title").should("be.visible");
  cy.getCy("substanceabusepreventiontracker-content").should("be.visible");
  cy.getCy("substance-abuse-btn-submit").should("be.visible");
  cy.getCy("substance-abuse-btn-generate-report").should("be.visible");
  cy.getCy("substance-abuse-btn-analyze-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Substance Abuse Prevention Tracker...");
  cy.waitAndSee();
  cy.screenshot("substance_abuse_prevention_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Substance Abuse Prevention Tracker successfully!\n");

  });
});
