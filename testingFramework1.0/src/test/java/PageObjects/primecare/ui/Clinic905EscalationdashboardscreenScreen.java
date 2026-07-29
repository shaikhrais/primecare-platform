package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic905EscalationdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 905;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'escalation_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'escalation_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'escalation_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic905EscalationdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic905EscalationdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic905EscalationdashboardscreenScreen", "/support/escalation-dashboard");
    }
}

