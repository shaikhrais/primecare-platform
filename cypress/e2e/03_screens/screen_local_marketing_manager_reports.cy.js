// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_reports", () => {
  it("opens and verifies screen local_marketing_manager_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Local Marketing Manager Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Local Marketing Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerreports-screen").should("be.visible");
  cy.getCy("localmarketingmanagerreports-title").should("be.visible");
  cy.getCy("localmarketingmanagerreports-content").should("be.visible");
  cy.getCy("localmarketing-btn-generate-report").should("be.visible");
  cy.getCy("localmarketing-btn-send-presentation").should("be.visible");
  cy.getCy("localmarketing-btn-alert-team").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Local Marketing Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Local Marketing Manager Reports successfully!\n");

  });
});
