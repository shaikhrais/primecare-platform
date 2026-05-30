// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - guest_compliance", () => {
  it("opens and verifies screen guest_compliance", () => {
    cy.loginAsRole("guest");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/guest-compliance (GuestComplianceScreen)...");
  cy.visitWithSemantics("/common/guest-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GuestComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestcompliance-screen").should("be.visible");
  cy.getCy("guestcompliance-title").should("be.visible");
  cy.getCy("guestcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GuestComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified GuestComplianceScreen successfully!\n");

  });
});
