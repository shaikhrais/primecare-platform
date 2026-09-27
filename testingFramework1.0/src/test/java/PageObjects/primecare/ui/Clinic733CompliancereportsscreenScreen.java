package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic733CompliancereportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 733;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancereportsscreen-screen')]")
	private WebElement compliancereportsscreenScreen;

    public Clinic733CompliancereportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic733CompliancereportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic733CompliancereportsscreenScreen", "/generated/compliance-reports");
    }
}

