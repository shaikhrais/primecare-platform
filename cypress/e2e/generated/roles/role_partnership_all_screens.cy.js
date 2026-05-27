// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.partnership@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - partnership", () => {
  it("tests all screens for role partnership", () => {
    login();


  cy.visit("/management/partnership-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_manager_dashboard");

  cy.visit("/management/partnership-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_manager_analytics");

  cy.visit("/management/partnership-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_manager_compliance");

  cy.visit("/management/partnership-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_manager_workflow");

  });
});
