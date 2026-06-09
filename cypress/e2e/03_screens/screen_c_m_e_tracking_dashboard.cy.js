// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - c_m_e_tracking_dashboard", () => {
  it("opens and verifies screen c_m_e_tracking_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (C M E Tracking Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for C M E Tracking Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cmetrackingdashboard-screen").should("be.visible");
  cy.getCy("cmetrackingdashboard-title").should("be.visible");
  cy.getCy("cmetrackingdashboard-content").should("be.visible");
  cy.getCy("cme-dashboard-earned-credits").should("be.visible");
  cy.getCy("cme-dashboard-required-credits").should("be.visible");
  cy.getCy("cme-dashboard-renewal-deadline").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for C M E Tracking Dashboard...");
  cy.waitAndSee();
  cy.screenshot("c_m_e_tracking_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified C M E Tracking Dashboard successfully!\n");

  });
});
