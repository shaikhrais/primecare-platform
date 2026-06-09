// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_events", () => {
  it("opens and verifies screen local_marketing_manager_events", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Local Marketing Manager Events)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Local Marketing Manager Events...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerevents-screen").should("be.visible");
  cy.getCy("localmarketingmanagerevents-title").should("be.visible");
  cy.getCy("localmarketingmanagerevents-content").should("be.visible");
  cy.getCy("localmarketing-btn-update").should("be.visible");
  cy.getCy("localmarketing-btn-notify").should("be.visible");
  cy.getCy("localmarketing-metric-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Local Marketing Manager Events...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_events");
  
  cy.task("log", "✅ PROGRESS: - Verified Local Marketing Manager Events successfully!\n");

  });
});
