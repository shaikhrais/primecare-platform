// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_outcomes_report", () => {
  it("opens and verifies screen clinical_outcomes_report", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Clinical Outcomes Report)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Outcomes Report...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaloutcomesreport-screen").should("be.visible");
  cy.getCy("clinicaloutcomesreport-title").should("be.visible");
  cy.getCy("clinicaloutcomesreport-content").should("be.visible");
  cy.getCy("clinical-outcomes-refresh-btn").should("be.visible");
  cy.getCy("clinical-outcomes-export-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Outcomes Report...");
  cy.waitAndSee();
  cy.screenshot("clinical_outcomes_report");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Outcomes Report successfully!\n");

  });
});
