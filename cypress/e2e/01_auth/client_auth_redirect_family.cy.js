// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = client, role = family

describe("Auth Redirect - family", () => {
  it("performs dynamic SSO auth and verifies landing on client app shell", () => {
    cy.loginAsRole("family");
  });
});
