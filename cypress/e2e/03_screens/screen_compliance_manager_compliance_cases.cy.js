// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_compliance_cases", () => {
  it("opens and verifies screen compliance_manager_compliance_cases", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Compliance Cases)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Compliance Cases...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagercompliancecases-screen").should("be.visible");
  cy.getCy("compliancemanagercompliancecases-title").should("be.visible");
  cy.getCy("compliancemanagercompliancecases-content").should("be.visible");
  cy.getCy("compliance-dashboard-overview").should("be.visible");
  cy.getCy("compliance-status-indicator").should("be.visible");
  cy.getCy("compliance-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Compliance Cases...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_compliance_cases");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Compliance Cases successfully!\n");

  });
});
