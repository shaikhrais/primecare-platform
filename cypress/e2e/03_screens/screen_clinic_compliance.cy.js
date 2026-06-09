// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_compliance", () => {
  it("opens and verifies screen clinic_compliance", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/clinic-compliance (ClinicComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cliniccompliance-screen").should("be.visible");
  cy.getCy("cliniccompliance-title").should("be.visible");
  cy.getCy("cliniccompliance-content").should("be.visible");
  cy.getCy("clinic-compliance-audit-results").should("be.visible");
  cy.getCy("clinic-patient-satisfaction").should("be.visible");
  cy.getCy("clinic-staff-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicComplianceScreen successfully!\n");

  });
});
