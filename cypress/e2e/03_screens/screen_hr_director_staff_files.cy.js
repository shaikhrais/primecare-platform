// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_staff_files", () => {
  it("opens and verifies screen hr_director_staff_files", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/hr-director-staff-files (HrDirectorStaffFilesScreen)...");
  cy.visitWithSemantics("/executive/hr-director-staff-files");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrDirectorStaffFilesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorstafffiles-screen").should("be.visible");
  cy.getCy("hrdirectorstafffiles-title").should("be.visible");
  cy.getCy("hrdirectorstafffiles-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrDirectorStaffFilesScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_staff_files");
  
  cy.task("log", "✅ PROGRESS: - Verified HrDirectorStaffFilesScreen successfully!\n");

  });
});
