// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rn_field_supervisor", () => {
  it("tests all screens for role rn_field_supervisor", () => {
    cy.loginAsRole("rn_field_supervisor");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for RnFieldSupervisorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");
  cy.getCy("rnfdashboard-btn-submit-audit").should("be.visible");
  cy.getCy("rnfdashboard-btn-update-policy").should("be.visible");
  cy.getCy("rnfdashboard-btn-export-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for RnFieldSupervisorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified RnFieldSupervisorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /rn/rn-field-supervisor-analytics (Registered Nurse (RN) Field Supervisor Analytics)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for Registered Nurse (RN) Field Supervisor Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisoranalytics-screen").should("be.visible");
  cy.getCy("rnfieldsupervisoranalytics-title").should("be.visible");
  cy.getCy("rnfieldsupervisoranalytics-content").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-view-metrics").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-report-incident").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-log-visit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for Registered Nurse (RN) Field Supervisor Analytics...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified Registered Nurse (RN) Field Supervisor Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /rn/rn-field-supervisor-workflow (Registered Nurse (RN) Field Supervisor Compliance Workflow)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for Registered Nurse (RN) Field Supervisor Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisorworkflow-screen").should("be.visible");
  cy.getCy("rnfieldsupervisorworkflow-title").should("be.visible");
  cy.getCy("rnfieldsupervisorworkflow-content").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-submit-compliance").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-request-training").should("be.visible");
  cy.getCy("rnfieldsupervisor-btn-log-field-visit").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for Registered Nurse (RN) Field Supervisor Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified Registered Nurse (RN) Field Supervisor Compliance Workflow successfully!\n");

  });
});
