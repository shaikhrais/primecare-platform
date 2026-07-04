describe('Report Incident E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/psw/incident-report');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="psw_incident_report-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
