describe("Visual Component - Feedback States", () => {
  it("verifies success screen triggers", () => {
    cy.visitWithSemantics("/#/login");
    cy.loginAsRole("psw");
    cy.getCy("app-shell").should("be.visible");
    cy.screenshot("component-feedback-success");
  });
});