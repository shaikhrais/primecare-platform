package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic925IntegrationhealthmonitorscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 925;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'integration_health_monitor-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'integration_health_monitor-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'integration_health_monitor-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'integration_health_monitor_outlinedbutton_button_1')]")
	private WebElement integrationHealthMonitorOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'integration_health_monitor_iconbutton_button_1')]")
	private WebElement integrationHealthMonitorIconbuttonButton1;

    public Clinic925IntegrationhealthmonitorscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic925IntegrationhealthmonitorscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic925IntegrationhealthmonitorscreenScreen", "/generated/integration-health-monitor");
    }
}

