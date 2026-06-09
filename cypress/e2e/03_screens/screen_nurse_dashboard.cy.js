// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - nurse_dashboard", () => {
  it("opens and verifies screen nurse_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Nurse Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Nurse Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nursedashboard-screen").should("be.visible");
  cy.getCy("nursedashboard-title").should("be.visible");
  cy.getCy("nursedashboard-content").should("be.visible");
  cy.getCy("nurse-dashboard-patient-status").should("be.visible");
  cy.getCy("nurse-dashboard-patient-records").should("be.visible");
  cy.getCy("nurse-dashboard-medication-management").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Nurse Dashboard...");
  cy.waitAndSee();
  cy.screenshot("nurse_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Nurse Dashboard successfully!\n");

  });
});
