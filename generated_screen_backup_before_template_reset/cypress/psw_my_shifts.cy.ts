describe('Psw My Shifts E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/psw/psw-my-shifts');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="psw_my_shifts-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
