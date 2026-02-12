export function staffSession() {
    cy.session("staff", () => {
        cy.loginAs("staff");
    });
}
