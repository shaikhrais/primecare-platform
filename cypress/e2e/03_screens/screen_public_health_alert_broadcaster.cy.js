// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - public_health_alert_broadcaster", () => {
  it("opens and verifies screen public_health_alert_broadcaster", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Public Health Alert Broadcaster)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Public Health Alert Broadcaster...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Public Health Alert Broadcaster...");
  cy.waitAndSee();
  cy.screenshot("public_health_alert_broadcaster");
  
  cy.task("log", "✅ PROGRESS: - Verified Public Health Alert Broadcaster successfully!\n");

  });
});
