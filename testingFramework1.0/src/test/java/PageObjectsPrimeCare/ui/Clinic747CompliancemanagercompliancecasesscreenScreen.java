package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic747CompliancemanagercompliancecasesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 747;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_compliance_cases-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_compliance_cases-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_compliance_cases-content')]")
	private WebElement primaryContent;

    public Clinic747CompliancemanagercompliancecasesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic747CompliancemanagercompliancecasesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic747CompliancemanagercompliancecasesscreenScreen", "/generated/compliance-manager-compliance-cases");
    }
}
