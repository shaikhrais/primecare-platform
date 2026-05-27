// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rn", () => {
  it("tests all screens for role rn", () => {
    cy.loginAsRole("rn");


  cy.visit("/common/system-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemdashboard-screen").should("be.visible");
  cy.getCy("systemdashboard-title").should("be.visible");
  cy.getCy("systemdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_dashboard");

  cy.visit("/management/governance-officer-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");

  cy.visit("/rn/rn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rndashboard-screen").should("be.visible");
  cy.getCy("rndashboard-title").should("be.visible");
  cy.getCy("rndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_dashboard");

  cy.visit("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");

  cy.visit("/management/governance-officer-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficeranalytics-screen").should("be.visible");
  cy.getCy("governanceofficeranalytics-title").should("be.visible");
  cy.getCy("governanceofficeranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_analytics");

  cy.visit("/management/governance-officer-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");

  cy.visit("/management/governance-officer-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerworkflow-screen").should("be.visible");
  cy.getCy("governanceofficerworkflow-title").should("be.visible");
  cy.getCy("governanceofficerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_workflow");

  cy.visit("/rn/rn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnanalytics-screen").should("be.visible");
  cy.getCy("rnanalytics-title").should("be.visible");
  cy.getCy("rnanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_analytics");

  cy.visit("/rn/rn-assessments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnassessments-screen").should("be.visible");
  cy.getCy("rnassessments-title").should("be.visible");
  cy.getCy("rnassessments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_assessments");

  cy.visit("/rn/rn-care-plans");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplans-screen").should("be.visible");
  cy.getCy("rncareplans-title").should("be.visible");
  cy.getCy("rncareplans-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_care_plans");

  cy.visit("/rn/rn-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncompliance-screen").should("be.visible");
  cy.getCy("rncompliance-title").should("be.visible");
  cy.getCy("rncompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_compliance");

  cy.visit("/rn/rn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnworkflow-screen").should("be.visible");
  cy.getCy("rnworkflow-title").should("be.visible");
  cy.getCy("rnworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_workflow");

  cy.visit("/rn/rn-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncommandcenter-screen").should("be.visible");
  cy.getCy("rncommandcenter-title").should("be.visible");
  cy.getCy("rncommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_command_center");

  cy.visit("/rn/rn-patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnpatientcharting-screen").should("be.visible");
  cy.getCy("rnpatientcharting-title").should("be.visible");
  cy.getCy("rnpatientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_patient_charting");

  cy.visit("/rn/rn-medications");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnmedications-screen").should("be.visible");
  cy.getCy("rnmedications-title").should("be.visible");
  cy.getCy("rnmedications-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_medications");

  cy.visit("/rn/rn-vitals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnvitals-screen").should("be.visible");
  cy.getCy("rnvitals-title").should("be.visible");
  cy.getCy("rnvitals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_vitals");

  cy.visit("/rn/rn-care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplanreview-screen").should("be.visible");
  cy.getCy("rncareplanreview-title").should("be.visible");
  cy.getCy("rncareplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_care_plan_review");

  cy.visit("/rn/rn-incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnincidentreview-screen").should("be.visible");
  cy.getCy("rnincidentreview-title").should("be.visible");
  cy.getCy("rnincidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_incident_review");

  cy.visit("/rn/rn-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rntasks-screen").should("be.visible");
  cy.getCy("rntasks-title").should("be.visible");
  cy.getCy("rntasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_tasks");

  cy.visit("/rn/rn-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnreports-screen").should("be.visible");
  cy.getCy("rnreports-title").should("be.visible");
  cy.getCy("rnreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_reports");

  cy.visit("/rn/patient-charting");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcharting-screen").should("be.visible");
  cy.getCy("patientcharting-title").should("be.visible");
  cy.getCy("patientcharting-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_charting");

  cy.visit("/rn/medication-administration");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medicationadministration-screen").should("be.visible");
  cy.getCy("medicationadministration-title").should("be.visible");
  cy.getCy("medicationadministration-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("medication_administration");

  cy.visit("/rn/care-plan-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplanreview-screen").should("be.visible");
  cy.getCy("careplanreview-title").should("be.visible");
  cy.getCy("careplanreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_plan_review");

  cy.visit("/rn/incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreview-screen").should("be.visible");
  cy.getCy("incidentreview-title").should("be.visible");
  cy.getCy("incidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_review");

  cy.visit("/rn/shift-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shiftreport-screen").should("be.visible");
  cy.getCy("shiftreport-title").should("be.visible");
  cy.getCy("shiftreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shift_report");

  cy.visit("/common/governance-control-room");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governancecontrolroom-screen").should("be.visible");
  cy.getCy("governancecontrolroom-title").should("be.visible");
  cy.getCy("governancecontrolroom-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_control_room");

  cy.visit("/common/runtime-verification");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("runtimeverification-screen").should("be.visible");
  cy.getCy("runtimeverification-title").should("be.visible");
  cy.getCy("runtimeverification-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("runtime_verification");

  cy.visit("/common/drift-findings");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("driftfindings-screen").should("be.visible");
  cy.getCy("driftfindings-title").should("be.visible");
  cy.getCy("driftfindings-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("drift_findings");

  cy.visit("/common/pending-task-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pendingtaskqueue-screen").should("be.visible");
  cy.getCy("pendingtaskqueue-title").should("be.visible");
  cy.getCy("pendingtaskqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pending_task_queue");

  cy.visit("/common/agent-dispatch");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("agentdispatch-screen").should("be.visible");
  cy.getCy("agentdispatch-title").should("be.visible");
  cy.getCy("agentdispatch-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("agent_dispatch");

  cy.visit("/common/audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audit-screen").should("be.visible");
  cy.getCy("audit-title").should("be.visible");
  cy.getCy("audit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("audit");

  cy.visit("/common/api-health-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");

  cy.visit("/common/release-operations");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releaseoperations-screen").should("be.visible");
  cy.getCy("releaseoperations-title").should("be.visible");
  cy.getCy("releaseoperations-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("release_operations");

  cy.visit("/common/file-verification-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");

  cy.visit("/common/role-coverage-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rolecoveragedashboard-screen").should("be.visible");
  cy.getCy("rolecoveragedashboard-title").should("be.visible");
  cy.getCy("rolecoveragedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("role_coverage_dashboard");

  cy.visit("/common/responsive-preview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsivepreview-screen").should("be.visible");
  cy.getCy("responsivepreview-title").should("be.visible");
  cy.getCy("responsivepreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("responsive_preview");

  cy.visit("/common/workflow-execution");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowexecution-screen").should("be.visible");
  cy.getCy("workflowexecution-title").should("be.visible");
  cy.getCy("workflowexecution-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("workflow_execution");

  cy.visit("/common/governance-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceoperations4k-screen").should("be.visible");
  cy.getCy("governanceoperations4k-title").should("be.visible");
  cy.getCy("governanceoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_operations4_k");

  cy.visit("/rn/rn-field-supervisor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor analytics-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_analytics");

  cy.visit("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor compliance workflow-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");

  });
});
