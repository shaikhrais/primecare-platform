// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.patient@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - patient", () => {
  it("tests all screens for role patient", () => {
    login();


  cy.visit("/common/family-member-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familymemberdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="familymemberdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="familymemberdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_member_dashboard");

  cy.visit("/common/patient-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="patientdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_dashboard");

  cy.visit("/common/patient-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="patientanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_analytics");

  cy.visit("/common/patient-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="patientcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_compliance");

  cy.visit("/common/patient-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="patientworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_workflow");

  cy.visit("/common/patient-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientcommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientcommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="patientcommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_command_center");

  cy.visit("/common/patient-appointments");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientappointments-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientappointments-title"]`).should("be.visible");
  cy.get(`[data-cy="patientappointments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_appointments");

  cy.visit("/common/patient-care-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientcareplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientcareplan-title"]`).should("be.visible");
  cy.get(`[data-cy="patientcareplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_care_plan");

  cy.visit("/common/patient-messages");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientmessages-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientmessages-title"]`).should("be.visible");
  cy.get(`[data-cy="patientmessages-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_messages");

  cy.visit("/common/patient-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientdocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientdocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="patientdocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_documents");

  cy.visit("/common/patient-billing");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientbilling-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientbilling-title"]`).should("be.visible");
  cy.get(`[data-cy="patientbilling-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_billing");

  cy.visit("/common/patient-profile");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="patientprofile-screen"]`).should("be.visible");
  cy.get(`[data-cy="patientprofile-title"]`).should("be.visible");
  cy.get(`[data-cy="patientprofile-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("patient_profile");

  cy.visit("/common/appointment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="appointment-screen"]`).should("be.visible");
  cy.get(`[data-cy="appointment-title"]`).should("be.visible");
  cy.get(`[data-cy="appointment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("appointment");

  cy.visit("/common/care-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="careplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="careplan-title"]`).should("be.visible");
  cy.get(`[data-cy="careplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("care_plan");

  cy.visit("/common/billing");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billing-screen"]`).should("be.visible");
  cy.get(`[data-cy="billing-title"]`).should("be.visible");
  cy.get(`[data-cy="billing-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing");

  cy.visit("/common/documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="documents-screen"]`).should("be.visible");
  cy.get(`[data-cy="documents-title"]`).should("be.visible");
  cy.get(`[data-cy="documents-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("documents");

  });
});
