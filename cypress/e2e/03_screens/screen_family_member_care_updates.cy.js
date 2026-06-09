// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_care_updates", () => {
  it("opens and verifies screen family_member_care_updates", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Family Member Care Updates)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Member Care Updates...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymembercareupdates-screen").should("be.visible");
  cy.getCy("familymembercareupdates-title").should("be.visible");
  cy.getCy("familymembercareupdates-content").should("be.visible");
  cy.getCy("family-member-care-status").should("be.visible");
  cy.getCy("notification-alert").should("be.visible");
  cy.getCy("activity-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Member Care Updates...");
  cy.waitAndSee();
  cy.screenshot("family_member_care_updates");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Member Care Updates successfully!\n");

  });
});
