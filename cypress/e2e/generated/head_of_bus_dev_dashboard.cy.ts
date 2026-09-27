describe('HeadOfBusDevDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/head_of_bus_dev/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="head_of_bus_dev_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
