package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client84VolunteercoordinatordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 84;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatordashboard-content')]")
	private WebElement volunteercoordinatordashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatordashboard-screen')]")
	private WebElement volunteercoordinatordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatordashboard-btn-4')]")
	private WebElement volunteercoordinatordashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatordashboard-btn-5')]")
	private WebElement volunteercoordinatordashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatordashboard-title')]")
	private WebElement volunteercoordinatordashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatordashboard-btn-1')]")
	private WebElement volunteercoordinatordashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatordashboard-btn-2')]")
	private WebElement volunteercoordinatordashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatordashboard-btn-3')]")
	private WebElement volunteercoordinatordashboardBtn3;

    public Client84VolunteercoordinatordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client84VolunteercoordinatordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client84VolunteercoordinatordashboardscreenScreen", "/offices/corporate/roles/volunteer_coordinator/dashboard");
    }
}
