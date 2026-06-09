// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_trial_recruitment_dashboard", () => {
  it("opens and verifies screen clinical_trial_recruitment_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Clinical Trial Recruitment Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Trial Recruitment Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaltrialrecruitmentdashboard-screen").should("be.visible");
  cy.getCy("clinicaltrialrecruitmentdashboard-title").should("be.visible");
  cy.getCy("clinicaltrialrecruitmentdashboard-content").should("be.visible");
  cy.getCy("dashboard-btn-generate-report").should("be.visible");
  cy.getCy("dashboard-btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Trial Recruitment Dashboard...");
  cy.waitAndSee();
  cy.screenshot("clinical_trial_recruitment_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Trial Recruitment Dashboard successfully!\n");

  });
});
