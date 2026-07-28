package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic682UnknowndashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 682;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'unknown_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'unknown_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'unknown_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'unknowndashboardscreen-screen')]")
	private WebElement unknowndashboardscreenScreen;

    public Clinic682UnknowndashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic682UnknowndashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic682UnknowndashboardscreenScreen", "/generated/unknown-dashboard");
    }
}

