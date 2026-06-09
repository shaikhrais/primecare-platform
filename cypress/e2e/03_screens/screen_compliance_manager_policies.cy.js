// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_policies", () => {
  it("opens and verifies screen compliance_manager_policies", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Policies)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Policies...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerpolicies-screen").should("be.visible");
  cy.getCy("compliancemanagerpolicies-title").should("be.visible");
  cy.getCy("compliancemanagerpolicies-content").should("be.visible");
  cy.getCy("compliance-dashboard-overview").should("be.visible");
  cy.getCy("compliance-alerts-review").should("be.visible");
  cy.getCy("compliance-metrics-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Policies...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_policies");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Policies successfully!\n");

  });
});
