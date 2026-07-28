package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic834MonitoringScreen extends baseTest {
 
    public static final int SCREEN_ID = 834;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'monitoring-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'monitoring-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'monitoring-content')]")
	private WebElement primaryContent;

    public Clinic834MonitoringScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic834MonitoringScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic834MonitoringScreen", "/governance/monitoring");
    }
}

