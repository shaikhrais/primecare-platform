// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_training_compliance", () => {
  it("opens and verifies screen compliance_manager_training_compliance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Training Compliance)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Training Compliance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagertrainingcompliance-screen").should("be.visible");
  cy.getCy("compliancemanagertrainingcompliance-title").should("be.visible");
  cy.getCy("compliancemanagertrainingcompliance-content").should("be.visible");
  cy.getCy("compliance-dashboard-training-completion").should("be.visible");
  cy.getCy("compliance-dashboard-deadline-alerts").should("be.visible");
  cy.getCy("compliance-dashboard-training-materials").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Training Compliance...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_training_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Training Compliance successfully!\n");

  });
});
