// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - peer_review_conference_room", () => {
  it("opens and verifies screen peer_review_conference_room", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Peer Review Conference Room)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Peer Review Conference Room...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("peerreviewconferenceroom-screen").should("be.visible");
  cy.getCy("peerreviewconferenceroom-title").should("be.visible");
  cy.getCy("peerreviewconferenceroom-content").should("be.visible");
  cy.getCy("peerreview-btn-refresh").should("be.visible");
  cy.getCy("peerreview-btn-submit").should("be.visible");
  cy.getCy("peerreview-btn-join").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Peer Review Conference Room...");
  cy.waitAndSee();
  cy.screenshot("peer_review_conference_room");
  
  cy.task("log", "✅ PROGRESS: - Verified Peer Review Conference Room successfully!\n");

  });
});
