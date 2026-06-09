// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_compliance", () => {
  it("opens and verifies screen receptionist_compliance", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/receptionist-compliance (ReceptionistComplianceScreen)...");
  cy.visitWithSemantics("/staff/receptionist-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ReceptionistComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistcompliance-screen").should("be.visible");
  cy.getCy("receptionistcompliance-title").should("be.visible");
  cy.getCy("receptionistcompliance-content").should("be.visible");
  cy.getCy("receptionist-btn-add-appointment").should("be.visible");
  cy.getCy("receptionist-btn-send-email").should("be.visible");
  cy.getCy("receptionist-btn-upload-document").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ReceptionistComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified ReceptionistComplianceScreen successfully!\n");

  });
});
