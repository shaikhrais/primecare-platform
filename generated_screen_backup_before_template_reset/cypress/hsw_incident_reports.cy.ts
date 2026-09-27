describe('HswIncidentReportsScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/clinical/hsw-incident-reports');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="hsw_incident_reports-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
