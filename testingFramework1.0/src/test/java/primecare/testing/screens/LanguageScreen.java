package primecare.testing.screens;

import primecare.testing.pages.BasePage;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class LanguageScreen extends BasePage {

    public LanguageScreen() {
        super();
    }

    public LanguageScreen(WebDriver driver) {
        super(driver);
    }

    public void selectEnglish() {
        waitForClickable(By.xpath("//*[@aria-label='lang-english']")).click();
    }

    public void selectFrench() {
        waitForClickable(By.xpath("//*[@aria-label='lang-french']")).click();
    }
}

