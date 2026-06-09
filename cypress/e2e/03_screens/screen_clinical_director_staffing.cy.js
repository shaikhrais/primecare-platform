// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_staffing", () => {
  it("opens and verifies screen clinical_director_staffing", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Clinical Director Staffing)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Director Staffing...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorstaffing-screen").should("be.visible");
  cy.getCy("clinicaldirectorstaffing-title").should("be.visible");
  cy.getCy("clinicaldirectorstaffing-content").should("be.visible");
  cy.getCy("staffing-levels-card").should("be.visible");
  cy.getCy("staffing-request-approve-btn").should("be.visible");
  cy.getCy("staffing-report-generate-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Director Staffing...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_staffing");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Director Staffing successfully!\n");

  });
});
