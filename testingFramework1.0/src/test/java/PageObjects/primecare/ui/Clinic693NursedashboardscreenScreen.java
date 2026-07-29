package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic693NursedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 693;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursedashboardscreen-screen')]")
	private WebElement nursedashboardscreenScreen;

    public Clinic693NursedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic693NursedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic693NursedashboardscreenScreen", "/generated/nurse-dashboard");
    }
}

