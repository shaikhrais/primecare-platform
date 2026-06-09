// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_cases", () => {
  it("opens and verifies screen compliance_cases", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/compliance-cases (Compliance Cases)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/compliance-cases");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Cases...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancecases-screen").should("be.visible");
  cy.getCy("compliancecases-title").should("be.visible");
  cy.getCy("compliancecases-content").should("be.visible");
  cy.getCy("compliance-case-list").should("be.visible");
  cy.getCy("case-detail-view").should("be.visible");
  cy.getCy("generate-report-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Cases...");
  cy.waitAndSee();
  cy.screenshot("compliance_cases");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Cases successfully!\n");

  });
});
