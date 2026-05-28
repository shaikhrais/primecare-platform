// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = client, role = guest

describe("Auth Redirect - guest", () => {
  it("performs dynamic SSO auth and verifies landing on client app shell", () => {
    cy.loginAsRole("guest");
  });
});
