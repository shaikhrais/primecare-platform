// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_audits", () => {
  it("opens and verifies screen compliance_manager_audits", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Audits)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Audits...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanageraudits-screen").should("be.visible");
  cy.getCy("compliancemanageraudits-title").should("be.visible");
  cy.getCy("compliancemanageraudits-content").should("be.visible");
  cy.getCy("compliance-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("compliance-dashboard-btn-update-documentation").should("be.visible");
  cy.getCy("compliance-dashboard-btn-submit-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Audits...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_audits");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Audits successfully!\n");

  });
});
