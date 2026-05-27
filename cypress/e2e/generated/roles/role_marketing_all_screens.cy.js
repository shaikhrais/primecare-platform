// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.marketing@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - marketing", () => {
  it("tests all screens for role marketing", () => {
    login();


  cy.visit("/management/head-of-marketing-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofmarketingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_marketing_dashboard");

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

  cy.visit("/management/head-of-marketing-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofmarketinganalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketinganalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketinganalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_marketing_analytics");

  cy.visit("/management/head-of-marketing-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofmarketingcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_marketing_compliance");

  cy.visit("/management/head-of-marketing-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="headofmarketingworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="headofmarketingworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("head_of_marketing_workflow");

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

  cy.visit("/management/campaign-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="campaigndashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="campaigndashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="campaigndashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("campaign_dashboard");

  cy.visit("/management/lead-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="leadanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="leadanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="leadanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("lead_analytics");

  cy.visit("/management/social-media");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="socialmedia-screen"]`).should("be.visible");
  cy.get(`[data-cy="socialmedia-title"]`).should("be.visible");
  cy.get(`[data-cy="socialmedia-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("social_media");

  cy.visit("/management/brand-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="brandmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="brandmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="brandmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("brand_management");

  });
});
