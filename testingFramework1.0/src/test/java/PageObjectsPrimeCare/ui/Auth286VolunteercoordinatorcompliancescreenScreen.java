package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth286VolunteercoordinatorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 286;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorcompliance-title')]")
	private WebElement volunteercoordinatorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorcompliance-content')]")
	private WebElement volunteercoordinatorcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorcompliance-btn-1')]")
	private WebElement volunteercoordinatorcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorcompliance-btn-2')]")
	private WebElement volunteercoordinatorcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorcompliance-btn-3')]")
	private WebElement volunteercoordinatorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorcompliance-screen')]")
	private WebElement volunteercoordinatorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorcompliance-btn-4')]")
	private WebElement volunteercoordinatorcomplianceBtn4;

    public Auth286VolunteercoordinatorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth286VolunteercoordinatorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth286VolunteercoordinatorcompliancescreenScreen", "/staff/volunteer-coordinator-compliance");
    }
}
