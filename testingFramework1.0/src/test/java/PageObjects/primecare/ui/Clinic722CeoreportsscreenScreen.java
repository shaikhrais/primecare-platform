package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic722CeoreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 722;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceoreportsscreen-screen')]")
	private WebElement ceoreportsscreenScreen;

    public Clinic722CeoreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic722CeoreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic722CeoreportsscreenScreen", "/offices/corporate/roles/ceo/reports");
    }
}

