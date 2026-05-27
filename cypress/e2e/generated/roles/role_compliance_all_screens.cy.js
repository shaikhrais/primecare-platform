// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - compliance", () => {
  it("tests all screens for role compliance", () => {
    cy.loginAsRole("compliance");


  cy.visit("/management/compliance-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerdashboard-screen").should("be.visible");
  cy.getCy("compliancemanagerdashboard-title").should("be.visible");
  cy.getCy("compliancemanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_dashboard");

  cy.visit("/management/compliance-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanageranalytics-screen").should("be.visible");
  cy.getCy("compliancemanageranalytics-title").should("be.visible");
  cy.getCy("compliancemanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_analytics");

  cy.visit("/management/compliance-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagercompliance-screen").should("be.visible");
  cy.getCy("compliancemanagercompliance-title").should("be.visible");
  cy.getCy("compliancemanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_compliance");

  cy.visit("/management/compliance-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerworkflow-screen").should("be.visible");
  cy.getCy("compliancemanagerworkflow-title").should("be.visible");
  cy.getCy("compliancemanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_workflow");

  cy.visit("/management/compliance-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancedashboard-screen").should("be.visible");
  cy.getCy("compliancedashboard-title").should("be.visible");
  cy.getCy("compliancedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_dashboard");

  cy.visit("/management/audit-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditreview-screen").should("be.visible");
  cy.getCy("auditreview-title").should("be.visible");
  cy.getCy("auditreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("audit_review");

  cy.visit("/management/incident-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentmanagement-screen").should("be.visible");
  cy.getCy("incidentmanagement-title").should("be.visible");
  cy.getCy("incidentmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_management");

  cy.visit("/management/policy-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policymanagement-screen").should("be.visible");
  cy.getCy("policymanagement-title").should("be.visible");
  cy.getCy("policymanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("policy_management");

  cy.visit("/management/corrective-action");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("correctiveaction-screen").should("be.visible");
  cy.getCy("correctiveaction-title").should("be.visible");
  cy.getCy("correctiveaction-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("corrective_action");

  });
});
