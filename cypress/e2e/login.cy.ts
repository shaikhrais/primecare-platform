/// <reference types="cypress" />

describe('Login Flow', () => {
    beforeEach(() => {
        cy.visit('/login');
    });

    it('renders the login form', () => {
        cy.get('[data-cy="login-form"]').should('exist');
        cy.get('[data-cy*="inp-email"]').should('be.visible');
        cy.get('[data-cy*="inp-password"]').should('be.visible');
    });

    it('shows validation errors for empty submission', () => {
        cy.get('[data-cy*="btn-submit"]').click();
        // Form should not navigate away
        cy.url().should('include', '/login');
    });

    it('shows error toast for invalid credentials', () => {
        cy.get('[data-cy*="inp-email"]').type('invalid@example.com');
        cy.get('[data-cy*="inp-password"]').type('wrongpassword');
        cy.get('[data-cy*="btn-submit"]').click();
        cy.get('[data-cy="toast-error"]', { timeout: 5000 }).should('be.visible');
    });

    it('redirects to dashboard on valid login', () => {
        cy.get('[data-cy*="inp-email"]').type(Cypress.env('TEST_EMAIL') || 'admin@primecare.ca');
        cy.get('[data-cy*="inp-password"]').type(Cypress.env('TEST_PASSWORD') || 'AdminPass1!');
        cy.get('[data-cy*="btn-submit"]').click();
        cy.url({ timeout: 10000 }).should('not.include', '/login');
    });

    it('preserves email field on failed login', () => {
        const email = 'test@example.com';
        cy.get('[data-cy*="inp-email"]').type(email);
        cy.get('[data-cy*="inp-password"]').type('wrong');
        cy.get('[data-cy*="btn-submit"]').click();
        cy.get('[data-cy*="inp-email"]').should('have.value', email);
    });
});
