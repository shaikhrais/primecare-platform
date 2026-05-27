// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.infrastructure@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - infrastructure", () => {
  it("tests all screens for role infrastructure", () => {
    login();


  cy.visit("/common/infrastructure-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="infrastructuredashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="infrastructuredashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="infrastructuredashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("infrastructure_dashboard");

  cy.visit("/common/architecture-planning-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="architectureplanninganalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanninganalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanninganalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("architecture_planning_analytics");

  cy.visit("/common/architecture-planning-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="architectureplanningcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("architecture_planning_compliance");

  cy.visit("/common/architecture-planning-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="architectureplanningworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="architectureplanningworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("architecture_planning_workflow");

  cy.visit("/common/infrastructure-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="infrastructureanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="infrastructureanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="infrastructureanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("infrastructure_analytics");

  cy.visit("/common/infrastructure-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="infrastructurecompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="infrastructurecompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="infrastructurecompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("infrastructure_compliance");

  cy.visit("/common/infrastructure-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="infrastructureworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="infrastructureworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="infrastructureworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("infrastructure_workflow");

  });
});
