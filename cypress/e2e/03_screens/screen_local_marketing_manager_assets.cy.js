// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_assets", () => {
  it("opens and verifies screen local_marketing_manager_assets", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Local Marketing Manager Assets)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Local Marketing Manager Assets...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerassets-screen").should("be.visible");
  cy.getCy("localmarketingmanagerassets-title").should("be.visible");
  cy.getCy("localmarketingmanagerassets-content").should("be.visible");
  cy.getCy("localmarketing-assets-overview").should("be.visible");
  cy.getCy("localmarketing-performance-metrics").should("be.visible");
  cy.getCy("localmarketing-notifications").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Local Marketing Manager Assets...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_assets");
  
  cy.task("log", "✅ PROGRESS: - Verified Local Marketing Manager Assets successfully!\n");

  });
});
