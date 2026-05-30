// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_compliance", () => {
  it("opens and verifies screen hr_hiring_compliance", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/hr-hiring-compliance (HrHiringComplianceScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcompliance-screen").should("be.visible");
  cy.getCy("hrhiringcompliance-title").should("be.visible");
  cy.getCy("hrhiringcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringComplianceScreen successfully!\n");

  });
});
