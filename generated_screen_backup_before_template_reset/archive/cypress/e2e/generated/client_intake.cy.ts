describe('ClientIntakeScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/intake_coordinator/client-intake');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="client_intake-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
