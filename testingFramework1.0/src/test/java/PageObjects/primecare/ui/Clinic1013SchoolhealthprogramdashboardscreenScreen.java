package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1013SchoolhealthprogramdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1013;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'school_health_program_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'school_health_program_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'school_health_program_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic1013SchoolhealthprogramdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1013SchoolhealthprogramdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1013SchoolhealthprogramdashboardscreenScreen", "/generated/school-health-program-dashboard");
    }
}

