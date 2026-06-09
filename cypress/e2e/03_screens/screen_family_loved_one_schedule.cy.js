// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_loved_one_schedule", () => {
  it("opens and verifies screen family_loved_one_schedule", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/family_member/loved-one-schedule (Family Loved One Schedule)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/loved-one-schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Loved One Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familylovedoneschedule-screen").should("be.visible");
  cy.getCy("familylovedoneschedule-title").should("be.visible");
  cy.getCy("familylovedoneschedule-content").should("be.visible");
  cy.getCy("family-schedule-view").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Loved One Schedule...");
  cy.waitAndSee();
  cy.screenshot("family_loved_one_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Loved One Schedule successfully!\n");

  });
});
