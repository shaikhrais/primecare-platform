package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic911GovernedScreen extends baseTest {
 
    public static final int SCREEN_ID = 911;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governed-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governed-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governed-content')]")
	private WebElement primaryContent;

    public Clinic911GovernedScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic911GovernedScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic911GovernedScreen", "/generated/governed");
    }
}

