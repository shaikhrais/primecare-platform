package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth271IntakecoordinatorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 271;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorcompliance-title')]")
	private WebElement intakecoordinatorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorcompliance-btn-1')]")
	private WebElement intakecoordinatorcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorcompliance-screen')]")
	private WebElement intakecoordinatorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorcompliance-content')]")
	private WebElement intakecoordinatorcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorcompliance-btn-3')]")
	private WebElement intakecoordinatorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorcompliance-btn-2')]")
	private WebElement intakecoordinatorcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorcompliance-btn-4')]")
	private WebElement intakecoordinatorcomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorcompliance-btn-5')]")
	private WebElement intakecoordinatorcomplianceBtn5;

    public Auth271IntakecoordinatorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth271IntakecoordinatorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth271IntakecoordinatorcompliancescreenScreen", "/offices/clinical/roles/intake_coordinator/coordinator-compliance");
    }
}
