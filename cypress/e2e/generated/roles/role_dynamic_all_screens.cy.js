// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.dynamic@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - dynamic", () => {
  it("tests all screens for role dynamic", () => {
    login();


  cy.visit("/common/customer-support-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="customersupportdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="customersupportdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="customersupportdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("customer_support_dashboard");

  cy.visit("/common/support-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="supportdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="supportdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="supportdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("support_dashboard");

  cy.visit("/common/dynamic-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dynamicanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="dynamicanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="dynamicanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("dynamic_analytics");

  cy.visit("/common/dynamic-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dynamiccompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="dynamiccompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="dynamiccompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("dynamic_compliance");

  cy.visit("/common/dynamic-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="dynamicworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="dynamicworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="dynamicworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("dynamic_workflow");

  cy.visit("/common/shared-stubs");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="sharedstubs-screen"]`).should("be.visible");
  cy.get(`[data-cy="sharedstubs-title"]`).should("be.visible");
  cy.get(`[data-cy="sharedstubs-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("shared_stubs");

  });
});
