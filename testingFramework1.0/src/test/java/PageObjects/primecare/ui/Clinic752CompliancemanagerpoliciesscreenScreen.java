package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic752CompliancemanagerpoliciesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 752;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_policies-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_policies-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_policies-content')]")
	private WebElement primaryContent;

    public Clinic752CompliancemanagerpoliciesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic752CompliancemanagerpoliciesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic752CompliancemanagerpoliciesscreenScreen", "/generated/compliance-manager-policies");
    }
}

