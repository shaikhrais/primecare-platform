// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_guideline_library", () => {
  it("opens and verifies screen clinical_guideline_library", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Clinical Guideline Library)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Guideline Library...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalguidelinelibrary-screen").should("be.visible");
  cy.getCy("clinicalguidelinelibrary-title").should("be.visible");
  cy.getCy("clinicalguidelinelibrary-content").should("be.visible");
  cy.getCy("clinical-guideline-library-refresh").should("be.visible");
  cy.getCy("clinical-guideline-library-search").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Guideline Library...");
  cy.waitAndSee();
  cy.screenshot("clinical_guideline_library");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Guideline Library successfully!\n");

  });
});
