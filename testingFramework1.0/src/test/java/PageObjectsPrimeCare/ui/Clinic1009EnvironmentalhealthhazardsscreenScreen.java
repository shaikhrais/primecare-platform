package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1009EnvironmentalhealthhazardsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1009;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'environmental_health_hazards-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'environmental_health_hazards-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'environmental_health_hazards-content')]")
	private WebElement primaryContent;

    public Clinic1009EnvironmentalhealthhazardsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1009EnvironmentalhealthhazardsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1009EnvironmentalhealthhazardsscreenScreen", "/generated/environmental-health-hazards");
    }
}
