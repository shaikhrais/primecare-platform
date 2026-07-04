describe('TrainingCoordinatorDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/support/roles/training_coordinator/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="training_coordinator_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
