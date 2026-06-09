// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - email_marketing_automator", () => {
  it("opens and verifies screen email_marketing_automator", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Email Marketing Automator)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Email Marketing Automator...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("emailmarketingautomator-screen").should("be.visible");
  cy.getCy("emailmarketingautomator-title").should("be.visible");
  cy.getCy("emailmarketingautomator-content").should("be.visible");
  cy.getCy("emailjourney-btn-refresh").should("be.visible");
  cy.getCy("emailjourney-btn-create").should("be.visible");
  cy.getCy("emailjourney-btn-toggle").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Email Marketing Automator...");
  cy.waitAndSee();
  cy.screenshot("email_marketing_automator");
  
  cy.task("log", "✅ PROGRESS: - Verified Email Marketing Automator successfully!\n");

  });
});
