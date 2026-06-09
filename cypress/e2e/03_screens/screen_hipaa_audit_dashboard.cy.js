// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hipaa_audit_dashboard", () => {
  it("opens and verifies screen hipaa_audit_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Hipaa Audit Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hipaa Audit Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hipaaauditdashboard-screen").should("be.visible");
  cy.getCy("hipaaauditdashboard-title").should("be.visible");
  cy.getCy("hipaaauditdashboard-content").should("be.visible");
  cy.getCy("audit-dashboard-btn-refresh").should("be.visible");
  cy.getCy("audit-dashboard-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hipaa Audit Dashboard...");
  cy.waitAndSee();
  cy.screenshot("hipaa_audit_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Hipaa Audit Dashboard successfully!\n");

  });
});
