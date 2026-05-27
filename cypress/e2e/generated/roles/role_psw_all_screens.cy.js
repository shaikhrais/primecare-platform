// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.psw@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - psw", () => {
  it("tests all screens for role psw", () => {
    login();


  cy.visit("/psw/psw-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="pswdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_dashboard");

  cy.visit("/psw/psw-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="pswanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_analytics");

  cy.visit("/psw/psw-clients");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswclients-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswclients-title"]`).should("be.visible");
  cy.get(`[data-cy="pswclients-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_clients");

  cy.visit("/psw/psw-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="pswcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_compliance");

  cy.visit("/psw/psw-messages");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswmessages-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswmessages-title"]`).should("be.visible");
  cy.get(`[data-cy="pswmessages-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_messages");

  cy.visit("/psw/psw-shift-tracker");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswshifttracker-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswshifttracker-title"]`).should("be.visible");
  cy.get(`[data-cy="pswshifttracker-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_shift_tracker");

  cy.visit("/psw/psw-tasks");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswtasks-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswtasks-title"]`).should("be.visible");
  cy.get(`[data-cy="pswtasks-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_tasks");

  cy.visit("/psw/psw-visit-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswvisitnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswvisitnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="pswvisitnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_visit_notes");

  cy.visit("/psw/psw-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="pswworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_workflow");

  cy.visit("/psw/psw-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswcommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswcommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="pswcommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_command_center");

  cy.visit("/psw/psw-my-shifts");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswmyshifts-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswmyshifts-title"]`).should("be.visible");
  cy.get(`[data-cy="pswmyshifts-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_my_shifts");

  cy.visit("/psw/psw-client-profile");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswclientprofile-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswclientprofile-title"]`).should("be.visible");
  cy.get(`[data-cy="pswclientprofile-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_client_profile");

  cy.visit("/psw/psw-visit-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswvisitnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswvisitnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="pswvisitnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_visit_notes");

  cy.visit("/psw/psw-vitals-log");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswvitalslog-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswvitalslog-title"]`).should("be.visible");
  cy.get(`[data-cy="pswvitalslog-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_vitals_log");

  cy.visit("/psw/psw-incident-report");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswincidentreport-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswincidentreport-title"]`).should("be.visible");
  cy.get(`[data-cy="pswincidentreport-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_incident_report");

  cy.visit("/psw/psw-care-plan");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswcareplan-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswcareplan-title"]`).should("be.visible");
  cy.get(`[data-cy="pswcareplan-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_care_plan");

  cy.visit("/psw/psw-messages");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswmessages-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswmessages-title"]`).should("be.visible");
  cy.get(`[data-cy="pswmessages-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_messages");

  cy.visit("/psw/psw-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="pswdocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="pswdocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="pswdocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("psw_documents");

  cy.visit("/psw/shift-tasks");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="shifttasks-screen"]`).should("be.visible");
  cy.get(`[data-cy="shifttasks-title"]`).should("be.visible");
  cy.get(`[data-cy="shifttasks-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shift_tasks");

  cy.visit("/psw/visit-notes");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="visitnotes-screen"]`).should("be.visible");
  cy.get(`[data-cy="visitnotes-title"]`).should("be.visible");
  cy.get(`[data-cy="visitnotes-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("visit_notes");

  cy.visit("/psw/vitals-entry");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="vitalsentry-screen"]`).should("be.visible");
  cy.get(`[data-cy="vitalsentry-title"]`).should("be.visible");
  cy.get(`[data-cy="vitalsentry-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("vitals_entry");

  cy.visit("/psw/incident-report");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="incidentreport-screen"]`).should("be.visible");
  cy.get(`[data-cy="incidentreport-title"]`).should("be.visible");
  cy.get(`[data-cy="incidentreport-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("incident_report");

  });
});
