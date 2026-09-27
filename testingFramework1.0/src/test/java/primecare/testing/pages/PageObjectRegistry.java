package primecare.testing.pages;

import org.openqa.selenium.WebDriver;
import java.util.HashMap;
import java.util.Map;

public class PageObjectRegistry {
    private static final Map<String, DynamicScreen> activePages = new HashMap<>();

    public static DynamicScreen getPage(WebDriver driver, String screenKey) {
        if (!activePages.containsKey(screenKey)) {
            activePages.put(screenKey, new DynamicScreen(driver, screenKey));
        }
        return activePages.get(screenKey);
    }

    public static void clearRegistry() {
        activePages.clear();
    }
}
