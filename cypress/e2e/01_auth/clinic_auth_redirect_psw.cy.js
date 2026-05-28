// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = clinic, role = psw

describe("Auth Redirect - psw", () => {
  it("performs dynamic SSO auth and verifies landing on clinic app shell", () => {
    cy.loginAsRole("psw");
  });
});
