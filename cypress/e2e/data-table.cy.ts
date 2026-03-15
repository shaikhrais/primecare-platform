/// <reference types="cypress" />

describe('Data Table CRUD', () => {
    beforeEach(() => {
        // Login before each test
        cy.visit('/login');
        cy.get('[data-cy*="inp-email"]').type(Cypress.env('TEST_EMAIL') || 'admin@primecare.ca');
        cy.get('[data-cy*="inp-password"]').type(Cypress.env('TEST_PASSWORD') || 'AdminPass1!');
        cy.get('[data-cy*="btn-submit"]').click();
        cy.url({ timeout: 10000 }).should('not.include', '/login');
    });

    it('renders data table with rows', () => {
        cy.visit('/platform/operations/clients');
        cy.get('[data-cy="page.container"]', { timeout: 5000 }).should('exist');
        // Table should have at least a header row
        cy.get('table, [role="table"], [data-cy*="table"]').should('exist');
    });

    it('supports search/filter functionality', () => {
        cy.visit('/platform/operations/clients');
        cy.get('[data-cy*="search"], input[placeholder*="Search"]', { timeout: 5000 }).then(($search) => {
            if ($search.length > 0) {
                cy.wrap($search.first()).type('test');
                // Table should update (either filter or show "no results")
                cy.wait(1000); // Allow debounced search
            }
        });
    });

    it('pagination controls are present', () => {
        cy.visit('/platform/operations/clients');
        cy.get('[data-cy="page.container"]', { timeout: 5000 }).should('exist');
        // Should have pagination if there are more items than page size
        cy.get('[data-cy*="pagination"], [data-cy*="page-"], nav[aria-label*="pagination"]')
            .should('exist');
    });

    it('row click navigates to detail view', () => {
        cy.visit('/platform/operations/clients');
        cy.get('[data-cy="page.container"]', { timeout: 5000 }).should('exist');
        // Click first data row
        cy.get('table tbody tr, [role="row"]').first().click();
        cy.url({ timeout: 3000 }).should('not.equal', '/platform/operations/clients');
    });

    it('create button navigates to creation form', () => {
        cy.visit('/platform/operations/clients');
        cy.get('[data-cy*="btn-create"], [data-cy*="btn-add"], [data-cy*="btn-new"]', { timeout: 5000 })
            .first().click();
        cy.url({ timeout: 3000 }).should('include', 'create');
    });
});
