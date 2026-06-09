// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - medical_library_access_portal", () => {
  it("opens and verifies screen medical_library_access_portal", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Medical Library Access Portal)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Medical Library Access Portal...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medicallibraryaccessportal-screen").should("be.visible");
  cy.getCy("medicallibraryaccessportal-title").should("be.visible");
  cy.getCy("medicallibraryaccessportal-content").should("be.visible");
  cy.getCy("medical-library-refresh-button").should("be.visible");
  cy.getCy("medical-library-search-button").should("be.visible");
  cy.getCy("medical-library-error-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Medical Library Access Portal...");
  cy.waitAndSee();
  cy.screenshot("medical_library_access_portal");
  
  cy.task("log", "✅ PROGRESS: - Verified Medical Library Access Portal successfully!\n");

  });
});
