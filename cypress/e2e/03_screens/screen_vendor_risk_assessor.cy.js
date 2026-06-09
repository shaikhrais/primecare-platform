// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vendor_risk_assessor", () => {
  it("opens and verifies screen vendor_risk_assessor", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Vendor Risk Assessor)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Vendor Risk Assessor...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vendorriskassessor-screen").should("be.visible");
  cy.getCy("vendorriskassessor-title").should("be.visible");
  cy.getCy("vendorriskassessor-content").should("be.visible");
  cy.getCy("vendor-risk-assessor-refresh").should("be.visible");
  cy.getCy("vendor-risk-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Vendor Risk Assessor...");
  cy.waitAndSee();
  cy.screenshot("vendor_risk_assessor");
  
  cy.task("log", "✅ PROGRESS: - Verified Vendor Risk Assessor successfully!\n");

  });
});
