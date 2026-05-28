// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = business_development, role = territory_expansion

describe("Auth Redirect - territory_expansion", () => {
  it("performs dynamic SSO auth and verifies landing on business_development app shell", () => {
    cy.loginAsRole("territory_expansion");
  });
});
