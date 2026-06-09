// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_reports", () => {
  it("opens and verifies screen hr_hiring_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/reports (Hr Hiring Reports)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hr Hiring Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringreports-screen").should("be.visible");
  cy.getCy("hrhiringreports-title").should("be.visible");
  cy.getCy("hrhiringreports-content").should("be.visible");
  cy.getCy("hiring-reports-btn-generate").should("be.visible");
  cy.getCy("hiring-reports-btn-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hr Hiring Reports...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Hr Hiring Reports successfully!\n");

  });
});
