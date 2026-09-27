describe("Visual Component - Topbar", () => {
  it("verifies topbar contents render correctly", () => {
    cy.visitWithSemantics("/#/login");
    cy.loginAsRole("psw");
    cy.getCy("app-topbar").should("be.visible");
    cy.screenshot("component-app-topbar");
  });
});