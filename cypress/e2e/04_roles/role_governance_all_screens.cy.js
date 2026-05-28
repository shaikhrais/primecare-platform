// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - governance", () => {
  it("tests all screens for role governance", () => {
    cy.loginAsRole("governance");


  cy.visitWithSemantics("/common/system-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemdashboard-screen").should("be.visible");
  cy.getCy("systemdashboard-title").should("be.visible");
  cy.getCy("systemdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_dashboard");

  cy.visitWithSemantics("/management/governance-officer-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");

  cy.visitWithSemantics("/management/governance-officer-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficeranalytics-screen").should("be.visible");
  cy.getCy("governanceofficeranalytics-title").should("be.visible");
  cy.getCy("governanceofficeranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_analytics");

  cy.visitWithSemantics("/management/governance-officer-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");

  cy.visitWithSemantics("/management/governance-officer-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerworkflow-screen").should("be.visible");
  cy.getCy("governanceofficerworkflow-title").should("be.visible");
  cy.getCy("governanceofficerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_workflow");

  cy.visitWithSemantics("/common/governance-control-room");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governancecontrolroom-screen").should("be.visible");
  cy.getCy("governancecontrolroom-title").should("be.visible");
  cy.getCy("governancecontrolroom-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_control_room");

  cy.visitWithSemantics("/common/runtime-verification");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("runtimeverification-screen").should("be.visible");
  cy.getCy("runtimeverification-title").should("be.visible");
  cy.getCy("runtimeverification-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("runtime_verification");

  cy.visitWithSemantics("/common/drift-findings");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("driftfindings-screen").should("be.visible");
  cy.getCy("driftfindings-title").should("be.visible");
  cy.getCy("driftfindings-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("drift_findings");

  cy.visitWithSemantics("/common/pending-task-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pendingtaskqueue-screen").should("be.visible");
  cy.getCy("pendingtaskqueue-title").should("be.visible");
  cy.getCy("pendingtaskqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pending_task_queue");

  cy.visitWithSemantics("/common/agent-dispatch");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("agentdispatch-screen").should("be.visible");
  cy.getCy("agentdispatch-title").should("be.visible");
  cy.getCy("agentdispatch-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("agent_dispatch");

  cy.visitWithSemantics("/common/audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audit-screen").should("be.visible");
  cy.getCy("audit-title").should("be.visible");
  cy.getCy("audit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("audit");

  cy.visitWithSemantics("/common/api-health-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");

  cy.visitWithSemantics("/common/release-operations");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releaseoperations-screen").should("be.visible");
  cy.getCy("releaseoperations-title").should("be.visible");
  cy.getCy("releaseoperations-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("release_operations");

  cy.visitWithSemantics("/common/file-verification-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");

  cy.visitWithSemantics("/common/role-coverage-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rolecoveragedashboard-screen").should("be.visible");
  cy.getCy("rolecoveragedashboard-title").should("be.visible");
  cy.getCy("rolecoveragedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("role_coverage_dashboard");

  cy.visitWithSemantics("/common/responsive-preview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsivepreview-screen").should("be.visible");
  cy.getCy("responsivepreview-title").should("be.visible");
  cy.getCy("responsivepreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("responsive_preview");

  cy.visitWithSemantics("/common/workflow-execution");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowexecution-screen").should("be.visible");
  cy.getCy("workflowexecution-title").should("be.visible");
  cy.getCy("workflowexecution-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("workflow_execution");

  cy.visitWithSemantics("/common/governance-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceoperations4k-screen").should("be.visible");
  cy.getCy("governanceoperations4k-title").should("be.visible");
  cy.getCy("governanceoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_operations4_k");

  });
});
