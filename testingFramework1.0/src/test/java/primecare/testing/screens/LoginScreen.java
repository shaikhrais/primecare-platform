package primecare.testing.screens;

import primecare.testing.pages.BasePage;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class LoginScreen extends BasePage {

    public LoginScreen() {
        super();
    }

    public LoginScreen(WebDriver driver) {
        super(driver);
    }

    public void enterEmail(String email) {
        // Locate elements via Flutter Web Semantics (aria-label attribute)
        org.openqa.selenium.WebElement element = waitForVisible(By.xpath("//*[@aria-label='login-email']"));
        element.clear();
        element.sendKeys(email);
    }

    public void enterPassword(String password) {
        org.openqa.selenium.WebElement element = waitForVisible(By.xpath("//*[@aria-label='login-password']"));
        element.clear();
        element.sendKeys(password);
    }

    public void clickLogin() {
        waitForClickable(By.xpath("//*[@aria-label='login-submit']")).click();
    }
}

