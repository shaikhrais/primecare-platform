// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_incident_review", () => {
  it("opens and verifies screen compliance_manager_incident_review", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/incident-review (Compliance Manager Incident Review)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Incident Review...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerincidentreview-screen").should("be.visible");
  cy.getCy("compliancemanagerincidentreview-title").should("be.visible");
  cy.getCy("compliancemanagerincidentreview-content").should("be.visible");
  cy.getCy("compliance-manager-btn-document-findings").should("be.visible");
  cy.getCy("compliance-manager-btn-generate-report").should("be.visible");
  cy.getCy("compliance-manager-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Incident Review...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_incident_review");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Incident Review successfully!\n");

  });
});
