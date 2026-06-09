// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_staff_documents", () => {
  it("opens and verifies screen hr_hiring_staff_documents", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/staff-documents (Hr Hiring Staff Documents)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/staff-documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hr Hiring Staff Documents...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringstaffdocuments-screen").should("be.visible");
  cy.getCy("hrhiringstaffdocuments-title").should("be.visible");
  cy.getCy("hrhiringstaffdocuments-content").should("be.visible");
  cy.getCy("hiring-docs-btn-approve").should("be.visible");
  cy.getCy("hiring-docs-btn-upload").should("be.visible");
  cy.getCy("hiring-docs-btn-reminder").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hr Hiring Staff Documents...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_staff_documents");
  
  cy.task("log", "✅ PROGRESS: - Verified Hr Hiring Staff Documents successfully!\n");

  });
});
