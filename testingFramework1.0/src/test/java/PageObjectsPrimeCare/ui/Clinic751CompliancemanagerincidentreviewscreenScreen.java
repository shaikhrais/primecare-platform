package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic751CompliancemanagerincidentreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 751;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_incident_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_incident_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_incident_review-content')]")
	private WebElement primaryContent;

    public Clinic751CompliancemanagerincidentreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic751CompliancemanagerincidentreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic751CompliancemanagerincidentreviewscreenScreen", "/offices/corporate/roles/compliance_manager/incident-review");
    }
}
