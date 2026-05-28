// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = clinic, role = therapist

describe("Auth Redirect - therapist", () => {
  it("performs dynamic SSO auth and verifies landing on clinic app shell", () => {
    cy.loginAsRole("therapist");
  });
});
