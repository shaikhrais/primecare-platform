// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = business_development, role = regional_manager_usa

describe("Auth Redirect - regional_manager_usa", () => {
  it("performs dynamic SSO auth and verifies landing on business_development app shell", () => {
    cy.loginAsRole("regional_manager_usa");
  });
});
