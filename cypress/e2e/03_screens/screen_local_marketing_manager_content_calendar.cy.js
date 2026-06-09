// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_content_calendar", () => {
  it("opens and verifies screen local_marketing_manager_content_calendar", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Local Marketing Manager Content Calendar)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Local Marketing Manager Content Calendar...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercontentcalendar-screen").should("be.visible");
  cy.getCy("localmarketingmanagercontentcalendar-title").should("be.visible");
  cy.getCy("localmarketingmanagercontentcalendar-content").should("be.visible");
  cy.getCy("localmarketing-btn-schedule").should("be.visible");
  cy.getCy("localmarketing-btn-approve").should("be.visible");
  cy.getCy("localmarketing-btn-viewmetrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Local Marketing Manager Content Calendar...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_content_calendar");
  
  cy.task("log", "✅ PROGRESS: - Verified Local Marketing Manager Content Calendar successfully!\n");

  });
});
