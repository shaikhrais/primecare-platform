package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic691InfectioncontroldashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 691;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infection_control_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infection_control_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infection_control_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infectioncontroldashboardscreen-screen')]")
	private WebElement infectioncontroldashboardscreenScreen;

    public Clinic691InfectioncontroldashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic691InfectioncontroldashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic691InfectioncontroldashboardscreenScreen", "/generated/infection-control-dashboard");
    }
}

