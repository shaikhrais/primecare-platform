describe('Psw Client Profile E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/psw/profile');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="psw_client_profile-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
