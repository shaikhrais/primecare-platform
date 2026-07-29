package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic754CompliancemanagerriskregisterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 754;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_risk_register-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_risk_register-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_risk_register-content')]")
	private WebElement primaryContent;

    public Clinic754CompliancemanagerriskregisterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic754CompliancemanagerriskregisterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic754CompliancemanagerriskregisterscreenScreen", "/generated/compliance-manager-risk-register");
    }
}

