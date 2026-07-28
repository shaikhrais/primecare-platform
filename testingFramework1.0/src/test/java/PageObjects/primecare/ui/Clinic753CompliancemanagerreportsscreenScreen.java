package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic753CompliancemanagerreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 753;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_reports-content')]")
	private WebElement primaryContent;

    public Clinic753CompliancemanagerreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic753CompliancemanagerreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic753CompliancemanagerreportsscreenScreen", "/offices/corporate/roles/compliance_manager/reports");
    }
}

