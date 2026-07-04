describe('GeneralManagerDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/business_development/roles/general_manager/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="general_manager_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
