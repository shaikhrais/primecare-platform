package primecare.testing.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.JavascriptExecutor;
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

    private WebElement findElementUsingJs(By locator) {
        String locStr = locator.toString();
        String val = extractVal(locStr);
        System.out.println("[DEBUG JS FINDER] locStr: " + locStr + " | extracted val: " + val);
        if (val == null) {
            return getSearchContext(locator).findElement(locator);
        }
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            WebElement element = (WebElement) js.executeScript(
                "var findSemanticElement = function(root, val) { " +
                "    if (!root) return null; " +
                "    var selectors = [ " +
                "        \"[aria-label='\" + val + \"']\", " +
                "        \"[aria-label*='\" + val + \"']\", " +
                "        \"[data-cy='\" + val + \"']\", " +
                "        \"[id='\" + val + \"']\", " +
                "        \"[name='\" + val + \"']\" " +
                "    ]; " +
                "    for (var i = 0; i < selectors.length; i++) { " +
                "        try { " +
                "            var el = root.querySelector(selectors[i]); " +
                "            if (el) return el; " +
                "        } catch (e) {} " +
                "    } " +
                "    var all = root.querySelectorAll('*'); " +
                "    for (var i = 0; i < all.length; i++) { " +
                "        var child = all[i]; " +
                "        if (child.tagName.toLowerCase() === 'flt-semantics') { " +
                "            var txt = child.textContent || ''; " +
                "            if (txt.trim().startsWith(val) || txt.trim().includes(val)) { " +
                "                return child; " +
                "            } " +
                "        } " +
                "        if (child.shadowRoot) { " +
                "            var found = findSemanticElement(child.shadowRoot, val); " +
                "            if (found) return found; " +
                "        } " +
                "    } " +
                "    return null; " +
                "}; " +
                "return findSemanticElement(document, arguments[0]);",
                val
            );
            System.out.println("[DEBUG JS FINDER] js execution result: " + (element != null ? "FOUND" : "NULL"));
            if (element == null) {
                throw new org.openqa.selenium.NoSuchElementException("Could not locate semantic element for value: " + val);
            }
            return element;
        } catch (Exception e) {
            System.out.println("[DEBUG JS FINDER] exception: " + e.getMessage());
            return getSearchContext(locator).findElement(locator);
        }
    }

    private String extractVal(String locStr) {
        int firstQuote = locStr.indexOf("'");
        if (firstQuote != -1) {
            int secondQuote = locStr.indexOf("'", firstQuote + 1);
            if (secondQuote != -1) {
                return locStr.substring(firstQuote + 1, secondQuote);
            }
        }
        int firstDoubleQuote = locStr.indexOf("\"");
        if (firstDoubleQuote != -1) {
            int secondDoubleQuote = locStr.indexOf("\"", firstDoubleQuote + 1);
            if (secondDoubleQuote != -1) {
                return locStr.substring(firstDoubleQuote + 1, secondDoubleQuote);
            }
        }
        return null;
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
                return findElementUsingJs(locator);
            } catch (Exception e) {
                return null;
            }
        });
    }

    protected WebElement waitForClickable(By locator) {
        return wait.until(webDriver -> {
            try {
                WebElement element = findElementUsingJs(locator);
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
            WebElement el = findElementUsingJs(locator);
            return el != null && el.isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }
}
