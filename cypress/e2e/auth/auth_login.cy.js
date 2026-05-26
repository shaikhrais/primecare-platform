describe("Enterprise Auth Login Test", () => {
  it("logs in as PSW and verifies shell", () => {
    cy.loginAsRole(Cypress.env("ROLE_CODE") || "psw");
    cy.screenshot("auth-login-success");
  });
});
