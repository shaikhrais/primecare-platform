describe('OfficeDashboardScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/common/office-dashboard');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="office_dashboard-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
