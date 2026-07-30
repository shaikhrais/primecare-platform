package primecare.testing.base;

import primecare.testing.framework.DatabaseConfig;

public class BaseSecurityTest extends BaseUiTest {
    // Shared security/RBAC testing helpers
    protected void loginAsRole(String role) {
        String roleLower = role != null ? role.toLowerCase() : "admin";
        String email = appProps.getProperty("username." + roleLower, roleLower + "@primecare.com");
        String password = appProps.getProperty("password." + roleLower, "Password123");
        
        String authBase = DatabaseConfig.getAuthUrl();
        String loginUrl = DatabaseConfig.ensureSemanticsUrl(authBase + "/login?clientId=primecare-clinic");
        
        System.out.println("  [RBAC AUTH] Authenticating role '" + role + "' at Login URL: " + loginUrl);
        driver.get(loginUrl);
        try { Thread.sleep(2000); } catch (Exception ignored) {}

        try {
            org.openqa.selenium.JavascriptExecutor js = (org.openqa.selenium.JavascriptExecutor) driver;
            js.executeScript(
                "var fill = function(label, val) { var el = document.querySelector('[aria-label*=\"' + label + '\"]'); if (el) { el.value = val; el.dispatchEvent(new Event('input', {bubbles:true})); } }; " +
                "fill('login-email', '" + email + "'); " +
                "fill('login-password', '" + password + "'); " +
                "var btn = document.querySelector('[aria-label*=\"login-submit\"]'); if (btn) btn.click();"
            );
            Thread.sleep(3000);
        } catch (Exception ignored) {}
    }
}
