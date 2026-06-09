// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_care_updates", () => {
  it("opens and verifies screen family_care_updates", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/family_member/care-updates (Family Care Updates)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/care-updates");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Care Updates...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familycareupdates-screen").should("be.visible");
  cy.getCy("familycareupdates-title").should("be.visible");
  cy.getCy("familycareupdates-content").should("be.visible");
  cy.getCy("familycare-btn-report-issue").should("be.visible");
  cy.getCy("familycare-btn-provide-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Care Updates...");
  cy.waitAndSee();
  cy.screenshot("family_care_updates");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Care Updates successfully!\n");

  });
});
