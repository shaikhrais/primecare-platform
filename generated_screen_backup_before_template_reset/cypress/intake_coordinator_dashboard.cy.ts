describe('IntakeCoordinatorDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/intake_coordinator/dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="intake_coordinator_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
