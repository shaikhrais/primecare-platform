// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = business_development, role = bus_dev

describe("Auth Redirect - bus_dev", () => {
  it("performs dynamic SSO auth and verifies landing on business_development app shell", () => {
    cy.loginAsRole("bus_dev");
  });
});
