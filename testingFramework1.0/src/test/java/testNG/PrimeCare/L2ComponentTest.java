package testNG.PrimeCare;

import primecare.testing.base.BaseUiTest;
import primecare.testing.framework.planning.Models.ScreenDefinition;
import primecare.testing.framework.planning.Models.UiComponentDefinition;
import primecare.testing.pages.DynamicScreen;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.database.Repositories.ScreenRepository;
import primecare.testing.framework.database.Repositories.ComponentRepository;
import primecare.testing.validation.TestLayer;
import org.openqa.selenium.By;
import org.testng.Assert;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import java.util.List;

@TestLayer(TestingLayerCode.L2)
public class L2ComponentTest extends BaseUiTest {

    DynamicScreen page;

    @DataProvider(name = "screens")
    public Object[][] getScreens() {
        List<ScreenDefinition> list = ScreenRepository.getScreens();
        Object[][] data = new Object[list.size()][1];
        for (int i = 0; i < list.size(); i++) {
            data[i][0] = list.get(i);
        }
        return data;
    }

    @Test(dataProvider = "screens", groups = {"l2", "smoke"})
    public void verifyUiComponents(ScreenDefinition screen) {
        System.out.println("[L2] Verifying UI components for screen: " + screen.screenKey);

        String base = null;
        try {
            primecare.testing.framework.planning.Models.ApplicationDefinition app = 
                primecare.testing.framework.database.Repositories.ApplicationRepository.getApplicationById(screen.applicationId);
            if (app != null && app.baseUrl != null && !app.baseUrl.isEmpty()) {
                base = app.baseUrl;
            }
        } catch (Exception e) {}
        if (base == null) {
            base = appProps.getProperty("APP_BASE_URL", "http://localhost:8080");
        }
        String targetUrl = base + screen.route;
        
        // Open the screen. PageRecovery will handle Language/Login pages if they appear.
        String email = appProps.getProperty("username.admin", "clinic@primecare.com");
        String password = appProps.getProperty("password.admin", "Password123");

        if (screen.requiredRole != null && !screen.requiredRole.isEmpty() && !"ANY".equalsIgnoreCase(screen.requiredRole)) {
            try {
                primecare.testing.framework.planning.Models.RoleDefinition rd = 
                    primecare.testing.framework.database.Repositories.RoleRepository.getRoleByKey(screen.requiredRole.trim().toUpperCase());
                if (rd != null && rd.testEmail != null && !rd.testEmail.isEmpty()) {
                    email = rd.testEmail;
                    password = (rd.testPassword != null && !rd.testPassword.isEmpty()) ? rd.testPassword : "Test@12345";
                }
            } catch (Exception e) {}
        }

        // Wait marker is usually the first component on the screen
        List<UiComponentDefinition> components = ComponentRepository.getComponentsForScreen(screen.screenId);
        if (components.isEmpty()) {
            System.out.println("[L2] No component definitions found for screen: " + screen.screenKey + ". Skipping.");
            return;
        }

        By marker = primecare.testing.pages.ComponentResolver.resolveLocator(components.get(0));
        pageRecovery.openRequestedPage(targetUrl, marker, screen.screenName, email, password);

        page = new DynamicScreen(screen.screenKey);
        for (UiComponentDefinition c : components) {
            System.out.println("  * Verifying component: " + c.componentKey + " (" + c.componentType + ")");
            
            boolean visible = page.isVisible(c.componentKey);
            if (c.visibleRequired) {
                Assert.assertTrue(visible, "Required component '" + c.componentKey + "' is not visible on screen '" + screen.screenKey + "'!");
            }

            if (c.enabledRequired && visible) {
                Assert.assertTrue(page.isEnabled(c.componentKey), "Component '" + c.componentKey + "' is visible but disabled!");
            }

            if (c.expectedText != null && visible) {
                String actualText = page.getText(c.componentKey);
                Assert.assertTrue(actualText.contains(c.expectedText), "Component '" + c.componentKey + "' text mismatch! Expected containing: \"" + c.expectedText + "\", Got: \"" + actualText + "\"");
            }
        }
        System.out.println("[L2] Component validation successful for screen: " + screen.screenKey);
    }
}
