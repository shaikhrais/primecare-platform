// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = support, role = regional_manager_usa

describe("Auth Redirect - regional_manager_usa", () => {
  it("performs dynamic SSO auth and verifies landing on support app shell", () => {
    cy.loginAsRole("regional_manager_usa");
  });
});
