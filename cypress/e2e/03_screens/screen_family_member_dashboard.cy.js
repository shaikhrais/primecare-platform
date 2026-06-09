// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_dashboard", () => {
  it("opens and verifies screen family_member_dashboard", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/family-member-dashboard (FamilyMemberDashboardScreen)...");
  cy.visitWithSemantics("/common/family-member-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FamilyMemberDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberdashboard-screen").should("be.visible");
  cy.getCy("familymemberdashboard-title").should("be.visible");
  cy.getCy("familymemberdashboard-content").should("be.visible");
  cy.getCy("family_member_dashboard-btn-execute-audit").should("be.visible");
  cy.getCy("family_member_dashboard-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FamilyMemberDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified FamilyMemberDashboardScreen successfully!\n");

  });
});
