describe('OfferManagementScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/staff/offer-management');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="offer_management-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
