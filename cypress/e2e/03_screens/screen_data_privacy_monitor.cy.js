// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - data_privacy_monitor", () => {
  it("opens and verifies screen data_privacy_monitor", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Data Privacy Monitor)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Data Privacy Monitor...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dataprivacymonitor-screen").should("be.visible");
  cy.getCy("dataprivacymonitor-title").should("be.visible");
  cy.getCy("dataprivacymonitor-content").should("be.visible");
  cy.getCy("data-privacy-metrics-card").should("be.visible");
  cy.getCy("data-privacy-alerts-section").should("be.visible");
  cy.getCy("data-privacy-risk-cards").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Data Privacy Monitor...");
  cy.waitAndSee();
  cy.screenshot("data_privacy_monitor");
  
  cy.task("log", "✅ PROGRESS: - Verified Data Privacy Monitor successfully!\n");

  });
});
