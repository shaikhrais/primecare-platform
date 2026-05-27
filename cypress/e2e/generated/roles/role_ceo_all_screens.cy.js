// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.ceo@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - ceo", () => {
  it("tests all screens for role ceo", () => {
    login();


  cy.visit("/executive/executive-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="executivecommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="executivecommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="executivecommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("executive_command_center");

  cy.visit("/executive/enterprise-health");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="enterprisehealth-screen"]`).should("be.visible");
  cy.get(`[data-cy="enterprisehealth-title"]`).should("be.visible");
  cy.get(`[data-cy="enterprisehealth-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("enterprise_health");

  cy.visit("/executive/revenue-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="revenueanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="revenueanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="revenueanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("revenue_analytics");

  cy.visit("/executive/risk-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="riskmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="riskmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="riskmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("risk_management");

  cy.visit("/executive/franchise-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiseoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiseoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiseoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_overview");

  cy.visit("/executive/enterprise-command-center4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="enterprisecommandcenter4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="enterprisecommandcenter4k-title"]`).should("be.visible");
  cy.get(`[data-cy="enterprisecommandcenter4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("enterprise_command_center4_k");

  });
});
