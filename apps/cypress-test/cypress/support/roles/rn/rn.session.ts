export function rnSession() {
    cy.session("rn", () => {
        cy.loginAs("rn");
    });
}
