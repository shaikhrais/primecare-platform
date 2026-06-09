// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_compliance", () => {
  it("opens and verifies screen family_member_compliance", () => {
    cy.loginAsRole("family");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/family-member-compliance (FamilyMemberComplianceScreen)...");
  cy.visitWithSemantics("/common/family-member-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FamilyMemberComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymembercompliance-screen").should("be.visible");
  cy.getCy("familymembercompliance-title").should("be.visible");
  cy.getCy("familymembercompliance-content").should("be.visible");
  cy.getCy("family_member_compliance-scan-status").should("be.visible");
  cy.getCy("family_member_compliance-log-summary").should("be.visible");
  cy.getCy("family_member_compliance-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FamilyMemberComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified FamilyMemberComplianceScreen successfully!\n");

  });
});
