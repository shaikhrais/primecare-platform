// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = clinic, role = clinical_director

describe("Auth Redirect - clinical_director", () => {
  it("performs dynamic SSO auth and verifies landing on clinic app shell", () => {
    cy.loginAsRole("clinical_director");
  });
});
