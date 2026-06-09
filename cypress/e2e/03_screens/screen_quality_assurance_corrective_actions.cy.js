// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_corrective_actions", () => {
  it("opens and verifies screen quality_assurance_corrective_actions", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Quality Assurance Corrective Actions)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Quality Assurance Corrective Actions...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecorrectiveactions-screen").should("be.visible");
  cy.getCy("qualityassurancecorrectiveactions-title").should("be.visible");
  cy.getCy("qualityassurancecorrectiveactions-content").should("be.visible");
  cy.getCy("qa-corrective-actions-overview").should("be.visible");
  cy.getCy("qa-effectiveness-metrics").should("be.visible");
  cy.getCy("qa-alerts-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Quality Assurance Corrective Actions...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_corrective_actions");
  
  cy.task("log", "✅ PROGRESS: - Verified Quality Assurance Corrective Actions successfully!\n");

  });
});
