// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_credential_tracking", () => {
  it("opens and verifies screen compliance_manager_credential_tracking", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Credential Tracking)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Credential Tracking...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagercredentialtracking-screen").should("be.visible");
  cy.getCy("compliancemanagercredentialtracking-title").should("be.visible");
  cy.getCy("compliancemanagercredentialtracking-content").should("be.visible");
  cy.getCy("compliance-dashboard-status").should("be.visible");
  cy.getCy("compliance-dashboard-update").should("be.visible");
  cy.getCy("compliance-dashboard-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Credential Tracking...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_credential_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Credential Tracking successfully!\n");

  });
});
