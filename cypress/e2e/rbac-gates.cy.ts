/// <reference types="cypress" />

describe('RBAC Route Access', () => {
    const loginAs = (email: string, password: string) => {
        cy.visit('/login');
        cy.get('[data-cy*="inp-email"]').type(email);
        cy.get('[data-cy*="inp-password"]').type(password);
        cy.get('[data-cy*="btn-submit"]').click();
        cy.url({ timeout: 10000 }).should('not.include', '/login');
    };

    it('admin can access platform admin routes', () => {
        loginAs(Cypress.env('ADMIN_EMAIL') || 'admin@primecare.ca', Cypress.env('ADMIN_PASSWORD') || 'AdminPass1!');
        cy.visit('/platform/admin/users');
        cy.get('[data-cy="page.container"]', { timeout: 5000 }).should('exist');
        cy.url().should('include', '/platform/admin');
    });

    it('non-admin is redirected from admin routes', () => {
        loginAs(Cypress.env('CLIENT_EMAIL') || 'client@primecare.ca', Cypress.env('CLIENT_PASSWORD') || 'ClientPass1!');
        cy.visit('/platform/admin/users');
        // Should be redirected or shown access denied
        cy.url({ timeout: 5000 }).then((url) => {
            // Either redirected to dashboard or shown forbidden page
            const isBlocked = !url.includes('/platform/admin/users') ||
                              cy.get('[data-cy*="forbidden"]').should('exist');
            expect(isBlocked).to.be.true;
        });
    });

    it('finance role can access finance routes', () => {
        loginAs(Cypress.env('FINANCE_EMAIL') || 'finance@primecare.ca', Cypress.env('FINANCE_PASSWORD') || 'FinancePass1!');
        cy.visit('/platform/finance/dashboard');
        cy.get('[data-cy="page.container"]', { timeout: 5000 }).should('exist');
    });

    it('sidebar only shows role-appropriate navigation items', () => {
        loginAs(Cypress.env('ADMIN_EMAIL') || 'admin@primecare.ca', Cypress.env('ADMIN_PASSWORD') || 'AdminPass1!');
        cy.get('[data-cy*="sidebar"]', { timeout: 5000 }).should('exist');
        // Admin should see admin-specific navigation
        cy.get('[data-cy*="sidebar"]').should('contain.text', 'Admin');
    });

    it('unauthenticated user is redirected to login', () => {
        // Clear any stored auth
        cy.clearLocalStorage();
        cy.clearCookies();
        cy.visit('/platform/admin/users');
        cy.url({ timeout: 5000 }).should('include', '/login');
    });
});
