package primecare.testing.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

public class BasePage {
    protected final WebDriver driver;
    protected final WebDriverWait wait;

    public BasePage() {
        this.driver = base.baseTest.driver;
        this.wait = new WebDriverWait(this.driver, Duration.ofSeconds(10));
    }

    public BasePage(WebDriver driver) {
        this.driver = driver;
        this.wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }

    private org.openqa.selenium.SearchContext getSearchContext(By locator) {
        if (locator instanceof By.ByXPath) {
            return driver;
        }
        String locStr = locator.toString().toLowerCase();
        if (locStr.contains("flt-semantics") || locStr.contains("aria-label") || locStr.contains("data-cy") || locStr.contains("lang-") || locStr.contains("language-")) {
            return driver;
        }
        try {
            java.util.List<WebElement> hosts = driver.findElements(By.cssSelector("flutter-view"));
            if (!hosts.isEmpty()) {
                return hosts.get(0).getShadowRoot();
            }
            java.util.List<WebElement> panes = driver.findElements(By.cssSelector("flt-glass-pane"));
            if (!panes.isEmpty()) {
                return panes.get(0).getShadowRoot();
            }
        } catch (Exception e) {
            // Fallback
        }
        return driver;
    }

    protected WebElement waitForVisible(By locator) {
        return wait.until(webDriver -> {
            try {
                return getSearchContext(locator).findElement(locator);
            } catch (Exception e) {
                return null;
            }
        });
    }

    protected WebElement waitForClickable(By locator) {
        return wait.until(webDriver -> {
            try {
                WebElement element = getSearchContext(locator).findElement(locator);
                if (element.isEnabled()) {
                    return element;
                }
            } catch (Exception e) {
                // Ignore and retry
            }
            return null;
        });
    }

    protected boolean isElementDisplayed(By locator) {
        try {
            getSearchContext(locator).findElement(locator);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
