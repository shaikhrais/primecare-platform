// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - certification_renewal_alerts", () => {
  it("opens and verifies screen certification_renewal_alerts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Certification Renewal Alerts)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Certification Renewal Alerts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationrenewalalerts-screen").should("be.visible");
  cy.getCy("certificationrenewalalerts-title").should("be.visible");
  cy.getCy("certificationrenewalalerts-content").should("be.visible");
  cy.getCy("certification-alerts-list").should("be.visible");
  cy.getCy("send-reminder-btn").should("be.visible");
  cy.getCy("refresh-alerts-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Certification Renewal Alerts...");
  cy.waitAndSee();
  cy.screenshot("certification_renewal_alerts");
  
  cy.task("log", "✅ PROGRESS: - Verified Certification Renewal Alerts successfully!\n");

  });
});
