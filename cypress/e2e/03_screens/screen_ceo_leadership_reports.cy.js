// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_leadership_reports", () => {
  it("opens and verifies screen ceo_leadership_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/leadership-reports (Ceo Leadership Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/leadership-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Leadership Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceoleadershipreports-screen").should("be.visible");
  cy.getCy("ceoleadershipreports-title").should("be.visible");
  cy.getCy("ceoleadershipreports-content").should("be.visible");
  cy.getCy("leadership-report-list").should("be.visible");
  cy.getCy("kpi-overview-card").should("be.visible");
  cy.getCy("data-trend-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Leadership Reports...");
  cy.waitAndSee();
  cy.screenshot("ceo_leadership_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Leadership Reports successfully!\n");

  });
});
