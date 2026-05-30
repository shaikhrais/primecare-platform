// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - referral_management", () => {
  it("opens and verifies screen referral_management", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/referral-management (ReferralManagementScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/referral-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ReferralManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("referralmanagement-screen").should("be.visible");
  cy.getCy("referralmanagement-title").should("be.visible");
  cy.getCy("referralmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ReferralManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("referral_management");
  
  cy.task("log", "✅ PROGRESS: - Verified ReferralManagementScreen successfully!\n");

  });
});
