// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.compliance@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - compliance", () => {
  it("tests all screens for role compliance", () => {
    login();


  cy.visit("/management/compliance-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancemanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_manager_dashboard");

  cy.visit("/management/compliance-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancemanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_manager_analytics");

  cy.visit("/management/compliance-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancemanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_manager_compliance");

  cy.visit("/management/compliance-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancemanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancemanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_manager_workflow");

  cy.visit("/management/compliance-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_dashboard");

  cy.visit("/management/audit-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="auditreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="auditreview-title"]`).should("be.visible");
  cy.get(`[data-cy="auditreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("audit_review");

  cy.visit("/management/incident-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="incidentmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="incidentmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="incidentmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("incident_management");

  cy.visit("/management/policy-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="policymanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="policymanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="policymanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("policy_management");

  cy.visit("/management/corrective-action");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="correctiveaction-screen"]`).should("be.visible");
  cy.get(`[data-cy="correctiveaction-title"]`).should("be.visible");
  cy.get(`[data-cy="correctiveaction-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("corrective_action");

  });
});
