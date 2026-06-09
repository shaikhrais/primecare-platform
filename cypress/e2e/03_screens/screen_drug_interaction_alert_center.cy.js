// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - drug_interaction_alert_center", () => {
  it("opens and verifies screen drug_interaction_alert_center", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Drug Interaction Alert Center)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Drug Interaction Alert Center...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("druginteractionalertcenter-screen").should("be.visible");
  cy.getCy("druginteractionalertcenter-title").should("be.visible");
  cy.getCy("druginteractionalertcenter-content").should("be.visible");
  cy.getCy("druginteraction-alert-summary").should("be.visible");
  cy.getCy("druginteraction-alert-statistics").should("be.visible");
  cy.getCy("user-engagement-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Drug Interaction Alert Center...");
  cy.waitAndSee();
  cy.screenshot("drug_interaction_alert_center");
  
  cy.task("log", "✅ PROGRESS: - Verified Drug Interaction Alert Center successfully!\n");

  });
});
