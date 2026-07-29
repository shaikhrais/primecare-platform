package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth280SchedulercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 280;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercompliance-screen')]")
	private WebElement schedulercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercompliance-title')]")
	private WebElement schedulercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercompliance-content')]")
	private WebElement schedulercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercompliance-btn-5')]")
	private WebElement schedulercomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercompliance-btn-3')]")
	private WebElement schedulercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercompliance-btn-2')]")
	private WebElement schedulercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercompliance-btn-4')]")
	private WebElement schedulercomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercompliance-btn-1')]")
	private WebElement schedulercomplianceBtn1;

    public Auth280SchedulercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth280SchedulercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth280SchedulercompliancescreenScreen", "/staff/scheduler-compliance");
    }
}

