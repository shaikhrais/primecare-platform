describe('Admin & Staff Roles - Operations Flow', () => {
    beforeEach(() => {
        cy.login('admin@primecare.com', 'admin');
    });

    it('should manage users and verify a PSW', () => {
        cy.contains('Users').click();
        cy.get('table').should('contain', 'psw@primecare.com');

        // Simulate verification
        cy.get('tr').contains('psw@primecare.com').parent().within(() => {
            cy.get('button').contains('Verify').click();
        });
        cy.contains('User verified').should('be.visible');
    });

    it('should assign a PSW to a request', () => {
        cy.contains('Scheduling').click();
        cy.contains('Requested').first().click(); // Open a requested visit
        cy.get('select[name="pswId"]').select(1); // Select a PSW
        cy.get('button').contains('Assign').click();
        cy.contains('Visit scheduled').should('be.visible');
    });

    it('should update services and rates', () => {
        cy.contains('Settings').click(); // Assuming Services are under settings or a dedicated tab
        cy.contains('Services').click();
        cy.contains('Foot Care').parent().find('button').contains('Edit').click();
        cy.get('input[name="hourlyRate"]').clear().type('55');
        cy.get('button').contains('Save').click();
        cy.contains('Service updated').should('be.visible');
    });

    it('should update CMS content (FAQs)', () => {
        cy.contains('CMS').click();
        cy.contains('FAQs').click();
        cy.get('button').contains('Add New').click();
        cy.get('input[name="question"]').type('How do I reset my password?');
        cy.get('textarea[name="answer"]').type('Click on "Forgot Password" on the login page.');
        cy.get('button').contains('Publish').click();
        cy.contains('FAQ published').should('be.visible');
    });

    it('should review and approve timesheets', () => {
        cy.contains('Payroll').click();
        cy.contains('Pending').first().parent().find('button').contains('Approve').click();
        cy.contains('Timesheet approved').should('be.visible');
    });
});
