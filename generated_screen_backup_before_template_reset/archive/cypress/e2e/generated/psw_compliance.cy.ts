describe('Psw Compliance E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/psw/help-support');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="psw_compliance-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
