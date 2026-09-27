describe('ChiropractorClientIntakeScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/chiropractor/client-intake');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="chiropractor_client_intake-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
