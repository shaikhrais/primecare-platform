package primecare.testing.framework;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.util.List;

public class PlaceholderDetectionService {

    public static boolean isPlaceholderPage(WebDriver driver) {
        String pageSource = driver.getPageSource().toLowerCase();
        
        // Key phrases signaling placeholder pages
        String[] signs = {
            "under construction",
            "page placeholder",
            "coming soon",
            "todo: implement",
            "lorem ipsum"
        };

        for (String sign : signs) {
            if (pageSource.contains(sign)) {
                System.out.println("[PLACEHOLDER DETECTED] Found text indicator: " + sign);
                return true;
            }
        }

        // Checking common empty templates or unrendered React/Flutter elements
        List<WebElement> elements = driver.findElements(By.xpath("//div[contains(@class, 'placeholder') or contains(@class, 'skeleton')]"));
        if (!elements.isEmpty()) {
            System.out.println("[PLACEHOLDER DETECTED] Found skeleton/placeholder class elements.");
            return true;
        }

        return false;
    }
}

