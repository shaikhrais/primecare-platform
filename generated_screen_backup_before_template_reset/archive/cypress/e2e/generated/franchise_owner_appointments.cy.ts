describe('FranchiseOwnerAppointmentsScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/franchise/roles/franchise_owner/appointments');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="franchise_owner_appointments-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
