// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - qa_compliance", () => {
  it("opens and verifies screen qa_compliance", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/qa-compliance (QaComplianceScreen)...");
  cy.visitWithSemantics("/common/qa-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QaComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qacompliance-screen").should("be.visible");
  cy.getCy("qacompliance-title").should("be.visible");
  cy.getCy("qacompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QaComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified QaComplianceScreen successfully!\n");

  });
});
