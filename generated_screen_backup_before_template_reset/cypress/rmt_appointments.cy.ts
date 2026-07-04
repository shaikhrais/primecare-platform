describe('RmtAppointmentsScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/rmt/appointments');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="rmt_appointments-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
