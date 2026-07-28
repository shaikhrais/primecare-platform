package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic732CompliancecasesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 732;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_cases-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_cases-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_cases-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancecasesscreen-screen')]")
	private WebElement compliancecasesscreenScreen;

    public Clinic732CompliancecasesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic732CompliancecasesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic732CompliancecasesscreenScreen", "/offices/corporate/roles/compliance_manager/compliance-cases");
    }
}

