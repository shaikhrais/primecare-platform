describe('PhysiotherapistCommandCenterScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/physiotherapist/command-center');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="physiotherapist_command_center-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
