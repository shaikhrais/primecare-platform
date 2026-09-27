package primecare.testing.pages;

import org.openqa.selenium.WebDriver;

public class PageFactoryService {
    public static DynamicScreen createPage(WebDriver driver, String screenKey) {
        return PageObjectRegistry.getPage(driver, screenKey);
    }
}
