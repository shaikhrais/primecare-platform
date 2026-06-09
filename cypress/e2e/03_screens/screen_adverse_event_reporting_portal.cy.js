// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - adverse_event_reporting_portal", () => {
  it("opens and verifies screen adverse_event_reporting_portal", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Adverse Event Reporting Portal)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Adverse Event Reporting Portal...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adverseeventreportingportal-screen").should("be.visible");
  cy.getCy("adverseeventreportingportal-title").should("be.visible");
  cy.getCy("adverseeventreportingportal-content").should("be.visible");
  cy.getCy("adverse-event-report-btn").should("be.visible");
  cy.getCy("adverse-event-review-btn").should("be.visible");
  cy.getCy("guidelines-access-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Adverse Event Reporting Portal...");
  cy.waitAndSee();
  cy.screenshot("adverse_event_reporting_portal");
  
  cy.task("log", "✅ PROGRESS: - Verified Adverse Event Reporting Portal successfully!\n");

  });
});
