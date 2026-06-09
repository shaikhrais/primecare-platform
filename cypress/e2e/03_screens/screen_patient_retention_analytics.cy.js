// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_retention_analytics", () => {
  it("opens and verifies screen patient_retention_analytics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Retention Analytics)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Retention Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientretentionanalytics-screen").should("be.visible");
  cy.getCy("patientretentionanalytics-title").should("be.visible");
  cy.getCy("patientretentionanalytics-content").should("be.visible");
  cy.getCy("analytics-btn-refresh").should("be.visible");
  cy.getCy("analytics-error-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Retention Analytics...");
  cy.waitAndSee();
  cy.screenshot("patient_retention_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Retention Analytics successfully!\n");

  });
});
