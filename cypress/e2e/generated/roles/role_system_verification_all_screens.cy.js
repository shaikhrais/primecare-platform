// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.system_verification@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - system_verification", () => {
  it("tests all screens for role system_verification", () => {
    login();


  cy.visit("/common/qa-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qadashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="qadashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="qadashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("qa_dashboard");

  cy.visit("/common/system-verification-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemverificationdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_verification_dashboard");

  cy.visit("/staff/quality-assurance-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="qualityassurancedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="qualityassurancedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="qualityassurancedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("quality_assurance_dashboard");

  cy.visit("/common/system-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="systemanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_analytics");

  cy.visit("/common/system-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="systemcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_compliance");

  cy.visit("/common/system-verification-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemverificationanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_verification_analytics");

  cy.visit("/common/system-verification-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemverificationcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_verification_compliance");

  cy.visit("/common/system-verification-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemverificationworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="systemverificationworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_verification_workflow");

  cy.visit("/common/system-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="systemworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="systemworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="systemworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("system_workflow");

  });
});
