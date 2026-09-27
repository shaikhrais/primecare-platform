describe('Psw Check In E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/psw-check-in');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="psw_check_in-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
