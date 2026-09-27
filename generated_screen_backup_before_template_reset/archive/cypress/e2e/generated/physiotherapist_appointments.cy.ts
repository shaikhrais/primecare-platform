describe('PhysiotherapistAppointmentsScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/physiotherapist/appointments');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="physiotherapist_appointments-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
