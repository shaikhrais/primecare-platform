describe('PhysiotherapistClientIntakeScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/physiotherapist/client-intake');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="physiotherapist_client_intake-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
