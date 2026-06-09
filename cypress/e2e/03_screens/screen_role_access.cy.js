// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - role_access", () => {
  it("opens and verifies screen role_access", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Role Access)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Role Access...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("roleaccess-btn-searchscreens").should("be.visible");
  cy.getCy("roleaccess-title").should("be.visible");
  cy.getCy("roleaccess-content").should("be.visible");
  cy.getCy("roleaccess-btn-viewroles").should("be.visible");
  cy.getCy("roleaccess-btn-assignaccess").should("be.visible");
  cy.getCy("roleaccess-btn-reviewrouting").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Role Access...");
  cy.waitAndSee();
  cy.screenshot("role_access");
  
  cy.task("log", "✅ PROGRESS: - Verified Role Access successfully!\n");

  });
});
