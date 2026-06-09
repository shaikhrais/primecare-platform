// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_leads", () => {
  it("opens and verifies screen local_marketing_manager_leads", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Local Marketing Manager Leads)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Local Marketing Manager Leads...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerleads-screen").should("be.visible");
  cy.getCy("localmarketingmanagerleads-title").should("be.visible");
  cy.getCy("localmarketingmanagerleads-content").should("be.visible");
  cy.getCy("localmarketing-btn-update-lead").should("be.visible");
  cy.getCy("localmarketing-btn-generate-report").should("be.visible");
  cy.getCy("localmarketing-btn-analyze-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Local Marketing Manager Leads...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_leads");
  
  cy.task("log", "✅ PROGRESS: - Verified Local Marketing Manager Leads successfully!\n");

  });
});
