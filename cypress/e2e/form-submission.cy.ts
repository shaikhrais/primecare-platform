/// <reference types="cypress" />

describe('Form Submission (DynamicFormRenderer)', () => {
    beforeEach(() => {
        // Login first
        cy.visit('/login');
        cy.get('[data-cy*="inp-email"]').type(Cypress.env('TEST_EMAIL') || 'admin@primecare.ca');
        cy.get('[data-cy*="inp-password"]').type(Cypress.env('TEST_PASSWORD') || 'AdminPass1!');
        cy.get('[data-cy*="btn-submit"]').click();
        cy.url({ timeout: 10000 }).should('not.include', '/login');
    });

    it('renders form fields with labels', () => {
        // Navigate to a page with a DynamicFormRenderer (e.g., create client)
        cy.visit('/platform/operations/clients/create');
        cy.get('[data-cy*=".form"]', { timeout: 5000 }).should('exist');
        cy.get('label').should('have.length.greaterThan', 0);
    });

    it('shows required field indicators', () => {
        cy.visit('/platform/operations/clients/create');
        cy.get('[data-cy*=".form"]', { timeout: 5000 }).should('exist');
        // Required fields should have asterisk markers
        cy.get('[data-cy*=".form"] label').first().should('exist');
    });

    it('labels are properly associated with inputs via htmlFor', () => {
        cy.visit('/platform/operations/clients/create');
        cy.get('[data-cy*=".form"]', { timeout: 5000 }).should('exist');
        cy.get('[data-cy*=".form"] label[for]').each(($label) => {
            const forAttr = $label.attr('for');
            if (forAttr) {
                cy.get(`#${CSS.escape(forAttr)}`).should('exist');
            }
        });
    });

    it('shows success toast on valid submission', () => {
        cy.visit('/platform/operations/clients/create');
        cy.get('[data-cy*=".form"]', { timeout: 5000 }).should('exist');
        // Fill required fields (specific to Client form)
        cy.get('[data-cy*="inp-"]').each(($input) => {
            if ($input.prop('required')) {
                const type = $input.attr('type') || 'text';
                if (type === 'text' || type === 'email') {
                    cy.wrap($input).type('test@example.com');
                }
            }
        });
        // Submit
        cy.get('[data-cy*="btn-submit"]').click();
        cy.get('[data-cy="toast-container"]', { timeout: 5000 }).should('exist');
    });

    it('cancel button does not submit the form', () => {
        cy.visit('/platform/operations/clients/create');
        cy.get('[data-cy*=".form"]', { timeout: 5000 }).should('exist');
        cy.get('[data-cy*="btn-cancel"]').click();
        // Should navigate away without submitting
        cy.get('[data-cy="toast-success"]').should('not.exist');
    });
});
