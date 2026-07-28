package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic729CforeportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 729;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cforeportsscreen-screen')]")
	private WebElement cforeportsscreenScreen;

    public Clinic729CforeportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic729CforeportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic729CforeportsscreenScreen", "/offices/corporate/roles/cfo/reports");
    }
}

