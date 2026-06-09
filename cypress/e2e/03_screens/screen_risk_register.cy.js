// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - risk_register", () => {
  it("opens and verifies screen risk_register", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/risk-register (Risk Register)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/risk-register");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Risk Register...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("riskregister-screen").should("be.visible");
  cy.getCy("riskregister-title").should("be.visible");
  cy.getCy("riskregister-content").should("be.visible");
  cy.getCy("riskregister-btn-add").should("be.visible");
  cy.getCy("riskregister-btn-update").should("be.visible");
  cy.getCy("riskregister-btn-remove").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Risk Register...");
  cy.waitAndSee();
  cy.screenshot("risk_register");
  
  cy.task("log", "✅ PROGRESS: - Verified Risk Register successfully!\n");

  });
});
