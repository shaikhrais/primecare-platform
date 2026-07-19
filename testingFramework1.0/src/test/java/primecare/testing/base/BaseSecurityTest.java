package primecare.testing.base;

public class BaseSecurityTest extends BaseUiTest {
    // Shared security/RBAC testing helpers
    protected void loginAsRole(String role) {
        String email = appProps.getProperty("username." + role.toLowerCase(), role.toLowerCase() + "@primecare.com");
        String password = appProps.getProperty("password." + role.toLowerCase(), "Password123");
        
        driver.get(appProps.getProperty("login.url", "http://localhost:8080/login"));
        pageRecovery.openRequestedPage(
            appProps.getProperty("success.url", "http://localhost:8080/success"),
            org.openqa.selenium.By.xpath("//*[contains(@aria-label, 'topbar-logout-button')]"),
            "Dashboard Success",
            email,
            password
        );
    }
}
