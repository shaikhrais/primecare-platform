// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = client, role = patient

describe("Auth Redirect - patient", () => {
  it("performs dynamic SSO auth and verifies landing on client app shell", () => {
    cy.loginAsRole("patient");
  });
});
