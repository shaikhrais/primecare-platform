// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_meetings", () => {
  it("opens and verifies screen regional_bdm_meetings", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/meetings (Regional Bdm Meetings)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/meetings");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Meetings...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmmeetings-screen").should("be.visible");
  cy.getCy("regionalbdmmeetings-title").should("be.visible");
  cy.getCy("regionalbdmmeetings-content").should("be.visible");
  cy.getCy("meeting-schedule-widget").should("be.visible");
  cy.getCy("attendance-tracker-btn").should("be.visible");
  cy.getCy("action-item-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Meetings...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_meetings");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Meetings successfully!\n");

  });
});
