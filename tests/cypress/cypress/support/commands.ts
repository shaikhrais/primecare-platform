/// <reference types="cypress" />

declare global {
    namespace Cypress {
        interface Chainable {
            login(email: string, role: string): Chainable<void>;
            mockGeolocation(latitude: number, longitude: number): Chainable<AUTWindow>;
        }
    }
}

Cypress.Commands.add('login', (email: string, role: string) => {
    const password = 'PrimeCare123!';
    const roleParam = role === 'admin' ? '' : `?role=${role}`;
    cy.visit(`/login${roleParam}`);
    cy.get('input[type="email"]').type(email);
    cy.get('input[type="password"]').type(password);
    cy.get('button[type="submit"]').click();
    cy.url().should('include', '/dashboard');
});

Cypress.Commands.add('mockGeolocation', (latitude: number, longitude: number) => {
    cy.window().then((win) => {
        cy.stub(win.navigator.geolocation, 'getCurrentPosition').callsFake((cb) => {
            return cb({
                coords: {
                    latitude,
                    longitude,
                    accuracy: 10,
                },
            });
        });
    });
});

export { };
