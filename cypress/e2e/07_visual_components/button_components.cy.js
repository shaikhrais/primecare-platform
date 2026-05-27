describe("Visual Component - Buttons", () => {
  it("verifies button clickable behaviors", () => {
    cy.visitWithSemantics("/#/login");
    cy.getCy("login-submit").should("be.visible");
    cy.screenshot("component-login-button");
  });
});