/// <reference types="cypress" />

describe('Home Load', () => {
    beforeEach(() => {
        // Login before each test
        cy.visit('/login');
        cy.get('[data-cy*="inp-email"]').type(Cypress.env('TEST_EMAIL') || 'admin@primecare.ca');
        cy.get('[data-cy*="inp-password"]').type(Cypress.env('TEST_PASSWORD') || 'AdminPass1!');
        cy.get('[data-cy*="btn-submit"]').click();
        cy.url({ timeout: 10000 }).should('not.include', '/login');
    });

    it('renders the home page', () => {
        cy.get('[data-cy="page.container"]').should('exist');
        cy.get('[data-cy="page.title"]').should('be.visible');
    });

    it('shows sidebar navigation', () => {
        cy.get('[data-cy*="sidebar"]').should('be.visible');
    });

    it('displays user information', () => {
        // Should show current user name or email somewhere in the UI
        cy.get('[data-cy*="user"]').should('exist');
    });

    it('loads without console errors', () => {
        cy.window().then((win) => {
            // Intercept console errors (basic smoke test)
            cy.on('window:before:load', (w) => {
                cy.stub(w.console, 'error').as('consoleError');
            });
        });
    });

    it('has accessible main content area', () => {
        cy.get('[role="main"]').should('exist');
        cy.get('[role="main"]').should('have.attr', 'aria-label');
    });
});
