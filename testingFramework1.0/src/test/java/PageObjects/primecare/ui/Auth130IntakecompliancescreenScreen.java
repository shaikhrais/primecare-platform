package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth130IntakecompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 130;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecompliance-btn-1')]")
	private WebElement intakecomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecompliance-loading')]")
	private WebElement intakecomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecompliance-title')]")
	private WebElement intakecomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecompliance-screen')]")
	private WebElement intakecomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecompliance-btn-3')]")
	private WebElement intakecomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecompliance-content')]")
	private WebElement intakecomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecompliance-btn-2')]")
	private WebElement intakecomplianceBtn2;

    public Auth130IntakecompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth130IntakecompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth130IntakecompliancescreenScreen", "/offices/clinical/roles/intake_coordinator/compliance");
    }
}

