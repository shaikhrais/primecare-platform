describe('RN Role E2E', () => {
    beforeEach(() => {
        cy.loginAs('rn');
    });

    it('should view the clinical dashboard', () => {
        cy.visit('/tenancy/rn/dashboard');
        cy.contains('Clinical Overview').should('be.visible');
    });

    it('should manage care plans', () => {
        cy.visit('/tenancy/rn/care-plans');
        cy.contains('Care Plan Management').should('be.visible');
    });

    it('should perform clinical audit', () => {
        cy.visit('/tenancy/rn/audit');
        cy.contains('Clinical Audit Center').should('be.visible');
    });

    it('should view assessments', () => {
        cy.visit('/tenancy/rn/assessments');
        cy.contains('Clinical Assessments').should('be.visible');
    });
});
