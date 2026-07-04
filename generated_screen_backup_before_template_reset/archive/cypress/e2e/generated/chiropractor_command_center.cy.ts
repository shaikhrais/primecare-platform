describe('ChiropractorCommandCenterScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/chiropractor/command-center');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="chiropractor_command_center-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
