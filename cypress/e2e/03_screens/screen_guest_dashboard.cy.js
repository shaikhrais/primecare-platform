// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - guest_dashboard", () => {
  it("opens and verifies screen guest_dashboard", () => {
    cy.loginAsRole("guest");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/guest-dashboard (GuestDashboardScreen)...");
  cy.visitWithSemantics("/common/guest-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GuestDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestdashboard-screen").should("be.visible");
  cy.getCy("guestdashboard-title").should("be.visible");
  cy.getCy("guestdashboard-content").should("be.visible");
  cy.getCy("guestdashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("guestdashboard-btn-sync-security").should("be.visible");
  cy.getCy("guestdashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GuestDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified GuestDashboardScreen successfully!\n");

  });
});
