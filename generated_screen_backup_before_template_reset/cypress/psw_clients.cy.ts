describe('My Clients E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/psw/patient-profile');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="psw_clients-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
