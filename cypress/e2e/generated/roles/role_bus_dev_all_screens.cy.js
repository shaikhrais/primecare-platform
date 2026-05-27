// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.bus_dev@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - bus_dev", () => {
  it("tests all screens for role bus_dev", () => {
    login();


  cy.visit("/common/business-development-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="businessdevelopmentdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("business_development_dashboard");

  cy.visit("/management/head-of-bus-dev-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofbusdevdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_bus_dev_dashboard");

  cy.visit("/common/business-development-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="businessdevelopmentanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("business_development_analytics");

  cy.visit("/common/business-development-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="businessdevelopmentcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("business_development_compliance");

  cy.visit("/common/business-development-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="businessdevelopmentworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="businessdevelopmentworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("business_development_workflow");

  cy.visit("/management/head-of-bus-dev-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofbusdevanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_bus_dev_analytics");

  cy.visit("/management/head-of-bus-dev-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofbusdevcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_bus_dev_compliance");

  cy.visit("/management/head-of-bus-dev-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofbusdevworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="headofbusdevworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_bus_dev_workflow");

  cy.visit("/management/franchise-lead");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="franchiselead-screen"]`).should("be.visible");
  cy.get(`[data-cy="franchiselead-title"]`).should("be.visible");
  cy.get(`[data-cy="franchiselead-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("franchise_lead");

  cy.visit("/management/partnership-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="partnershipmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="partnershipmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("partnership_management");

  cy.visit("/management/growth-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="growthanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="growthanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="growthanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("growth_analytics");

  cy.visit("/management/outreach-campaign");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="outreachcampaign-screen"]`).should("be.visible");
  cy.get(`[data-cy="outreachcampaign-title"]`).should("be.visible");
  cy.get(`[data-cy="outreachcampaign-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("outreach_campaign");

  });
});
