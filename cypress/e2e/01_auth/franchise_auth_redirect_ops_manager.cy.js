// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = franchise, role = ops_manager

describe("Auth Redirect - ops_manager", () => {
  it("performs dynamic SSO auth and verifies landing on franchise app shell", () => {
    cy.loginAsRole("ops_manager");
  });
});
