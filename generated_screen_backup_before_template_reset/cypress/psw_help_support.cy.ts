describe('Psw Help Support E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/psw-help-support');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="psw_help_support-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
