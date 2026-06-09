// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - leadership_reports", () => {
  it("opens and verifies screen leadership_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /generated/offices/corporate/roles/ceo/leadership-reports (Leadership Reports)...");
  cy.visitWithSemantics("/generated/offices/corporate/roles/ceo/leadership-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Leadership Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadershipreports-screen").should("be.visible");
  cy.getCy("leadershipreports-title").should("be.visible");
  cy.getCy("leadershipreports-content").should("be.visible");
  cy.getCy("leadership-reports-analyze").should("be.visible");
  cy.getCy("leadership-reports-feedback").should("be.visible");
  cy.getCy("leadership-reports-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Leadership Reports...");
  cy.waitAndSee();
  cy.screenshot("leadership_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Leadership Reports successfully!\n");

  });
});
