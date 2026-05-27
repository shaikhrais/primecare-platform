describe("Visual Component - Sidebar", () => {
  it("verifies sidebar nav rendering", () => {
    cy.visitWithSemantics("/#/login");
    cy.loginAsRole("psw");
    cy.getCy("app-sidebar").should("be.visible");
    cy.screenshot("component-app-sidebar");
  });
});