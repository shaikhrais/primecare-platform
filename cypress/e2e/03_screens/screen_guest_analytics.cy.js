// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - guest_analytics", () => {
  it("opens and verifies screen guest_analytics", () => {
    cy.loginAsRole("guest");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/guest-analytics (GuestAnalyticsScreen)...");
  cy.visitWithSemantics("/common/guest-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GuestAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestanalytics-screen").should("be.visible");
  cy.getCy("guestanalytics-title").should("be.visible");
  cy.getCy("guestanalytics-content").should("be.visible");
  cy.getCy("analytics-refresh-btn").should("be.visible");
  cy.getCy("analytics-execute-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GuestAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified GuestAnalyticsScreen successfully!\n");

  });
});
