package primecare.testing.pages;

import primecare.testing.framework.planning.Models.UiComponentDefinition;
import org.openqa.selenium.By;

public class ComponentResolver {

    public static By resolveLocator(UiComponentDefinition component) {
        String strategy = component.locatorStrategy != null ? component.locatorStrategy.toLowerCase().trim() : "";
        String val = component.locatorValue;

        switch (strategy) {
            case "id":
                return By.id(val);
            case "name":
                return By.name(val);
            case "css":
            case "cssselector":
                return By.cssSelector(val);
            case "xpath":
                return By.xpath(val);
            case "aria-label":
            case "arialabel":
                return By.xpath("//*[@aria-label='" + val + "' or starts-with(@aria-label, '" + val + "') or (self::flt-semantics and (text()='" + val + "' or starts-with(text(), '" + val + "')))]");
            case "data-cy":
            case "datacy":
                return By.xpath("//*[@data-cy='" + val + "' or @aria-label='" + val + "' or starts-with(@aria-label, '" + val + "') or (self::flt-semantics and (text()='" + val + "' or starts-with(text(), '" + val + "')))]");
            default:
                // Fallback: search by id, aria-label, data-cy, or flt-semantics text
                return By.xpath("//*[@id='" + val + "' or @aria-label='" + val + "' or starts-with(@aria-label, '" + val + "') or @data-cy='" + val + "' or (self::flt-semantics and (text()='" + val + "' or starts-with(text(), '" + val + "')))]");
        }
    }

    private static String cssEscape(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\").replace("'", "\\'");
    }
}
