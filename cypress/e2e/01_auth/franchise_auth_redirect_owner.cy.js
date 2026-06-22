// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = franchise, role = owner

describe("Auth Redirect - owner", () => {
  it("performs dynamic SSO auth and verifies landing on franchise app shell", () => {
    cy.loginAsRole("owner");
  });
});
