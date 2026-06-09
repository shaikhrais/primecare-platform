// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_staff_files", () => {
  it("opens and verifies screen hr_staff_files", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Hr Staff Files)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hr Staff Files...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrstafffiles-screen").should("be.visible");
  cy.getCy("hrstafffiles-title").should("be.visible");
  cy.getCy("hrstafffiles-content").should("be.visible");
  cy.getCy("hrstafffiles-btn-submit-event-log").should("be.visible");
  cy.getCy("hrstafffiles-btn-refresh-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hr Staff Files...");
  cy.waitAndSee();
  cy.screenshot("hr_staff_files");
  
  cy.task("log", "✅ PROGRESS: - Verified Hr Staff Files successfully!\n");

  });
});
