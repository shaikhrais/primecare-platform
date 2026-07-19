package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1010EpidemiologicalsurveillancedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1010;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'epidemiological_surveillance_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'epidemiological_surveillance_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'epidemiological_surveillance_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic1010EpidemiologicalsurveillancedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1010EpidemiologicalsurveillancedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1010EpidemiologicalsurveillancedashboardscreenScreen", "/generated/epidemiological-surveillance-dashboard");
    }
}
