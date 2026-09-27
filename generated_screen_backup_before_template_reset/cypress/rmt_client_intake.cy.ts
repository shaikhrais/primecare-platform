describe('RmtClientIntakeScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/rmt/client-intake');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="rmt_client_intake-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
