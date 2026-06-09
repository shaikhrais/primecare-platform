// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - followup", () => {
  it("opens and verifies screen followup", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/followup (FollowupScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/followup");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FollowupScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("followup-screen").should("be.visible");
  cy.getCy("followup-title").should("be.visible");
  cy.getCy("followup-content").should("be.visible");
  cy.getCy("followup-btn-schedule").should("be.visible");
  cy.getCy("followup-btn-verify").should("be.visible");
  cy.getCy("followup-btn-send").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FollowupScreen...");
  cy.waitAndSee();
  cy.screenshot("followup");
  
  cy.task("log", "✅ PROGRESS: - Verified FollowupScreen successfully!\n");

  });
});
