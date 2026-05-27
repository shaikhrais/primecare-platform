// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.clinical_director@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - clinical_director", () => {
  it("tests all screens for role clinical_director", () => {
    login();


  cy.visit("/clinical/clinical-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_dashboard");

  cy.visit("/common/clinic-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinic_dashboard");

  cy.visit("/clinical/clinical-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicalanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicalanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicalanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_analytics");

  cy.visit("/clinical/clinical-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicalcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicalcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicalcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_compliance");

  cy.visit("/clinical/clinical-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicalworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicalworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicalworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_workflow");

  cy.visit("/common/clinic-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinic_analytics");

  cy.visit("/common/clinic-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cliniccompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="cliniccompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="cliniccompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinic_compliance");

  cy.visit("/common/clinic-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinic_workflow");

  cy.visit("/clinical/clinical-director-staff-quality");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorstaffquality-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorstaffquality-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorstaffquality-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_staff_quality");

  cy.visit("/clinical/clinical-director-incident-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorincidentreview-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorincidentreview-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorincidentreview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_incident_review");

  cy.visit("/clinical/clinical-director-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_compliance");

  cy.visit("/clinical/clinical-director-reports");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorreports-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorreports-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorreports-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_reports");

  cy.visit("/clinical/clinical-director-approvals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorapprovals-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorapprovals-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorapprovals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_approvals");

  cy.visit("/clinical/clinical-director-performance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaldirectorperformance-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorperformance-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaldirectorperformance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_director_performance");

  cy.visit("/clinical/clinical-quality");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicalquality-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicalquality-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicalquality-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_quality");

  cy.visit("/clinical/staff-performance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffperformance-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffperformance-title"]`).should("be.visible");
  cy.get(`[data-cy="staffperformance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staff_performance");

  cy.visit("/clinical/compliance-review");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="compliancereview-screen"]`).should("be.visible");
  cy.get(`[data-cy="compliancereview-title"]`).should("be.visible");
  cy.get(`[data-cy="compliancereview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("compliance_review");

  cy.visit("/clinical/incident-oversight");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="incidentoversight-screen"]`).should("be.visible");
  cy.get(`[data-cy="incidentoversight-title"]`).should("be.visible");
  cy.get(`[data-cy="incidentoversight-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("incident_oversight");

  cy.visit("/clinical/clinical-operations4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clinicaloperations4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="clinicaloperations4k-title"]`).should("be.visible");
  cy.get(`[data-cy="clinicaloperations4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("clinical_operations4_k");

  });
});
