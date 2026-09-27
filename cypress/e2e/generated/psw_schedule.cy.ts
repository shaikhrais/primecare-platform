describe('Psw Schedule E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/psw-schedule');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="psw_schedule-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
