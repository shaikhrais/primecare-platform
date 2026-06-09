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

  cy.getCy("publichealthalertbroadcaster-screen").should("be.visible");
  cy.getCy("publichealthalertbroadcaster-title").should("be.visible");
  cy.getCy("publichealthalertbroadcaster-content").should("be.visible");
  cy.getCy("publichealth-alert-monitor").should("be.visible");
  cy.getCy("publichealth-alert-create").should("be.visible");
  cy.getCy("publichealth-alert-send").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Public Health Alert Broadcaster...");
  cy.waitAndSee();
  cy.screenshot("public_health_alert_broadcaster");
  
  cy.task("log", "✅ PROGRESS: - Verified Public Health Alert Broadcaster successfully!\n");

  });
});
