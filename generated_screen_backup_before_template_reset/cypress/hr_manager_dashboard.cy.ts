describe('HrManagerDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/hr_manager/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="hr_manager_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
