describe("Visual Component - Forms", () => {
  it("verifies credentials form fields", () => {
    cy.visitWithSemantics("/#/login");
    cy.getCy("login-email").should("be.visible");
    cy.getCy("login-password").should("be.visible");
    cy.screenshot("component-login-form");
  });
});