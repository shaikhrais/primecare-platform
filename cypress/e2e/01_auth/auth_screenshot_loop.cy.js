const users = require("../../fixtures/governance/test_users.json");

describe("Auth - Screenshot Loop All Roles & Sidebar Pages", () => {
  users.forEach((user) => {
    it(`captures screenshots for role: ${user.role_code}`, () => {
      // Log in as the role using the custom command defined in cypress/support/commands.js
      cy.loginAsRole(user.role_code);
      
      // Wait for rendering animations, charts, and layout to fully settle
      cy.wait(4000);
      
      // Capture dashboard screenshot
      cy.screenshot(`dashboard_${user.role_code}`, { capture: 'viewport' });
      
      // Dynamically capture the landing dashboard URL from GoRouter/Flutter redirect
      cy.url().then((dashboardUrl) => {
        cy.log(`Captured landing dashboard URL: ${dashboardUrl}`);
        
        // Find all sidebar buttons dynamically
        cy.get('body').then(($body) => {
          // Try multiple selectors to find the sidebar
          const sidebar = $body.find('[aria-label*="data-cy:app-sidebar"], [data-cy="app-sidebar"]');
          if (sidebar.length === 0) {
            cy.log("No sidebar found for this role/layout.");
            return;
          }
          
          // Find all semantic elements inside sidebar that act as buttons (role="button" or contains text)
          const buttons = sidebar.find('flt-semantics[role="button"]');
          if (buttons.length === 0) {
            cy.log("No clickable sidebar items found.");
            return;
          }
          
          const count = buttons.length;
          cy.log(`Found ${count} sidebar buttons.`);
          
          // Loop through each button by index
          for (let i = 0; i < count; i++) {
            // Re-query the buttons using the latest DOM state to prevent stale element references
            cy.get('[aria-label*="data-cy:app-sidebar"] flt-semantics[role="button"], [data-cy="app-sidebar"] flt-semantics[role="button"]')
              .eq(i)
              .then(($btn) => {
                const labelText = $btn.text().trim() || $btn.attr('aria-label') || `item_${i}`;
                const safeLabelText = labelText.toLowerCase().replace(/[^a-z0-9]+/g, '_');
                
                // Skip the dashboard/home buttons since we already screenshotted the dashboard landing page
                if (safeLabelText.includes('dashboard') || safeLabelText.includes('control_center') || safeLabelText.includes('home')) {
                  cy.log(`Skipping dashboard sidebar button: ${labelText}`);
                  return;
                }
                
                cy.log(`Clicking sidebar item ${i}: ${labelText}`);
                cy.wrap($btn).click({ force: true });
                cy.wait(4000);
                
                // Verify the page did not render blank
                cy.verifyNotBlank();
                
                // Capture screenshot for the subpage
                cy.screenshot(`sidebar_${user.role_code}_${safeLabelText}`, { capture: 'viewport' });
                
                // Go back to the dashboard using the captured URL to restore the sidebar state cleanly
                cy.visitWithSemantics(dashboardUrl);
                cy.wait(3000);
              });
          }
        });
      });
    });
  });
});
