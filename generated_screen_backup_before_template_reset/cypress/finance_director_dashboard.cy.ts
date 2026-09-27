describe('FinanceDirectorDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/finance_director/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="finance_director_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
