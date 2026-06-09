// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_loved_one_schedule", () => {
  it("opens and verifies screen family_member_loved_one_schedule", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Family Member Loved One Schedule)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Member Loved One Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberlovedoneschedule-screen").should("be.visible");
  cy.getCy("familymemberlovedoneschedule-title").should("be.visible");
  cy.getCy("familymemberlovedoneschedule-content").should("be.visible");
  cy.getCy("family-schedule-view").should("be.visible");
  cy.getCy("appointment-add-btn").should("be.visible");
  cy.getCy("appointment-edit-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Member Loved One Schedule...");
  cy.waitAndSee();
  cy.screenshot("family_member_loved_one_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Member Loved One Schedule successfully!\n");

  });
});
