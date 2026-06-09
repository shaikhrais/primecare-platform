// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - virtual_consult", () => {
  it("opens and verifies screen virtual_consult", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Virtual Consult)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Virtual Consult...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("virtualconsult-screen").should("be.visible");
  cy.getCy("virtualconsult-title").should("be.visible");
  cy.getCy("virtualconsult-content").should("be.visible");
  cy.getCy("telehealth-btn-reschedule").should("be.visible");
  cy.getCy("telehealth-btn-update-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Virtual Consult...");
  cy.waitAndSee();
  cy.screenshot("virtual_consult");
  
  cy.task("log", "✅ PROGRESS: - Verified Virtual Consult successfully!\n");

  });
});
