package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic19PhysiciandashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 19;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiciandashboard-btn-1')]")
	private WebElement physiciandashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiciandashboard-title')]")
	private WebElement physiciandashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiciandashboard-screen')]")
	private WebElement physiciandashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiciandashboard-btn-2')]")
	private WebElement physiciandashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiciandashboard-loading')]")
	private WebElement physiciandashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiciandashboard-btn-3')]")
	private WebElement physiciandashboardBtn3;

    public Clinic19PhysiciandashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic19PhysiciandashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic19PhysiciandashboardscreenScreen", "/clinical/physician-dashboard");
    }
}
