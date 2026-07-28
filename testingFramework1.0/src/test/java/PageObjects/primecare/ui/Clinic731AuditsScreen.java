package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic731AuditsScreen extends baseTest {
 
    public static final int SCREEN_ID = 731;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audits-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audits-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audits-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'auditsscreen-screen')]")
	private WebElement auditsscreenScreen;

    public Clinic731AuditsScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic731AuditsScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic731AuditsScreen", "/offices/corporate/roles/compliance_manager/audits");
    }
}

