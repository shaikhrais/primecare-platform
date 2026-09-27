package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic746CompliancemanagerauditsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 746;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_audits-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_audits-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_audits-content')]")
	private WebElement primaryContent;

    public Clinic746CompliancemanagerauditsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic746CompliancemanagerauditsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic746CompliancemanagerauditsscreenScreen", "/generated/compliance-manager-audits");
    }
}

