describe("Sanity Check", () => {
    it("visits login page", () => {
        cy.visit("http://localhost:5173/login");
        cy.get("body").should("be.visible");
    });
});
