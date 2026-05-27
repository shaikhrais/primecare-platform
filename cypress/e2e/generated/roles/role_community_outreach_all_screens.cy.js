// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.community_outreach@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - community_outreach", () => {
  it("tests all screens for role community_outreach", () => {
    login();


  cy.visit("/management/community-outreach-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communityoutreachdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("community_outreach_dashboard");

  cy.visit("/management/community-outreach-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communityoutreachanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("community_outreach_analytics");

  cy.visit("/management/community-outreach-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communityoutreachcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("community_outreach_compliance");

  cy.visit("/management/community-outreach-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="communityoutreachworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="communityoutreachworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("community_outreach_workflow");

  });
});
