package primecare.testing.pages;

import primecare.testing.framework.Models.ScreenDefinition;
import primecare.testing.framework.Models.UiComponentDefinition;
import primecare.testing.framework.Repositories.ScreenRepository;
import primecare.testing.framework.Repositories.ComponentRepository;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DynamicScreen extends BasePage {
    private final String screenKey;
    private final ScreenDefinition screenDefinition;
    private final Map<String, UiComponentDefinition> components = new HashMap<>();

    public DynamicScreen(String screenKey) {
        super();
        this.screenKey = screenKey;
        this.screenDefinition = ScreenRepository.getScreenByKey(screenKey);
        if (screenDefinition == null) {
            throw new RuntimeException("DefinitionNotFoundException: Screen definition not found for key: " + screenKey);
        }
        loadComponents();
    }

    public DynamicScreen(WebDriver driver, String screenKey) {
        super(driver);
        this.screenKey = screenKey;
        this.screenDefinition = ScreenRepository.getScreenByKey(screenKey);
        if (screenDefinition == null) {
            throw new RuntimeException("DefinitionNotFoundException: Screen definition not found for key: " + screenKey);
        }
        loadComponents();
    }

    private void loadComponents() {
        List<UiComponentDefinition> list = ComponentRepository.getComponentsForScreen(screenDefinition.screenId);
        for (UiComponentDefinition c : list) {
            components.put(c.componentKey.toLowerCase(), c);
        }
    }

    public UiComponentDefinition getComponentDefinition(String componentKey) {
        UiComponentDefinition comp = components.get(componentKey.toLowerCase());
        if (comp == null) {
            throw new RuntimeException("DefinitionNotFoundException: Component key '" + componentKey + "' not registered for screen: " + screenKey);
        }
        return comp;
    }

    public By getLocator(String componentKey) {
        return ComponentResolver.resolveLocator(getComponentDefinition(componentKey));
    }

    public WebElement findComponent(String componentKey) {
        By locator = getLocator(componentKey);
        UiComponentDefinition def = getComponentDefinition(componentKey);
        if (def.visibleRequired) {
            return waitForVisible(locator);
        } else {
            return waitForClickable(locator);
        }
    }

    public void click(String componentKey) {
        WebElement element = findComponent(componentKey);
        try {
            element.click();
        } catch (Exception e) {
            try {
                org.openqa.selenium.JavascriptExecutor js = (org.openqa.selenium.JavascriptExecutor) driver;
                js.executeScript(
                    "var el = arguments[0]; " +
                    "var mousedown = new MouseEvent('mousedown', { bubbles: true, cancelable: true, view: window }); " +
                    "var mouseup = new MouseEvent('mouseup', { bubbles: true, cancelable: true, view: window }); " +
                    "var click = new MouseEvent('click', { bubbles: true, cancelable: true, view: window }); " +
                    "el.dispatchEvent(mousedown); " +
                    "el.dispatchEvent(mouseup); " +
                    "el.dispatchEvent(click);", 
                    element
                );
            } catch (Exception jsEx) {
                throw new RuntimeException("Failed to click element: " + componentKey, jsEx);
            }
        }
    }

    public void type(String componentKey, String value) {
        WebElement element = findComponent(componentKey);
        element.clear();
        element.sendKeys(value);
    }

    public String getText(String componentKey) {
        return findComponent(componentKey).getText();
    }

    public boolean isVisible(String componentKey) {
        try {
            By locator = getLocator(componentKey);
            return isElementDisplayed(locator);
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isEnabled(String componentKey) {
        try {
            return findComponent(componentKey).isEnabled();
        } catch (Exception e) {
            return false;
        }
    }

    public ScreenDefinition getScreenDefinition() {
        return screenDefinition;
    }
}

