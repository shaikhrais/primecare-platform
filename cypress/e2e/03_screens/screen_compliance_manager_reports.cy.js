// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_reports", () => {
  it("opens and verifies screen compliance_manager_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/reports (Compliance Manager Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerreports-screen").should("be.visible");
  cy.getCy("compliancemanagerreports-title").should("be.visible");
  cy.getCy("compliancemanagerreports-content").should("be.visible");
  cy.getCy("compliance-metrics-card").should("be.visible");
  cy.getCy("compliance-alerts-list").should("be.visible");
  cy.getCy("data-trends-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Reports successfully!\n");

  });
});
