describe('ExercisePrescriptionScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/physiotherapist/exercise-prescription');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="exercise_prescription-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
