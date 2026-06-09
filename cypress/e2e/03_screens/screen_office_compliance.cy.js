// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - office_compliance", () => {
  it("opens and verifies screen office_compliance", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/office-compliance (OfficeComplianceScreen)...");
  cy.visitWithSemantics("/common/office-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OfficeComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officecompliance-screen").should("be.visible");
  cy.getCy("officecompliance-title").should("be.visible");
  cy.getCy("officecompliance-content").should("be.visible");
  cy.getCy("officecompliance-btn-addtask").should("be.visible");
  cy.getCy("officecompliance-btn-logcommunication").should("be.visible");
  cy.getCy("officecompliance-btn-schedulemeeting").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OfficeComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("office_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified OfficeComplianceScreen successfully!\n");

  });
});
