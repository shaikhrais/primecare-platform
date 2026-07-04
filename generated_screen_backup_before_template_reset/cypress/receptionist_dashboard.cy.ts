describe('ReceptionistDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/staff/receptionist-dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="receptionist_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
