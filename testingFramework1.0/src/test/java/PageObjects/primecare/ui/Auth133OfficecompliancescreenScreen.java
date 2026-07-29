package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth133OfficecompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 133;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officecompliance-content')]")
	private WebElement officecomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officecompliance-title')]")
	private WebElement officecomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officecompliance-screen')]")
	private WebElement officecomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officecompliance-loading')]")
	private WebElement officecomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officecompliance-btn-1')]")
	private WebElement officecomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officecompliance-btn-2')]")
	private WebElement officecomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officecompliance-btn-3')]")
	private WebElement officecomplianceBtn3;

    public Auth133OfficecompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth133OfficecompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth133OfficecompliancescreenScreen", "/common/office-compliance");
    }
}

