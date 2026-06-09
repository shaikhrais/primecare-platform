// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_schedule", () => {
  it("opens and verifies screen psw_schedule", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Schedule)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswschedule-screen").should("be.visible");
  cy.getCy("pswschedule-title").should("be.visible");
  cy.getCy("pswschedule-content").should("be.visible");
  cy.getCy("pswschedule-btn-refresh").should("be.visible");
  cy.getCy("pswschedule-btn-view-compliance").should("be.visible");
  cy.getCy("pswschedule-btn-sync").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Schedule...");
  cy.waitAndSee();
  cy.screenshot("psw_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Schedule successfully!\n");

  });
});
