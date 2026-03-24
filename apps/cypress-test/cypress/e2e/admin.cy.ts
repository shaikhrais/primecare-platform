describe('Admin Role E2E', () => {
    beforeEach(() => {
        cy.loginAs('admin');
    });

    it('should view the admin home', () => {
        cy.visit('/platform/admin/home');
        cy.contains('Platform Growth').should('be.visible');
    });

    it('should manage users', () => {
        cy.visit('/platform/admin/users');
        cy.contains('User Management').should('be.visible');
    });

    it('should view leads', () => {
        cy.visit('/platform/admin/leads');
        cy.contains('Lead Pipeline').should('be.visible');
    });

    it('should view business setup', () => {
        cy.visit('/platform/admin/setup');
        cy.contains('Business Setup').should('be.visible');
    });
});
