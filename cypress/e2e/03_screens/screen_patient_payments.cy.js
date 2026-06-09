// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_payments", () => {
  it("opens and verifies screen patient_payments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/client/payments (Patient Payments)...");
  cy.visitWithSemantics("/offices/client/roles/client/payments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Payments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientpayments-screen").should("be.visible");
  cy.getCy("patientpayments-title").should("be.visible");
  cy.getCy("patientpayments-content").should("be.visible");
  cy.getCy("patientpayments-btn-process").should("be.visible");
  cy.getCy("patientpayments-btn-viewhistory").should("be.visible");
  cy.getCy("patientpayments-btn-generateReport").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Payments...");
  cy.waitAndSee();
  cy.screenshot("patient_payments");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Payments successfully!\n");

  });
});
