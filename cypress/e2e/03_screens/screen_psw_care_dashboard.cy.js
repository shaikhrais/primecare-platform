// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_care_dashboard", () => {
  it("opens and verifies screen psw_care_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Care Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Care Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcaredashboard-screen").should("be.visible");
  cy.getCy("pswcaredashboard-title").should("be.visible");
  cy.getCy("pswcaredashboard-content").should("be.visible");
  cy.getCy("psw-dashboard-btn-update-record").should("be.visible");
  cy.getCy("psw-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("psw-dashboard-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Care Dashboard...");
  cy.waitAndSee();
  cy.screenshot("psw_care_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Care Dashboard successfully!\n");

  });
});
