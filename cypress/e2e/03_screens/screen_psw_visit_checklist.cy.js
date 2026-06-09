// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_visit_checklist", () => {
  it("opens and verifies screen psw_visit_checklist", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Visit Checklist)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Visit Checklist...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitchecklist-screen").should("be.visible");
  cy.getCy("pswvisitchecklist-title").should("be.visible");
  cy.getCy("pswvisitchecklist-content").should("be.visible");
  cy.getCy("psw-visit-checklist-complete").should("be.visible");
  cy.getCy("psw-visit-report-issue").should("be.visible");
  cy.getCy("psw-visit-submit-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Visit Checklist...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_checklist");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Visit Checklist successfully!\n");

  });
});
