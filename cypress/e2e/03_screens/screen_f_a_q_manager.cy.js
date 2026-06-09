// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - f_a_q_manager", () => {
  it("opens and verifies screen f_a_q_manager", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (F A Q Manager)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for F A Q Manager...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("faqmanager-screen").should("be.visible");
  cy.getCy("faqmanager-title").should("be.visible");
  cy.getCy("faqmanager-content").should("be.visible");
  cy.getCy("faq-manager-btn-add").should("be.visible");
  cy.getCy("faq-manager-btn-edit").should("be.visible");
  cy.getCy("faq-manager-btn-delete").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for F A Q Manager...");
  cy.waitAndSee();
  cy.screenshot("f_a_q_manager");
  
  cy.task("log", "✅ PROGRESS: - Verified F A Q Manager successfully!\n");

  });
});
