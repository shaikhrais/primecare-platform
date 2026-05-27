// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.family@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - family", () => {
  it("tests all screens for role family", () => {
    login();


  cy.visit("/common/family-member-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familymemberanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="familymemberanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="familymemberanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_member_analytics");

  cy.visit("/common/family-member-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familymembercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="familymembercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="familymembercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_member_compliance");

  cy.visit("/common/family-member-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familymemberworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="familymemberworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="familymemberworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_member_workflow");

  cy.visit("/common/family-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="familyoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="familyoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="familyoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("family_overview");

  cy.visit("/common/care-updates");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="careupdates-screen"]`).should("be.visible");
  cy.get(`[data-cy="careupdates-title"]`).should("be.visible");
  cy.get(`[data-cy="careupdates-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("care_updates");

  cy.visit("/common/billing-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="billingoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_overview");

  cy.visit("/common/emergency-contacts");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="emergencycontacts-screen"]`).should("be.visible");
  cy.get(`[data-cy="emergencycontacts-title"]`).should("be.visible");
  cy.get(`[data-cy="emergencycontacts-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("emergency_contacts");

  });
});
