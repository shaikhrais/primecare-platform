describe('StaffPerformanceScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/clinical_director/staff-performance');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="staff_performance-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
