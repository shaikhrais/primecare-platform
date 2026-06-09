// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_dashboard", () => {
  it("opens and verifies screen family_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/family_member/dashboard (Family Dashboard)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familydashboard-screen").should("be.visible");
  cy.getCy("familydashboard-title").should("be.visible");
  cy.getCy("familydashboard-content").should("be.visible");
  cy.getCy("family-dashboard-btn-view-contributions").should("be.visible");
  cy.getCy("family-dashboard-btn-send-message").should("be.visible");
  cy.getCy("family-dashboard-btn-access-resources").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Dashboard...");
  cy.waitAndSee();
  cy.screenshot("family_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Dashboard successfully!\n");

  });
});
