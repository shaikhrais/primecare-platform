// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.customer_support@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - customer_support", () => {
  it("tests all screens for role customer_support", () => {
    login();


  cy.visit("/common/customer-support-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="customersupportanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="customersupportanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="customersupportanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("customer_support_analytics");

  cy.visit("/common/customer-support-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="customersupportcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="customersupportcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="customersupportcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("customer_support_compliance");

  cy.visit("/common/customer-support-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="customersupportworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="customersupportworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="customersupportworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("customer_support_workflow");

  cy.visit("/common/support-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="supportanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="supportanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="supportanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("support_analytics");

  cy.visit("/common/support-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="supportcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="supportcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="supportcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("support_compliance");

  cy.visit("/common/support-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="supportworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="supportworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="supportworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("support_workflow");

  cy.visit("/staff/ticket-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="ticketmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="ticketmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="ticketmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("ticket_management");

  cy.visit("/staff/client-issue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="clientissue-screen"]`).should("be.visible");
  cy.get(`[data-cy="clientissue-title"]`).should("be.visible");
  cy.get(`[data-cy="clientissue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("client_issue");

  cy.visit("/staff/communication");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communication-screen"]`).should("be.visible");
  cy.get(`[data-cy="communication-title"]`).should("be.visible");
  cy.get(`[data-cy="communication-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("communication");

  cy.visit("/staff/resolution-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="resolutiontracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="resolutiontracking-title"]`).should("be.visible");
  cy.get(`[data-cy="resolutiontracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("resolution_tracking");

  });
});
