// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.local_marketing@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - local_marketing", () => {
  it("tests all screens for role local_marketing", () => {
    login();


  cy.visit("/management/local-marketing-manager-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_dashboard");

  cy.visit("/management/local-marketing-manager-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanageranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanageranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanageranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_analytics");

  cy.visit("/management/local-marketing-manager-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_compliance");

  cy.visit("/management/local-marketing-manager-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="localmarketingmanagerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="localmarketingmanagerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("local_marketing_manager_workflow");

  });
});
