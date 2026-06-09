// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_observation_vitals_log", () => {
  it("opens and verifies screen psw_observation_vitals_log", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Observation Vitals Log)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Observation Vitals Log...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswobservationvitalslog-screen").should("be.visible");
  cy.getCy("pswobservationvitalslog-title").should("be.visible");
  cy.getCy("pswobservationvitalslog-content").should("be.visible");
  cy.getCy("psw-observation-log-btn-log").should("be.visible");
  cy.getCy("psw-observation-log-btn-report").should("be.visible");
  cy.getCy("psw-observation-log-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Observation Vitals Log...");
  cy.waitAndSee();
  cy.screenshot("psw_observation_vitals_log");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Observation Vitals Log successfully!\n");

  });
});
