package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth621RegisterednursernfieldsupervisoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 621;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registered nurse (rn) field supervisor analytics-screen')]")
	private WebElement registerednursernfieldsupervisoranalyticsScreen;

    public Auth621RegisterednursernfieldsupervisoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth621RegisterednursernfieldsupervisoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth621RegisterednursernfieldsupervisoranalyticsscreenScreen", "/rn/rn-field-supervisor-analytics");
    }
}
