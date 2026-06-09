// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_credentials", () => {
  it("opens and verifies screen hr_hiring_credentials", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/credentials (HrHiringCredentialsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/credentials");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringCredentialsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcredentials-screen").should("be.visible");
  cy.getCy("hrhiringcredentials-title").should("be.visible");
  cy.getCy("hrhiringcredentials-content").should("be.visible");
  cy.getCy("hr_hiring_btn_add_job").should("be.visible");
  cy.getCy("hr_hiring_btn_view_candidate").should("be.visible");
  cy.getCy("hr_hiring_btn_export_metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringCredentialsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_credentials");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringCredentialsScreen successfully!\n");

  });
});
